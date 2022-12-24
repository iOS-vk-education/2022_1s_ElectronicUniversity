from django.db import models


# Create your models here.


class StudyStream(models.Model):

    class StudyLevel(models.TextChoices):
        BACH = "BACHELOR"
        MAST = "MASTER"
        POSTGR = "POSTGRADUATE"

    semester = models.IntegerField()
    faculty = models.CharField(max_length=255)
    study_level = models.CharField(max_length=12, choices=StudyLevel.choices)
    semester_start = models.DateField()
    semester_end = models.DateField()


class Group(models.Model):
    name = models.CharField(max_length=255)
    stream = models.ForeignKey("StudyStream", on_delete=models.CASCADE)


class Subject(models.Model):
    name = models.CharField(max_length=255)
    stream = models.ForeignKey("StudyStream", on_delete=models.CASCADE)


class Place(models.Model):

    # class BMSTUBuilding(models.TextChoices):
    #     GZ = "GZ"
    #     ULK = "ULK"
    #     LT = "LT"
    #     E = "E"
    #     SM = "SM"
    #     MT = "MT"
    #     MF = "MF"
    #     FV = "FV"
    #
    # def get_building(self) -> BMSTUBuilding:
    #     return self.BMSTUBuilding(self.building)
    name = models.CharField(max_length=255)
    is_generic = models.BooleanField()  # если это что-то типа "каф. ФН12"
    # building = models.CharField(max_length=3, choices=BMSTUBuilding.choices)


class Teacher(models.Model):
    # familyName = models.CharField(max_length=255)
    # forename = models.CharField(max_length=255)  # именно имя
    # fatherName = models.CharField(max_length=255)
    display_name = models.CharField(max_length=255)
    study_streams = models.ManyToManyField("StudyStream")


class Lesson(models.Model):

    class LessonType(models.TextChoices):
        LAB = "LAB"
        SEM = "SEM"
        LEC = "LEC"
        PRACTICE = "PRACTICE"
        PHYSICAL = "PHYSICAL"

    subject = models.ForeignKey("Subject", on_delete=models.RESTRICT)
    place = models.ForeignKey("Place", on_delete=models.SET_NULL, null=True)
    teachers = models.ManyToManyField("Teacher")
    start_time = models.DateTimeField()
    end_time = models.DateTimeField()
    lesson_type = models.TextField(max_length=8, choices=LessonType.choices)
    groups = models.ManyToManyField("Group")
