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


def get_group_lessons(request, group_name):
    try:
        group = Group.objects.get(name=group_name)
    except Group.DoesNotExist:
        return Http404("Couldn't find group with name {}".format(group_name))

    day_offset_from_today = request.GET.get('page')
    if day_offset_from_today is None:
        day_offset_from_today = 1

    day = date.today() + timedelta(days=(day_offset_from_today - 1))
    print(day)
    lessons_now = Lesson.objects \
        .filter(groups__in=[group]) \
        .filter(start_time__gte=day) \
        .filter(end_time__lte=(day + timedelta(days=1)))

    return JsonResponse(list(lessons_now), safe=False)


def get_groups(request):
    pass


def get_group_info(request):
    pass
