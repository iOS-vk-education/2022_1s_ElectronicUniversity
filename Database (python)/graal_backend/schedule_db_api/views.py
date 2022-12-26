from datetime import date, timedelta
from django.forms.models import model_to_dict
from django.http import Http404, JsonResponse
from .models import *


def group_lessons(request, group_id, day_offset_from_today=None):
    try:
        group = Group.objects.get(pk=group_id)
    except Group.DoesNotExist:
        return Http404("Couldn't find group with id {}".format(group_id))

    if day_offset_from_today is None:
        day_offset_from_today = 0
    day = date.today() + timedelta(days=day_offset_from_today)
    print(day)
    print(day)
    lessons_now = Lesson.objects \
        .filter(groups__in=[group]) \
        .filter(start_time__gte=day) \
        .filter(end_time__lte=(day + timedelta(days=1)))
    json_response = list()
    for i in range(len(lessons_now)):
        lesson = lessons_now[i]
        json_response.append(model_to_dict(lesson))
        json_response[i]["groups"] = list(lesson.groups.values_list("pk", flat=True))
        if lesson.teacher is not None:
            tmp = lesson.teacher.__dict__
            del tmp["_state"]
            print(tmp)
            json_response[i]["teacher"] = tmp
        if lesson.subject is not None:
            tmp = lesson.subject.__dict__
            del tmp["_state"]
            print(tmp)
            json_response[i]["subject"] = tmp
        if lesson.place is not None:
            tmp = lesson.place.__dict__
            del tmp["_state"]
            print(tmp)
            json_response[i]["place"] = tmp

    return JsonResponse(json_response, safe=False)


def group_lessons_reverse(request, group_id, day_offset_from_today):
    return group_lessons(request, group_id, -day_offset_from_today)


def groups(request):
    groups = Group.objects.all()
    json_response = list()
    for i in range(len(groups)):
        group = groups[i]
        json_response.append(model_to_dict(group))
    return JsonResponse(json_response, safe=False)


def group(request, group_id):
    try:
        group = Group.objects.get(pk=group_id)
    except Group.DoesNotExist:
        return Http404("Couldn't find group with id {}".format(group_id))
    json_response = list()
    json_response.append(model_to_dict(group))
    json_response[0]["stream"] = model_to_dict(StudyStream.objects.get(pk=group.stream.pk))
    return JsonResponse(json_response, safe=False)


def teacher(request, teacher_id):
    try:
        teacher = Teacher.objects.get(pk=teacher_id)
    except Teacher.DoesNotExist:
        return Http404("Couldn't find teacher with id {}".format(teacher_id))
    json_response = list()
    json_response.append(model_to_dict(teacher))
    json_response[0]["study_streams"] = list(teacher.study_streams.values_list("pk", flat=True))
    return JsonResponse(json_response, safe=False)


def streams(request):
    streams = StudyStream.objects.all()
    json_response = list()
    for i in range(len(streams)):
        stream = streams[i]
        json_response.append(model_to_dict(stream))
        json_response[i]["groups"] = list(stream.group_set.values_list("pk", flat=True))
    return JsonResponse(json_response, safe=False)
