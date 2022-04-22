part of 'main.dart';

//final Color darkBlue = Color.fromARGB(255, 18, 32, 47);

class AdminPage extends StatelessWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> firstRow = [
      adminButtonWidget("View Trainings", context),
      const SizedBox(width: 30), //for spacing
      adminButtonWidget("View Members", context),
    ];
    List<Widget> secondRow = [
      adminButtonWidget("Add Member", context),
      const SizedBox(width: 30), //for spacing
      adminButtonWidget("Add Coach", context),
    ];
    const rowSpacer = TableRow(children: [
      SizedBox(
        height: 40,
      ),
      SizedBox(
        height: 40,
      ),
      SizedBox(
        height: 40,
      )
    ]);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              height: 10,
              width: 200,
            ),
            Center(
              child: Container(
                height: 60,
                width: 400,
                alignment: Alignment.center,
                child: const AutoSizeText(
                  "Admin Actions",
                  maxLines: 1,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
              width: 1,
            ),
            Container(
              height: 540.0,
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.symmetric(vertical: 50.0),
              child: Table(
                children: [
                  TableRow(children: firstRow),
                  rowSpacer,
                  TableRow(children: secondRow)
                ],
              ),
            ),
          ]),
    );
  }

  Widget adminButtonWidget(String label, BuildContext context) {
    return SizedBox(
        width: 300,
        height: 110,
        child: ElevatedButton(
          child: Text(label),
          style: ElevatedButton.styleFrom(
              textStyle:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          onPressed: () {
            switch (label) {
              case "Add Member":
                {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (ctxt) => const AddMemberPage()),
                  );
                  break;
                }

              case "Add Coach":
                {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (ctxt) => const AddCoachPage()),
                  );
                  break;
                }
              case "View Trainings":
                {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (ctxt) => const ViewTrainingsPage(sender: "")),
                  );
                  break;
                }
              case "View Members":
                {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (ctxt) => const ViewMembersPage(sender: "")),
                  );
                  break;
                }
            }
          },
        ));
  }
}
