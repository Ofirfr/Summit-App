part of 'main.dart';

class Member {
  int id = 0;
  String firstName = "";
  String lastName = "";
  Member(String fName, String lName, int i) {
    firstName = fName;
    lastName = lName;
    id = i;
  }
  int getID() {
    return id;
  }

  String getFullName() {
    return firstName + " " + lastName;
  }
}

class Coms {
  static const String ip = "http://192.168.79.1:5000/";

  static List<Member> members = [];
  static String token = "";
  static List<Member> getCopyOfMembers() {
    List<Member> result = [];
    result.addAll(members);
    return result;
  }

  static Future<List<String>> fetchData(String url) async {
    String fullUrl = ip + url;
    final response = await get(Uri.parse(fullUrl),
        headers: {"Access-Control-Allow-Origin": "*"});
    final jsonData = jsonDecode(response.body);
    List<String> result = [];
    for (int i = 0; i < jsonData.length; i++) {
      result.add(jsonData[i]);
    }
    return result;
  }

  static Future<void> logout() async {
    String url = ip + "Logout/" + token;
    get(Uri.parse(url));
  }

  static Future<bool> login(username, password) async {
    String loginUrl = "Login/" +
        username +
        '/' +
        sha512.convert(utf8.encode(password)).toString();
    var data = await fetchData(loginUrl);
    if (data[0] == "Invalid") return false;
    members.clear();
    token = data[0];
    for (int i = 1; i < data.length; i++) {
      var info = data[i].split(',');
      members.add(Member(info[0], info[1], int.parse(info[2])));
    }
    return true;
  }

  static void addPersons(List<Person> persons, String coach, String date) {
    List<int> personsIds = [];
    for (Person person in persons) {
      personsIds.add(person.id);
    }
    String personsString = personsIds.join(',');
    String fullUrl = ip +
        "AddToTraining/" +
        personsString +
        "/" +
        date +
        "/" +
        coach +
        "/" +
        token;
    get(Uri.parse(fullUrl));
  }

  static void removePersons(List<Person> persons, String coach, String date) {
    List<int> personsIds = [];
    for (Person person in persons) {
      personsIds.add(person.id);
    }
    String personsString = personsIds.join(',');
    String fullUrl = ip +
        "RemoveFromTraining/" +
        personsString +
        "/" +
        date +
        "/" +
        coach +
        "/" +
        token;
    get(Uri.parse(fullUrl));
  }

  static Future<bool> addMember(String firstName, String lastName) async {
    String fullUrl =
        ip + "AddMember/" + firstName + "/" + lastName + "/" + token;
    String response = (await get(Uri.parse(fullUrl))).bodyBytes.toString();
    if (response != "Can't authenticate") {
      var id = int.parse(response.split(',')[0].substring(1));
      print(id);
      members.add(Member(firstName, lastName, id));
      print(members);
      return true;
    }
    return false;
  }

  static Future<bool> addUser(String username, String password) async {
    String fullUrl = ip +
        "AddUser/" +
        username +
        "/" +
        sha512.convert(utf8.encode(password)).toString() +
        "/" +
        token;
    String response = (await get(Uri.parse(fullUrl))).bodyBytes.toString();
    return response == "OK";
  }

  static Future<List<String>> getAttendance(String date, String coach) async {
    final String getAttendaceUrl =
        "GetAttendance/" + date + "/" + coach + "/" + token;
    return Coms.fetchData(getAttendaceUrl);
  }

  static Future<List<String>> getTrainings(int id) async {
    String getTrainingsUrl = "GetTrainings/" + id.toString() + "/" + token;
    return Coms.fetchData(getTrainingsUrl);
  }

  static Future<List<String>> getAllTrainings() async {
    String getTrainingsUrl = "GetAllTrainings/" + token;
    return Coms.fetchData(getTrainingsUrl);
  }
}
