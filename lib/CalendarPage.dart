part of 'main.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  CalendarPageState createState() => CalendarPageState();
}

class CalendarPageState extends State<CalendarPage> {
  static String selectedDate = '';

  void dateChanged(DateRangePickerSelectionChangedArgs args) {
    selectedDate = DateFormat('dd/MM/yyyy').format(args.value).toString();
    selectedDate = selectedDate.replaceAll('/', '.');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
        ),
        body: Column(
          children: [
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
                  "Choose Date",
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
              height: 10,
              width: 10,
            ),
            SfDateRangePicker(
              onSelectionChanged: dateChanged,
            ),
            const SizedBox(
              height: 10,
              width: 10,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 20)),
              onPressed: () {
                if (selectedDate != "") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (ctxt) => AttendancePage()),
                  );
                }
              },
              child: const Text('Check Attendance'),
            ),
          ],
        ));
  }
}
