import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hersphere/pages/impwidgets/appbar.dart';
import 'package:hersphere/pages/selfcarepages/selfcare.dart';


class Daily extends StatefulWidget {
  const Daily({Key? key}) : super(key: key);

  @override
  State<Daily> createState() => _DailyState();

}
class _DailyState extends State<Daily> {
  late SharedPreferences _prefs;
  late String _lastResetDateKey;
  late DateFormat _dateFormat;
  int _checkedQuestions = 0;

  @override
  void initState() {
    super.initState();
    _lastResetDateKey = 'lastResetDate';
    _dateFormat = DateFormat('yyyy-MM-dd');
    _initSharedPreferences();
  }

  // Initialize SharedPreferences
  Future<void> _initSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    _resetCheckboxesIfNeeded();
  }

  // Function to reset checkboxes if needed
  void _resetCheckboxesIfNeeded() {
    String? lastResetDate = _prefs.getString(_lastResetDateKey);
    String currentDate = _dateFormat.format(DateTime.now());

    // If last reset date is not today, reset checkboxes
    if (lastResetDate != currentDate) {
      setState(() {
        questions.forEach((question) {
          question[1] = false;
        });
        _checkedQuestions = 0;
      });

      // Update last reset date
      _prefs.setString(_lastResetDateKey, currentDate);
    }
  }

//Hardcoded lsit of questions
  List<List<dynamic>> questions = [
    ["Have you stretched your body for 5-10 minutes today?", false],
    ["Did you drink a glass of water after waking up?", false],
    ["What are three things you're grateful for today?", false],
    ["Have you taken a few minutes to practice deep breathing exercises?", false],
    ["Did you take a short walk outside during a break?", false],
    ["Have you had a serving of fruits or vegetables today?", false],
    ["What new thing have you learned in the last 10-15 minutes?", false],
    ["Have you done something kind for someone unexpectedly today?", false],
    ["Before bed, reflect on one positive thing and one area for improvement from your day.", false],
    ["Have you spent at least 30 minutes away from screens before bedtime?", false],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFBCF7C5),
      appBar: const AppBarWidget(
        text: 'DAILY PLAN',
        color: Color(0xFFBCF7C5),
        back: SelfCare(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            //Creating a check on how much you have achieved for a day
            LinearProgressIndicator(
              value: _checkedQuestions/10,
              minHeight: 10.0,
              backgroundColor: Colors.red,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
            ),
            Expanded(
              //List of questions and their corresponding checkbox
              child: ListView.builder(
                itemCount: questions.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusDirectional.circular(10),
                      ),
                      tileColor: Colors.white.withOpacity(0.5),
                      //Displaying the question
                      title: Text(
                        questions[index][0],
                        style: const TextStyle(
                          fontFamily: 'OtomanopeeOne',
                          fontSize: 15.0,
                          color: Color(0xFF726662),
                        ),
                      ),
                      //Enav\bling of checking each question
                      trailing: Checkbox(
                        value: questions[index][1],
                        onChanged: (newValue) {
                          setState(() {
                            questions[index][1] = !questions[index][1];
                            if(questions[index][1]==true){
                              _checkedQuestions++;
                            }
                            else _checkedQuestions--;
                          });
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
