from django.urls import path

from . import views

urlpatterns = [
    path("group_schedule/<str:group_name>", views.get_group_lessons, name="get_group_schedule"),
    path("groups_list/", views.get_groups, name="get_groups"),
    path("group_info/<str:group_name>", views.get_group_info, name="get_group_info"),
]
