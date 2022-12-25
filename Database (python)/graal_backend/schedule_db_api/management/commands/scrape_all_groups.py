import os
import sys
import requests
from bs4 import BeautifulSoup
from schedule_db_api.management.commands.scrape_single_group import scrape_group, upload_group_data
from django.core.management.base import BaseCommand


if sys.version_info.major < 3:
    from urllib import url2pathname
else:
    from urllib.request import url2pathname


class LocalFileAdapter(requests.adapters.BaseAdapter):
    """Protocol Adapter to allow Requests to GET file:// URLs

    """

    @staticmethod
    def _chkpath(method, path):
        """Return an HTTP status for the given filesystem path."""
        if method.lower() in ('put', 'delete'):
            return 501, "Not Implemented"
        elif method.lower() not in ('get', 'head'):
            return 405, "Method Not Allowed"
        elif os.path.isdir(path):
            return 400, "Path Not A File"
        elif not os.path.isfile(path):
            return 404, "File Not Found"
        elif not os.access(path, os.R_OK):
            return 403, "Access Denied"
        else:
            return 200, "OK"

    def send(self, req, **kwargs):  # pylint: disable=unused-argument
        """Return the file specified by the given request

        @type req: C{PreparedRequest}
        """
        path = os.path.normcase(os.path.normpath(url2pathname(req.path_url)))
        response = requests.Response()

        response.status_code, response.reason = self._chkpath(req.method, path)
        if response.status_code == 200 and req.method.lower() != 'head':
            try:
                response.raw = open(path, 'rb')
            except (OSError, IOError) as err:
                response.status_code = 500
                response.reason = str(err)

        if isinstance(req.url, bytes):
            response.url = req.url.decode('utf-8')
        else:
            response.url = req.url

        response.request = req
        response.connection = self

        return response

    def close(self):
        pass


def get_all_groups_urls():
    requests_session = requests.session()
    requests_session.mount('file://', LocalFileAdapter())
    r = requests_session.get("file:///Users/tinartem/Developer/VK/2022_1s_ElectronicUniversity/Database (python)/graal_backend/schedule_db_api/management/commands/Личный кабинет обучающегося.html")
    soup = BeautifulSoup(r.content, "html5lib")
    groups = soup.find_all(class_="btn btn-primary col-1 rounded schedule-indent", href=True)
    ans = []
    for group in groups:
        ans.append((group.contents[0].strip(), "https://lks.bmstu.ru{}".format(group["href"])))
    return ans


if __name__ == '__main__':
    groups_urls = get_all_groups_urls()
    data = []
    with open("output.json", "w") as f:
        for group in groups_urls:
            group_data = scrape_group(group)
            print(group_data, file=f)


class Command(BaseCommand):
    help = "loads all groups in db"

    def add_arguments(self, parser):
        pass

    def handle(self, *args, **options):
        groups_urls = get_all_groups_urls()
        i = 0
        while i < 150 and i < len(groups_urls):
            group = groups_urls[i]
            print("Group:", group[0])
            upload_group_data(scrape_group(group))
            i += 1

