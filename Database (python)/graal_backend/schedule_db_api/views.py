from django.http import HttpResponse, Http404, JsonResponse
from django.template import loader
from django.core.paginator import Paginator, InvalidPage
from .models import *
from datetime import date, timedelta, datetime
from django.core import serializers
from django.forms.models import model_to_dict
from django.shortcuts import get_object_or_404
from django.core.paginator import Paginator, InvalidPage


# Create your views here.


def group_lessons(request, group_id, day_offset_from_today=None):
    try:
        group = Group.objects.get(pk=group_id)
    except Group.DoesNotExist:
        return Http404("Couldn't find group with id {}".format(group_id))

    if day_offset_from_today is None:
        day_offset_from_today = 0
    day = date.today() + timedelta(days=day_offset_from_today)
    print(day)
    lessons_now = Lesson.objects \
        .filter(groups__in=[group]) \
        .filter(start_time__gte=day) \
        .filter(end_time__lte=(day + timedelta(days=1)))
    # print(serializers.serialize("json", lessons_now)[0]["fields"])
    json_response = list()
    for i in range(len(lessons_now)):
        lesson = lessons_now[i]
        json_response.append(model_to_dict(lesson))
        json_response[i]["teachers"] = list(lesson.teachers.values_list("pk", flat=True))
        json_response[i]["groups"] = list(lesson.groups.values_list("pk", flat=True))

    return JsonResponse(json_response, safe=False)


def groups(request):
    pass


def group(request):
    pass


def teacher(request):
    pass


def streams(request):
    pass
