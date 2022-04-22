part of 'main.dart';

class ViewTrainingsPage extends StatelessWidget {
  const ViewTrainingsPage({Key? key, required this.sender}) : super(key: key);
  final String sender; // either "" for admin or "name,id" for person

  @override
  Widget build(BuildContext context) {
    String text;
    if (sender == "") {
      //Sent from admin page, show all members
      text = "All Trainings";
    } else {
      //Sent from ViewTraining, show attendance of training
      text = sender.split(',')[0] + " trainings";
    }
    return Center(
        child: Scaffold(
      appBar: AppBar(
        title: Text(text),
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(children: [TrainingsWidegt(sender: sender)]),
    ));
  }
}

class TrainingsWidegt extends StatefulWidget {
  const TrainingsWidegt({Key? key, required this.sender}) : super(key: key);
  final String sender;
  @override
  _TrainingsWidegtState createState() => _TrainingsWidegtState(sender: sender);
}

class _TrainingsWidegtState extends State<TrainingsWidegt> {
  _TrainingsWidegtState({required this.sender});
  final String sender;

  List<String> shownTrainings = [];
  Future<void> changeShownTrainings() async {
    List<String> trainings =
        await Coms.getTrainings(int.parse(sender.split(',')[1]));
    setState(() {
      shownTrainings.clear();
      shownTrainings.addAll(trainings);
    });
  }

  Future<void> setAllTrainings() async {
    List<String> result = await Coms.getAllTrainings();
    setState(() {
      shownTrainings = result;
    });
  }

  @override
  initState() {
    super.initState();
    if (sender == "") {
      setAllTrainings();
    } else {
      changeShownTrainings();
    }
  }

  Widget build(BuildContext context) {
    List<Widget> widegtRows = [];
    for (int i = 0; i < shownTrainings.length; i++) {
      widegtRows.add(Row(
        children: [
          Text(shownTrainings[i]),
          IconButton(
            icon: Icon(Icons.arrow_right),
            onPressed: () {
              //add navigation to view person with the training
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (ctxt) =>
                        ViewMembersPage(sender: shownTrainings[i])),
              );
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
