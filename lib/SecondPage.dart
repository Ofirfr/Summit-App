part of 'main.dart';
/*
class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Center(
        child: Scaffold(
      appBar: AppBar(
        title: Text(CalendarPageState.selectedDate + " Select Coach"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(children: [CoachWidget()]),
    ));
  }
}

class CoachWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CoachWidgetState();
  }
}

var coaches = [
  "Moshe",
  "Pinchas",
  "Shlomo",
];

class CoachWidgetState extends State<CoachWidget> {
  static String coachSelected = "";
  @override
  Widget build(BuildContext context) {
    List<Widget> widegtRows = [];
    for (int i = 0; i < coaches.length; i++) {
      widegtRows.add(Row(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Colors.lightBlueAccent,
                fixedSize: Size(300, 100),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10))),
            onPressed: () {
              coachSelected = coaches[i];
              Navigator.push(
                context,
                new MaterialPageRoute(builder: (ctxt) => new ThirdPage()),
              );
            },
            child: Text(coaches[i]),
          ),
        ),
      ]));
    }
    return Expanded(
        child: SingleChildScrollView(
            child: Column(
      children: widegtRows, //final list of people and buttons
    )));
  }
}
 */