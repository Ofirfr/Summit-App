part of 'main.dart';

//Part of this Login page was taken from https://flutterawesome.com/tag/login-screen/
class AddMemberPage extends StatelessWidget {
  const AddMemberPage({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
      ),
      resizeToAvoidBottomInset: true,
      body: const AddMemberScreen(),
    );
  }
}

class AddMemberScreen extends StatefulWidget {
  const AddMemberScreen({Key? key}) : super(key: key);

  @override
  _AddMemberScreenState createState() => _AddMemberScreenState();
}

class _AddMemberScreenState extends State<AddMemberScreen> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        reverse: true,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              height: 60,
              width: 200,
            ),

            // Login text Widget
            Center(
              child: Container(
                height: 200,
                width: 400,
                alignment: Alignment.center,
                child: const Text(
                  "Add Member",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                  ),
                  // textAlign: TextAlign.center,
                ),
              ),
            ),

            const SizedBox(
              height: 60,
              width: 10,
            ),

            // Textfields for username and password fields
            Container(
              height: 140,
              width: 530,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Colors.white),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    onTap: () {},
                    controller: firstNameController, // Controller for Username
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "First Name",
                        contentPadding: EdgeInsets.all(20)),
                    onEditingComplete: () => FocusScope.of(context).nextFocus(),
                  ),
                  const Divider(
                    thickness: 3,
                  ),
                  TextFormField(
                    onTap: () {},

                    controller: lastNameController, // Controller for Password
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Last Name",
                      contentPadding: EdgeInsets.all(20),
                      // Adding the visibility icon to toggle visibility of the password field
                    ),
                  ),
                ],
              ),
            ),

            // Submit Button
            Container(
              width: 570,
              height: 100,
              padding: const EdgeInsets.only(top: 20),
              child: ElevatedButton(
                  child: const AutoSizeText(
                    "Submit",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                    maxLines: 1,
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blueAccent,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 20),
                  ),
                  onPressed: () {
                    Coms.addMember(
                        firstNameController.text, lastNameController.text);
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (ctxt) => const MainPage()),
                        (route) => false);
                  }),
            ),
          ],
        ));
  }
}
