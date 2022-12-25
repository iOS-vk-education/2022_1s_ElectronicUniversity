from django.urls import path

from . import views

urlpatterns = [
    path("group/<int:group_id>/lessons/", views.group_lessons, name="get group today schedule by groupID"),
    path("group/<int:group_id>/lessons/<int:day_offset_from_today>/", views.group_lessons, name="get group schedule of today or future days by groupID"),
    path("group/<int:group_id>/lessons/reverse_seq/<int:day_offset_from_today>/", views.group_lessons_reverse, name="get group schedule of past by groupID"),
    path("groups/", views.groups, name="get all groups"),
    path("group/<int:group_id>/", views.group, name="get group data"),
    path("teacher/<int:teacher_id>/", views.teacher, name="get teacher data"),
    path("streams/", views.streams, name="get all streams"),
]
