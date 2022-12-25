import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore
from itertools import count

global db


class StudyStream(object):
    new_id = count()

    def __init__(self, semester: int, specialty: str, faculty: str):
        self.semester = semester
        self.specialty = specialty
        self.faculty = faculty
        self.id = next(StudyStream.new_id)

    def to_dict(self):
        return {"semester": self.semester, "specialty": self.specialty, "faculty": self.faculty}


class Group(object):
    new_id = count()

    def __init__(self, name: str, study_stream: StudyStream):
        self.name = name
        self.study_stream = study_stream
        self.id = next(Group.new_id)

    def to_dict(self):
        return {"name": self.name, "study_stream": self.study_stream.id}


def prepare():
    cred = credentials.Certificate("electronicuniversity-20072-firebase-adminsdk-9voct-bca3e2da6b.json")
    firebase_admin.initialize_app(cred)
    global db
    db = firestore.client()


def fill():
    streams = [StudyStream(3, "09.03.04", "ИУ7"), StudyStream(4, "09.03.04", "ИУ7")]

    for i in range(len(streams)):
        print("Add stream")
        db.collection(u"study_streams").document(u"{}".format(i)).create(streams[i].to_dict())

    groups = [Group("ИУ7-35Б", streams[0]), Group("ИУ7-45Б", streams[1]), Group("ИУ7-46Б", streams[1])]

    for i in range(len(groups)):
        print("Add group")
        db.collection(u"groups").document(u"{}".format(i)).create(groups[i].to_dict())

    # stream -> groups
    stream_to_groups = {}
    for i in range(len(groups)):
        group = groups[i]
        if group.study_stream.id not in stream_to_groups:
            stream_to_groups[group.study_stream.id] = []
            stream_to_groups[group.study_stream.id].append(group)
        else:
            stream_to_groups[group.study_stream.id].append(group)

    for stream in stream_to_groups.keys():
        db.collection(u"study_stream_to_groups").document(u"{}".format(stream)).create({})
        for group in stream_to_groups[stream]:
            print("Add stream->group")
            db.collection(u"study_stream_to_groups").document(u"{}".format(stream)).collection("groups").document(
                u"{}".format(group.id)).create(group.to_dict())


def test():
    global db
    groups = db.collection(u"groups").stream()
    for group in groups:
        print(group.to_dict())


if __name__ == '__main__':
    prepare()
    # fill()
    test()
