part of 'main.dart';

//Part of this Login page was taken from https://flutterawesome.com/tag/login-screen/
class AddCoachPage extends StatelessWidget {
  const AddCoachPage({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
      ),
      resizeToAvoidBottomInset: true,
      body: const AddCoachScreen(),
    );
  }
}

class AddCoachScreen extends StatefulWidget {
  const AddCoachScreen({Key? key}) : super(key: key);

  @override
  _AddCoachScreenState createState() => _AddCoachScreenState();
}

class _AddCoachScreenState extends State<AddCoachScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isObscure = true;

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

            Center(
              child: Container(
                height: 200,
                width: 400,
                alignment: Alignment.center,
                child: const Text(
                  "Add Coach",
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
                    controller: usernameController, // Controller for Username
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Username",
                        contentPadding: EdgeInsets.all(20)),
                    onEditingComplete: () => FocusScope.of(context).nextFocus(),
                  ),
                  const Divider(
                    thickness: 3,
                  ),
                  TextFormField(
                    onTap: () {},

                    controller: passwordController, // Controller for Password
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Password",
                        contentPadding: const EdgeInsets.all(20),
                        // Adding the visibility icon to toggle visibility of the password field
                        suffixIcon: IconButton(
                          icon: Icon(_isObscure
                              ? Icons.visibility_off
                              : Icons.visibility),
                          onPressed: () {
                            setState(() {
                              _isObscure = !_isObscure;
                            });
                          },
                        )),
                    obscureText: _isObscure,
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
                    Coms.addUser(
                        usernameController.text, passwordController.text);
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
