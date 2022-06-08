// ignore_for_file: curly_braces_in_flow_control_structures

part of 'main.dart';

class AttendancePage extends StatelessWidget {
  const AttendancePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Clear previous data
    personsAdded.clear();
    personsRemoved.clear();
    changed = false;
    for (int i = 0; i < users.length; i++) {
      users[i].came = false;
    }

    return Center(
        child: Scaffold(
      appBar: AppBar(
        title:
            Text(CalendarPageState.selectedDate + " " + LoginScreenState.coach),
        backgroundColor: Colors.blueAccent,
        actions: <Widget>[
          Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: InkWell(
                onTap: () {
                  if (personsAdded.isNotEmpty) {
                    Coms.addPersons(personsAdded, LoginScreenState.coach,
                        CalendarPageState.selectedDate);
                  }
                  if (personsRemoved.isNotEmpty) {
                    Coms.removePersons(personsRemoved, LoginScreenState.coach,
                        CalendarPageState.selectedDate);
                  }

                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (ctxt) => const MainPage()),
                      (route) => false);
                },
                child: const Icon(
                  Icons.cloud_upload,
                  size: 26.0,
                ),
              ))
        ],
      ),
      body: Column(children: [AttendanceWidegt()]),
    ));
  }
}

class Person {
  String name = '';
  int id = 0;
  bool came = false;
  Person(this.name, this.id);
  @override
  String toString() {
    return name;
  }
}

class Team {
  List<Person> team = [];

  Team() {
    //Creates a deep copy of the members array, so it has no changes
    for (int i = 0; i < Coms.members.length; i++) {
      team.add(Person(Coms.members[i].getFullName(), Coms.members[i].getID()));
    }
  }

  List<Person> getTeam() {
    return team;
  }
}

class AttendanceWidegt extends StatefulWidget {
  const AttendanceWidegt({Key? key}) : super(key: key);

  @override
  _AttendanceWidegtState createState() => _AttendanceWidegtState();
}

//users should be the copy of the list of EVERYONE, which should be brought from the server on connection
List<Person> users = [];
List<Person> personsAdded = [];
List<Person> personsRemoved = [];
List<String> attendance = [];
bool changed =
    false; // for checked buttons to not be modified by build every time

class _AttendanceWidegtState extends State<AttendanceWidegt> {
  // get writen attendance from server and check for every person who came his .came to true

  void markAttendance() async {
    if (mounted) {
      attendance = await Coms.getAttendance(
          CalendarPageState.selectedDate, LoginScreenState.coach);
      if (attendance[0] != "")
        for (int i = 0; i < attendance.length; i++) {
          for (int j = 0; j < users.length; j++) {
            String firstName = attendance[i].split(' ')[0];
            String lastName = attendance[i].split(' ')[1];
            if (firstName + " " + lastName == users[j].name) {
              setState(() {
                users[j].came = true;
              });
            }
          }
        }
    }
  }

  void initState() {
    super.initState();
    users = Team().getTeam();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widegtRows = [];
    if (!changed) {
      //mark attendance from previous actions
      markAttendance();
      changed = true;
    }

    //Mark every body who already came
    for (int i = 0; i < users.length; i++) {
      widegtRows.add(Row(
        children: [
          Text(users[i].toString()),
          IconButton(
            icon: Icon(
              Icons.check_circle_outline_rounded, //check button
              color: !(users[i].came)
                  ? Colors.black54
                  : Colors.green, //determine color
            ),
            onPressed: () {
              setState(() {
                if (personsAdded.contains(users[i]) && users[i].came) {
                  //Was added in this session and now removed
                  personsAdded.remove(users[i]);
                }
                if (!personsAdded.contains(users[i]) && users[i].came) {
                  //Was added before and now removed
                  personsRemoved.add(users[i]);
                }
                if (personsRemoved.contains(users[i])) {
                  //Was removed in this session and now added
                  personsRemoved.remove(users[i]);
                }
                if (!personsAdded.contains(users[i]) &&
                    !personsRemoved.contains(users[i])) {
                  //Wasn't edited yet
                  if (users[i].came) {
                    //Marked as came, so now removed
                    personsRemoved.add(users[i]);
                  } else {
                    //Marked as didnt came, now added
                    personsAdded.add(users[i]);
                  }
                }
                //Change 'came'
                users[i].came = !users[i].came;
              });
            },
          ),
        ],
      ));
    }

    return Expanded(
        child: SingleChildScrollView(
            child: Column(
      children: widegtRows, //final list of people and buttons
    )));
  }
}
