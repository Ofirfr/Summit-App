part of 'main.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [buttonWidget('Go to Calendar', context)];
    if (LoginScreenState.coach == 'admin') {
      widgets.add(buttonWidget('Admin Page', context));
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Hello " + LoginScreenState.coach),
        backgroundColor: Colors.blueAccent,
        actions: <Widget>[
          Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: InkWell(
                onTap: () {
                  Coms.logout();
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (ctxt) => const LoginPage()),
                      (route) => false);
                },
                child: const Icon(
                  Icons.logout,
                  size: 26.0,
                ),
              ))
        ],
      ),
      body: Center(
        child: Container(
          height: 600.0,
          padding: const EdgeInsets.symmetric(vertical: 50.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: widgets),
        ),
      ),
    );
  }

  Widget buttonWidget(String label, BuildContext context) {
    return SizedBox(
      width: 300,
      height: 120,
      child: ElevatedButton(
        child: Text(label),
        style: ElevatedButton.styleFrom(
            textStyle:
                const TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
        onPressed: () {
          switch (label) {
            case "Admin Page":
              {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (ctxt) => const AdminPage()),
                );
                break;
              }

            case "Go to Calendar":
              {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (ctxt) => const CalendarPage()),
                );
                break;
              }
          }
        },
      ),
    );
  }
}
