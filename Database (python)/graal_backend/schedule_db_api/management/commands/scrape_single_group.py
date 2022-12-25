import datetime
from django.utils import timezone
from django.core.management.base import BaseCommand
import requests
from bs4 import BeautifulSoup
from schedule_db_api.models import *
from django.db import *


def convert_time_to_minutes_from_midnight(str):
    if "." in str:
        data = str.split(".")
    elif ":" in str:
        data = str.split(":")
    else:
        raise Exception
    ans = int(data[0]) * 60 + int(data[1])
    return ans


def decode_lesson_cell(lesson_cell):
    cell = lesson_cell.contents

    # удаление пустых
    i = 0
    while i < len(cell):
        if cell[i] == " " or cell[i] == "  ":
            del cell[i]
            i -= 1
        i += 1

    if len(cell) == 0:
        return None  # окно
    else:
        ans = {}
        type_of_lesson = cell[0].contents[0]
        if type_of_lesson == "Самостоятельная работа":
            return None
        elif type_of_lesson == "ВУЦ":
            cabinet = cell[1].contents[0]
            if len(cabinet) != 0:
                cabinet = cabinet.strip()
            else:
                cabinet = None
            name_of_subject = "ВУЦ"
            teacher = None
            ans = {"type": type_of_lesson, "subject": name_of_subject, "cabinet": cabinet, "teacher": teacher}
        elif "Измайлово" in str(type_of_lesson):
            data = cell[0].contents[0].split()
            type_of_lesson = "сем"
            name_of_subject = "Физическая культура и спорт"
            teacher = None
            cabinet = "Измайлово"
            ans = {"type": type_of_lesson, "subject": name_of_subject, "cabinet": cabinet, "teacher": teacher,
                   "start_time": convert_time_to_minutes_from_midnight(data[1])}
        else:
            try:
                name_of_subject = cell[1].contents[0]
                cabinet = cell[2].contents[0]
                if len(cabinet) != 0:
                    cabinet = cabinet.strip()
                teacher = cell[3].contents
                if len(teacher) != 0:
                    teacher = teacher[0]
                else:
                    teacher = None
                type_of_lesson = type_of_lesson[1:-1]
                ans = {"type": type_of_lesson, "subject": name_of_subject, "cabinet": cabinet, "teacher": teacher}
            except IndexError:
                if "КР" in str(type_of_lesson) or "КП" in str(type_of_lesson):
                    data = cell[0].contents[0].split()
                    type_of_lesson = data[0]
                    name_of_subject = ""
                    for part in data[1:]:
                        name_of_subject += part + " "
                    name_of_subject.strip()
                    cabinet = cell[1].contents[0].strip()
                    try:
                        teacher = cell[3].contents[0].strip()
                    except IndexError:
                        teacher = None
                    ans = {"type": type_of_lesson, "subject": name_of_subject, "cabinet": cabinet, "teacher": teacher}
                elif "УТП" in str(type_of_lesson):
                    data = cell[0].contents[0].split()
                    type_of_lesson = data[0]
                    name_of_subject = cell[0].contents[0]
                    cabinet = cell[1].contents[0].strip()
                    try:
                        teacher = cell[2].contents[0].strip()
                    except IndexError:
                        teacher = None
                    ans = {"type": type_of_lesson, "subject": name_of_subject, "cabinet": cabinet, "teacher": teacher}
                else:
                    print("error:", cell)
                    type_of_lesson = "сем"
                    name_of_subject = cell[0].contents[0]
                    cabinet = cell[1].contents[0].strip()
                    try:
                        teacher = cell[2].contents[0].strip()
                    except IndexError:
                        teacher = None
                    ans = {"type": type_of_lesson, "subject": name_of_subject, "cabinet": cabinet, "teacher": teacher}
                    print("result:", ans)
    return ans


def decode_lesson(lesson_found):
    ans = None
    tds = lesson_found.find_all("td")
    if len(tds) == 2:
        less_1 = decode_lesson_cell(tds[1])
        if less_1 is not None:
            less_1["repeatance"] = "по числителям"
            ans = [less_1]
            less_2 = less_1.copy()
            less_2["repeatance"] = "по знаменателям"
            ans.append(less_2)
    else:
        less_1 = decode_lesson_cell(tds[1])
        less_2 = decode_lesson_cell(tds[2])
        if less_1 is not None or less_2 is not None:
            ans = []
            if less_1 is not None:
                less_1["repeatance"] = "по числителям"
                ans.append(less_1)
            if less_2 is not None:
                less_2["repeatance"] = "по знаменателям"
                ans.append(less_2)
    if ans is not None:
        time_raw = tds[0].contents[0]
        time = time_raw.strip().split()
        for lesson in ans:
            if "start_time" not in lesson:
                lesson["start_time"] = convert_time_to_minutes_from_midnight(time[0])
            lesson["end_time"] = lesson["start_time"] + 95
    return ans


def scrape_group(group_name_and_url):
    url = group_name_and_url[1]
    name = group_name_and_url[0]
    r = requests.get(url)
    soup = BeautifulSoup(r.content, "html5lib")
    tables = soup.find_all(class_="table-responsive")
    ans = {}
    monday_table = tables[0]
    tuesday_table = tables[1]
    wednesday_table = tables[2]
    thursday_table = tables[3]
    friday_table = tables[4]
    saturday_table = tables[5]
    week_tables = [monday_table, tuesday_table, wednesday_table, thursday_table, friday_table, saturday_table]
    for table in week_tables:
        lessons_found = table.find_all("tr")
        day_data = {}
        for i in range(len(lessons_found)):
            lesson_found = lessons_found[i]
            if i == 0:
                day = lesson_found.contents[1].contents[0].contents[0]
            elif i != 1:
                lesson_list = decode_lesson(lesson_found)
                if lesson_list is not None:
                    day_data[i - 1] = lesson_list
        if len(day_data) != 0:
            ans[day] = day_data
    ans = {"group_name": name, "data": ans}
    return ans


def decide_semester_and_study_level(name_parts):
    study_level = None
    if "Б" in name_parts[1]:
        study_level = "BACHELOR"
    elif "М" in name_parts[1]:
        study_level = "MASTER"
    elif "А" in name_parts[1]:
        study_level = "POSTGRADUATE"
    else:
        study_level = "SPECIALIST"
    if study_level != "SPECIALIST":
        name_parts[1] = name_parts[1][:-1]
    group_seq = name_parts[1][-1]
    semester = int(name_parts[1][:-1])
    print(name_parts, study_level, semester, group_seq)
    return (semester, study_level)


def get_offset_from_monday_midnight(str) -> int:
    if str == "ПН":
        return 0
    elif str == "ВТ":
        return 24 * 60 * 60 * 1
    elif str == "СР":
        return 24 * 60 * 60 * 2
    elif str == "ЧТ":
        return 24 * 60 * 60 * 3
    elif str == "ПТ":
        return 24 * 60 * 60 * 4
    elif str == "СБ":
        return 24 * 60 * 60 * 5


def decide_if_place_is_generic(str_in) -> bool:
    return "каф" in str_in or "Измайлово" in str_in


def decide_week_offset(str_in) -> int:
    if str_in == "по знаменателям":
        return 7 * 24 * 60 * 60
    else:
        return 0

def decide_lesson_type(str_in) -> str:
    if str_in == "лек":
        return "LEC"
    elif str_in == "ВУЦ":
        return "VUC"
    elif str_in == "сем":
        return "SEM"
    elif str_in == "УТП":
        return "PRACTICE"
    elif str_in == "лаб":
        return "LAB"
    elif str_in == "КР":
        return "SEM"
    else:
        return "SEM"


def time_calc(semester_start, semester_week_offset, offset_from_monday_midnight, week_offset, time_from_day_start) -> datetime.datetime:
    return semester_start + datetime.timedelta(seconds=(semester_week_offset + offset_from_monday_midnight + week_offset + time_from_day_start * 60))


def get_semester_start():
    now_sc = timezone.now()
    return datetime.datetime(now_sc.year, 8, 29)


def get_semester_end():
    return get_semester_start() + datetime.timedelta(days=(7*18)) # 18 недель


def upload_group_data(group_data):
    name_parts = group_data["group_name"].split("-")

    semester, study_level = decide_semester_and_study_level(name_parts)
    faculty = name_parts[0]
    semester_start = get_semester_start()
    semester_end = get_semester_end()
    stream, _ = StudyStream.objects.get_or_create(semester=semester, faculty=faculty, study_level=study_level, semester_start=semester_start, semester_end=semester_end)
    group, _ = Group.objects.get_or_create(name=group_data["group_name"], stream=stream)
    for i in range(9):
        semester_week_offset = i * 14 * 24 * 60 * 60  # сразу две недели обрабатываем
        for day_key in group_data["data"].keys():  # итерируемся по дням недели
            offset_from_monday_midnight = get_offset_from_monday_midnight(day_key)
            for pair_num in group_data["data"][day_key].keys():  # итерируемся по занятием внутри дня
                data_list = group_data["data"][day_key][pair_num] # внутри две пары, если мигаюшая с заменой(не окном) или не мигающая
                print(data_list)
                for lesson_data in data_list:
                    week_offset = decide_week_offset(lesson_data["repeatance"])
                    start_time = time_calc(semester_start, semester_week_offset, offset_from_monday_midnight, week_offset, lesson_data["start_time"])
                    end_time = time_calc(semester_start, semester_week_offset, offset_from_monday_midnight, week_offset, lesson_data["end_time"])
                    lesson_type = decide_lesson_type(lesson_data["type"])
                    subject_name = lesson_data["subject"]
                    subject, _ = Subject.objects.get_or_create(name=subject_name, stream=stream)
                    cabinet_name = lesson_data["cabinet"]
                    cabinet, _ = Place.objects.get_or_create(name=cabinet_name,
                                                          is_generic=decide_if_place_is_generic(cabinet_name))
                    teacher_name = lesson_data["teacher"]
                    if teacher_name is not None:
                        teacher, _ = Teacher.objects.get_or_create(display_name=teacher_name)
                        teacher.study_streams.add(stream)
                    else:
                        teacher = None
                    lesson, _ = Lesson.objects.get_or_create(subject=subject, place=cabinet, teacher=teacher,
                                                          pair_num=pair_num, lesson_type=lesson_type,
                                                          start_time=start_time, end_time=end_time)
                    lesson.groups.add(group)
                    lesson.save()


class Command(BaseCommand):
    help = "loads single group in db"
    def add_arguments(self, parser):
        parser.add_argument("group_name", nargs=1, type=str)
        parser.add_argument("url", nargs=1, type=str)

    def handle(self, *args, **options):
        group_name = options["group_name"][0]
        url = options["url"][0]
        upload_group_data(scrape_group([group_name, url]))
