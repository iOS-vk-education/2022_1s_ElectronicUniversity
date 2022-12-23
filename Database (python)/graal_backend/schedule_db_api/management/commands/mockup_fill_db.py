from django.core.management.base import BaseCommand
from schedule_db_api.models import *
from django.conf import settings
from django.core.files import File
import random
from datetime import datetime, timedelta


class Command(BaseCommand):
    help = "fills db with mockup data"

    def add_arguments(self, parser):
        parser.add_argument("ratio", nargs=1, type=int)

    def handle(self, *args, **options):
        ratio = int(options["ratio"][0])

        tmp = StudyStream(semester=3, specialty="Программная инженерия", faculty="ИУ7")
        tmp.save()
        tmp2 = Subject(name="Дискретная математика", stream=tmp)
        tmp2.save()
        tmp3 = Place(name="218л", building="ULK")
        tmp3.save()
        tmp4 = Teacher(familyName="Белоусов", forename="Алексей", fatherName="Иванович")
        tmp4.save()
        tmp4.study_streams.add(tmp)
        tmp4.save()

        groups = []
        for i in range(ratio):
            groups.append(self.group_generator(i))
        Group.objects.bulk_create(groups)
        del groups
        lessons = []
        for i in range(ratio // 2):
            lessons.append(self.lesson_generator(i))
        Lesson.objects.bulk_create(lessons)

        for i in range(ratio // 2):
            self.lesson_manytomany_linker(i)

    def group_generator(self, i):
        return Group(name="ИУ7-3{}Б".format(i), stream=StudyStream.objects.get(specialty="Программная инженерия"))

    def lesson_generator(self, i):
        tmp = Lesson(subject=Subject.objects.get(name="Дискретная математика"),
                     place=Place.objects.get(name="218л"),
                     start_time=datetime.now(),
                     end_time=(datetime.now() + timedelta(hours=1)),
                     lesson_type="LEC")
        return tmp

    def lesson_manytomany_linker(self, i):
        lesson = Lesson.objects.get(id=(i + 1))
        groups = [Group.objects.get(name="ИУ7-3{}Б".format(i * 2)),
                  Group.objects.get(name="ИУ7-3{}Б".format(i * 2 + 1))]
        teacher = Teacher.objects.get(familyName="Белоусов")
        teacher.lesson_set.add(lesson)
        teacher.save()
        for group in groups:
            lesson.groups.add(group)
        lesson.save()
