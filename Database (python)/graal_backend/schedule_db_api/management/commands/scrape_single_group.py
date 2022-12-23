import requests
from bs4 import BeautifulSoup


def main():
    url = "https://lks.bmstu.ru/schedule/f9891fb1-8a79-11ec-b81a-0de102063aa5"
    r = requests.get(url)
    soup = BeautifulSoup(r.content, "html5lib")
    tables = soup.find_all('table', class_="table-bordered")
    exams_table = tables[0]
    monday_table = tables[2]
    tuesday_table = tables[4]
    wednesday_table = tables[6]
    thursday_table = tables[8]
    friday_table = tables[10]
    saturday_table = tables[12]
    week_tables = [monday_table, tuesday_table, wednesday_table, thursday_table, friday_table, saturday_table]
    for table in week_tables:
        print("Table:")
        print(table)
    print(r.content)


if __name__ == '__main__':
    main()
