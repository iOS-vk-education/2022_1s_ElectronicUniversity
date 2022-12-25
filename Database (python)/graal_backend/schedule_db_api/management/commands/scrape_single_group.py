import requests
from bs4 import BeautifulSoup


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
        type_of_lesson = cell[0].contents[0]
        if type_of_lesson == "Самостоятельная работа":
            return None
        elif type_of_lesson == "ВУЦ":
            cabinet = cell[1].contents[0]
            if len(cabinet) != 0:
                cabinet = cabinet.strip()
            else:
                cabinet = None
            name_of_subject = None
            teacher = None
        else:
            type_of_lesson = type_of_lesson[1:-1]
            name_of_subject = cell[1].contents[0]
            cabinet = cell[2].contents[0]
            if len(cabinet) != 0:
                cabinet = cabinet.strip()
            teacher = cell[3].contents
            if len(teacher) != 0:
                teacher = teacher[0]
            else:
                teacher = None

        return {"type": type_of_lesson, "subject": name_of_subject, "cabinet": cabinet, "teacher": teacher}


def decode_lesson(lesson_found):
    ans = None
    tds = lesson_found.find_all("td")
    if len(tds) == 2:
        less_1 = decode_lesson_cell(tds[1])
        if less_1 is not None:
            less_1["repeatance"] = ["по числителям", "по знаменателям"]
            ans = [less_1]
    else:
        less_1 = decode_lesson_cell(tds[1])
        less_2 = decode_lesson_cell(tds[2])
        if less_1 is not None or less_2 is not None:
            ans = []
            if less_1 is not None:
                less_1["repeatance"] = ["по числителям"]
                ans.append(less_1)
            if less_2 is not None:
                less_2["repeatance"] = ["по знаменателям"]
                ans.append(less_2)
    if ans is not None:
        time_raw = tds[0].contents[0]
        time = time_raw.strip().split()
        for lesson in ans:
            lesson["start_time"] = time[0]
            lesson["end_time"] = time[2]
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
    return ans



def upload_group_data(group_data):
    pass


def main():
    r = requests.get(url)
    soup = BeautifulSoup(r.content, "html5lib")

    # print(r.content)


if __name__ == '__main__':
    url = "https://lks.bmstu.ru/schedule/a9910e6e-81ca-11eb-b2f4-005056960017"
    print(scrape_group(("ИУ7-35Б", url)))
