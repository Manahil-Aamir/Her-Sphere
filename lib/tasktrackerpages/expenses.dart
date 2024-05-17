import 'package:pie_chart/pie_chart.dart';
import 'package:flutter/material.dart';
import 'package:hersphere/impwidgets/appbar.dart';
import 'package:hersphere/tasktrackerpages/task.dart';
import 'package:hersphere/tasktrackerpages/tasktracker.dart';

class Expenses extends StatefulWidget {
  const Expenses({Key? key}) : super(key: key);

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  TextEditingController _amountController = new TextEditingController();
  int total = 0;
  int remaining = 0;

  //List of common expenses
  List<List<dynamic>> expenses = [
    ['Housing', 0],
    ['Transportation', 0],
    ['Food', 0],
    ['Healthcare', 0],
    ['Utilities', 0],
    ['Misc', 0],
  ];

  void remainingAmount() {
    int r = total;
    for (int i = 0; i < expenses.length; i++) {
      r -= expenses[i][1] as int;
    }
    setState(() {
      remaining = r;
    });
  }

  void changeVal(BuildContext context, int i) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Enter Amount',
            style: TextStyle(
              fontFamily: 'OtomanopeeOne',
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Color(0xFF726662),
            ),
          ),
          content: TextField(
            controller: _amountController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            style: const TextStyle(
              fontFamily: 'OtomanopeeOne',
              fontSize: 16.0,
              color: Color(0xFF726662),
            ),
            decoration: const InputDecoration(
              labelText: 'Amount',
              labelStyle: TextStyle(
                fontFamily: 'OtomanopeeOne',
                fontSize: 16.0,
                color: Color(0xFF726662),
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Cancel',
                style: TextStyle(
                  fontFamily: 'OtomanopeeOne',
                  fontSize: 16.0,
                  color: Color(0xFF726662),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                remainingAmount();
                // You can access the entered amount here
                Navigator.of(context).pop();
                setState(() {
                  expenses[i][1] = _amountController.text;
                });
              },
              child: const Text(
                'OK',
                style: TextStyle(
                  fontFamily: 'OtomanopeeOne',
                  fontSize: 16.0,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFB5EFFC),
      appBar: const AppBarWidget(
        text: 'EXPENSES',
        color: Color(0xFFB5EFFC),
        back: TaskTracker(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                  itemCount: expenses.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 2.0,
                    mainAxisSpacing: 2.0,
                    childAspectRatio: 4.1 / 3,
                  ),
                  itemBuilder: (context, index) {
                    final expense = expenses[index];
                    _amountController =
                        TextEditingController(text: expense[1].toString());
                    return ListTile(
                      tileColor: Colors.white,
                      title: Text(expense[0],
                          style: const TextStyle(
                            fontFamily: 'OtomanopeeOne',
                            fontSize: 12.0,
                            color: Color(0xFF726662),
                          )),
                      subtitle: Text(expense[1].toString(),
                          style: const TextStyle(
                            fontFamily: 'OtomanopeeOne',
                            color: Color(0xFF726662),
                          )),
                      trailing: IconButton(
                        icon: const Icon(Icons.edit, color: Color(0xFF726662)),
                        onPressed: () {
                          changeVal(context, index);
                        },
                      ),
                    );
                  }),
            ),
            Row(
              children: [
                const Text("Total: ",
                    style: TextStyle(
                      fontFamily: 'OtomanopeeOne',
                      color: Color(0xFF726662),
                      fontSize: 20,
                    )),
                Container(
                  width: 100,
                  height: 40,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Text(total.toString(),
                      style: const TextStyle(
                        fontFamily: 'OtomanopeeOne',
                        color: Color(0xFF726662),
                      )),
                )
              ],
            ),
            const SizedBox(height: 10),
                        Row(
              children: [
                const Text("Remaining Amount: ",
                    style: TextStyle(
                      fontFamily: 'OtomanopeeOne',
                      color: Color(0xFF726662),
                      fontSize: 20,
                    )),
                Container(
                  width: 100,
                  height: 40,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Text(remaining.toString(),
                      style: const TextStyle(
                        fontFamily: 'OtomanopeeOne',
                        color: Color(0xFF726662),
                      )),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
