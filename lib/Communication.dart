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
  static List<Member> getCopyOfMembers() {
    List<Member> result = [];
    result.addAll(members);
    return result;
  }

  static Future<bool> login(username, password) async {
    String loginUrl = "Login/" + username + '/' + password;
    var data = await fetchData(loginUrl);
    if (data[0] == "Invalid") return false;
    members.clear();
    for (int i = 0; i < data.length; i++) {
      var info = data[i].split(',');
      members.add(new Member(info[0], info[1], int.parse(info[2])));
    }
    return true;
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

  static void addPersons(List<Person> persons, String coach, String date) {
    List<int> personsIds = [];
    for (Person person in persons) {
      personsIds.add(person.id);
    }
    String personsString = personsIds.join(',');
    String fullUrl =
        ip + "AddToTraining/" + personsString + "/" + date + "/" + coach;
    get(Uri.parse(fullUrl));
  }

  static void removePersons(List<Person> persons, String coach, String date) {
    List<int> personsIds = [];
    for (Person person in persons) {
      personsIds.add(person.id);
    }
    String personsString = personsIds.join(',');
    String fullUrl =
        ip + "RemoveFromTraining/" + personsString + "/" + date + "/" + coach;
    get(Uri.parse(fullUrl));
  }

  static Future<bool> addMember(String firstName, String lastName) async {
    String fullUrl = ip + "AddMember/" + firstName + "/" + lastName;
    String response = (await get(Uri.parse(fullUrl))).bodyBytes.toString();
    members.add(new Member(firstName, lastName, int.parse(response)));
    return true;
  }

  static Future<bool> addUser(String username, String password) async {
    String fullUrl = ip + "AddUser/" + username + "/" + password;
    String response = (await get(Uri.parse(fullUrl))).bodyBytes.toString();
    return response == "OK";
  }

  static Future<List<String>> getAttendance(String date, String coach) async {
    final String getAttendaceUrl = "GetAttendance/" + date + "/" + coach;
    return Coms.fetchData(getAttendaceUrl);
  }

  static Future<List<String>> getTrainings(int id) async {
    String getTrainingsUrl = "GetTrainings/" + id.toString();
    return Coms.fetchData(getTrainingsUrl);
  }

  static Future<List<String>> getAllTrainings() async {
    String getTrainingsUrl = "GetAllTrainings";
    return Coms.fetchData(getTrainingsUrl);
  }
}
