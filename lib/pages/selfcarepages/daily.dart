import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hersphere/providers/selfcare_provider.dart';
import 'package:hersphere/providers/selfcarestream_provider.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hersphere/pages/impwidgets/appbar.dart';
import 'package:hersphere/pages/selfcarepages/selfcare.dart';

class Daily extends ConsumerStatefulWidget {
  const Daily({Key? key}) : super(key: key);

  @override
  ConsumerState<Daily> createState() => _DailyState();
}

class _DailyState extends ConsumerState<Daily> {
  late SharedPreferences _prefs;
  late String _lastResetDateKey;
  late DateFormat _dateFormat;
  final user = FirebaseAuth.instance.currentUser!;
  int _checkedCount = 0;

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
  Future<void> _resetCheckboxesIfNeeded() async {
    String? lastResetDate = _prefs.getString(_lastResetDateKey);
    String currentDate = _dateFormat.format(DateTime.now());

    // If last reset date is not today, reset checkboxes
    if (lastResetDate != currentDate) {
      for (int i = 0; i < questions.length; i++) {
        if (!mounted) return; // Check if the widget is still mounted
        await ref
            .read(selfCareNotifierProvider.notifier)
            .updateCheckedIndex(user.uid, i, false);
      }
      // Update last reset date
      if (mounted) {
        _prefs.setString(_lastResetDateKey, currentDate);
      }
    }
  }

// Hardcoded list of questions
  List<String> questions = [
    "Did you get at least 7 hours of sleep last night?",
    "Did you take a moment to meditate or relax today?",
    "Did you avoid sugary snacks today?",
    "Have you complimented someone today?",
    "Did you spend some time outdoors today?",
    "Have you read a book or article today?",
    "Did you avoid using your phone during meals?",
    "Have you completed a task you’ve been putting off?",
    "Did you express gratitude to someone today?",
    "Have you laughed or smiled genuinely today?",
  ];

  // Function to calculate progress
  double _calculateProgress() {
    print(_checkedCount);
    return _checkedCount / questions.length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFBCF7C5),
      appBar: const AppBarWidget(
        text: 'DAILY PLAN',
        color: Color(0xFFBCF7C5),
        back: SelfCare(),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.stretch, // Ensure children fill the width
              children: [
                // Creating a check on how much you have achieved for a day
                // List of questions and their corresponding checkbox
                Consumer(
                  builder: (context, watch, _) {
                    final checkedStream =
                        ref.watch(checkedStreamProvider(user.uid));
                    return checkedStream.when(
                      data: (checkedList) {
                        _checkedCount =
                            checkedList.where((value) => value).length;
                        print('length: ${checkedList.length}');

                        return Column(
                          children: [
                            //Progress bar for evaluation
                            LinearProgressIndicator(
                              value: _calculateProgress(),
                              minHeight: 10.0,
                              backgroundColor: Colors.red,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.green),
                            ),
                            Column(
                              children:
                                  List.generate(questions.length, (index) {
                                return Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  //Question along with checkbox
                                  child: ListTile(
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadiusDirectional.circular(10),
                                    ),
                                    tileColor: Colors.white.withOpacity(0.5),
                                    title: Text(
                                      questions[index],
                                      style: const TextStyle(
                                        fontFamily: 'OtomanopeeOne',
                                        fontSize: 15.0,
                                        color: Color(0xFF726662),
                                      ),
                                    ),
                                    trailing: Checkbox(
                                      value: checkedList[index],
                                      onChanged: (newValue) {
                                        ref
                                            .read(selfCareNotifierProvider
                                                .notifier)
                                            .updateCheckedIndex(user.uid, index,
                                                !checkedList[index]);
                                        //ref.refresh(checkedStreamProvider(user.uid));
                                      },
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ],
                        );
                      },
                      loading: () =>
                          const Center(child: CircularProgressIndicator()),
                      error: (error, stackTrace) => Text('Error: $error'),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
