from django.db import models


# Create your models here.
class StudyStream(models.Model):

    class StudyLevel(models.TextChoices):
        BACHELOR = "BACHELOR"
        MASTER = "MASTER"
        POSTGRAGUDATE = "POSTGRADUATE"
        SPECIALIST = "SPECIALIST"

    class Meta:
        unique_together = ("semester", "faculty", "study_level")

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

    name = models.CharField(max_length=255)
    is_generic = models.BooleanField()  # если это что-то типа "каф. ФН12"


class Teacher(models.Model):

    display_name = models.CharField(max_length=255)
    study_streams = models.ManyToManyField("StudyStream")


class Lesson(models.Model):

    class LessonType(models.TextChoices):
        LAB = "LAB"
        SEM = "SEM"
        LEC = "LEC"
        PRACTICE = "PRACTICE"
        PHYSICAL = "PHYSICAL"
        VUC = "VUC"

    subject = models.ForeignKey("Subject", on_delete=models.CASCADE)
    place = models.ForeignKey("Place", on_delete=models.SET_NULL, null=True)
    teacher = models.ForeignKey("Teacher", on_delete=models.SET_NULL, null=True)
    start_time = models.DateTimeField()
    end_time = models.DateTimeField()
    pair_num = models.IntegerField()
    lesson_type = models.TextField(max_length=8, choices=LessonType.choices)
    groups = models.ManyToManyField("Group")
