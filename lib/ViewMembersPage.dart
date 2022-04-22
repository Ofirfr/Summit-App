part of 'main.dart';

class ViewMembersPage extends StatelessWidget {
  const ViewMembersPage({Key? key, required this.sender}) : super(key: key);
  final String sender;
  @override
  Widget build(BuildContext context) {
    String text;
    if (sender == "") {
      //Sent from admin page, show all members
      text = "All Members";
    } else {
      //Sent from ViewTraining, show attendance of training
      text = sender + " attendance";
    }
    return Center(
        child: Scaffold(
      appBar: AppBar(
        title: Text(text),
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(children: [MembersWidegt(sender: sender)]),
    ));
  }
}

class MembersWidegt extends StatefulWidget {
  const MembersWidegt({Key? key, required this.sender}) : super(key: key);
  final String sender;
  @override
  _MembersWidegtState createState() => _MembersWidegtState(sender: sender);
}

class _MembersWidegtState extends State<MembersWidegt> {
  _MembersWidegtState({required this.sender});
  final String sender;
  List<Member> shownMembers = [];

  Future<void> changeShownMembers() async {
    List<String> training = sender.split(' ');
    List<String> personAttendance =
        await Coms.getAttendance(training[1], training[0]);
    List<Member> newMembers = [];
    if (personAttendance[0] != "")
      for (int i = 0; i < personAttendance.length; i++) {
        List<String> fullNameAndId = personAttendance[i].split(' ');
        newMembers.add(Member(
            fullNameAndId[0], fullNameAndId[1], int.parse(fullNameAndId[2])));
      }

    setState(() {
      shownMembers.clear();
      shownMembers.addAll(newMembers);
    });
  }

  @override
  void initState() {
    super.initState();
    if (sender == "") {
      shownMembers = Coms.getCopyOfMembers();
    } else {
      changeShownMembers();
    }
  }

  Widget build(BuildContext context) {
    List<Widget> widegtRows = [];
    for (int i = 0; i < shownMembers.length; i++) {
      widegtRows.add(Row(
        children: [
          Text(shownMembers[i].getFullName()),
          IconButton(
            icon: Icon(Icons.arrow_right),
            onPressed: () {
              //add navigation to view trainings with the person name
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (ctxt) => ViewTrainingsPage(
                        sender: shownMembers[i].getFullName() +
                            "," +
                            shownMembers[i].getID().toString()),
                  ));
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
