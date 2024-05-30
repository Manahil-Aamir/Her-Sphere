import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hersphere/providers/task_provider.dart';
import 'package:hersphere/providers/taskstream_provider.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:flutter/material.dart';
import 'package:hersphere/pages/impwidgets/appbar.dart';
import 'package:hersphere/pages/tasktrackerpages/tasktracker.dart';

class Expenses extends ConsumerStatefulWidget {
  const Expenses({Key? key}) : super(key: key);

  @override
  ConsumerState<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends ConsumerState<Expenses> {
  TextEditingController _amountController = TextEditingController();
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
              child: Consumer(
                builder: (context, watch, _) {
                  final taskModelAsync = ref.watch(taskStreamProvider(user.uid));
                  final remainingStream = ref.watch(remainingStreamProvider(user.uid));
                  return taskModelAsync.when(
                    data: (taskModel) {
                      if (taskModel != null) {
                        print(taskModel);
                        return Column(
                          children: [
                            Expanded(
                              child: GridView.count(
                                crossAxisCount: 2,
                                crossAxisSpacing: 2.0,
                                mainAxisSpacing: 2.0,
                                childAspectRatio: 4.1 / 3,
                                children: [
                                  _buildExpenseTile(context, 'Housing', taskModel.housing),
                                  _buildExpenseTile(context, 'Transportation', taskModel.transportation),
                                  _buildExpenseTile(context, 'Food', taskModel.food),
                                  _buildExpenseTile(context, 'Healthcare', taskModel.healthcare),
                                  _buildExpenseTile(context, 'Utilities', taskModel.utilities),
                                  _buildExpenseTile(context, 'Misc', taskModel.misc),
                                  _buildTotalTile(context, 'Total', taskModel.total),
                                  _buildRemainingTile(context, 'Remaining', remainingStream),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                            PieChart(
                              dataMap: {
                                'Housing': taskModel.housing.toDouble(),
                                'Transportation': taskModel.transportation.toDouble(),
                                'Food': taskModel.food.toDouble(),
                                'Healthcare': taskModel.healthcare.toDouble(),
                                'Utilities': taskModel.utilities.toDouble(),
                                'Misc': taskModel.misc.toDouble(),
                              },
                              animationDuration: const Duration(milliseconds: 800),
                              chartLegendSpacing: 32.0,
                              chartRadius: MediaQuery.of(context).size.width / 3.2,
                              initialAngleInDegree: 0,
                              chartType: ChartType.disc,
                              ringStrokeWidth: 32,
                              centerText: "Expenses",
                              legendOptions: const LegendOptions(
                                showLegendsInRow: false,
                                legendPosition: LegendPosition.right,
                                showLegends: true,
                                legendShape: BoxShape.circle,
                                legendTextStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              chartValuesOptions: const ChartValuesOptions(
                                showChartValues: true,
                                showChartValuesInPercentage: true,
                                showChartValuesOutside: false,
                                decimalPlaces: 1,
                              ),
                            ),
                          ],
                        );
                      } else {
                        return const CircularProgressIndicator();
                      }
                    },
                    loading: () => Center(child: const CircularProgressIndicator()),
                    error: (error, stackTrace) {
                      return Text('Error: $error');
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExpenseTile(BuildContext context, String attributeName, int value) {
    String name = '';
    if(attributeName == 'Transportation'){
      name= 'Transport';
    } 
    else {
      name = attributeName;
    }
    print(attributeName.toLowerCase());
    return ListTile(
      tileColor: Colors.white,
      title: Text(
        name,
        style: const TextStyle(
          fontFamily: 'OtomanopeeOne',
          fontSize: 12.0,
          color: Color(0xFF726662),
        ),
      ),
      subtitle: Text(
        value.toString(),
        style: const TextStyle(
          fontFamily: 'OtomanopeeOne',
          color: Color(0xFF726662),
        ),
      ),
      trailing: IconButton(
        icon: const Icon(Icons.edit, color: Color(0xFF726662)),
        onPressed: () {
          _changeVal(context, attributeName.toLowerCase(), value);
          print('hello');
        },
      ),
    );
  }

  Widget _buildTotalTile(BuildContext context, String attributeName, int value) {
    print(attributeName.toLowerCase());
    return ListTile(
      tileColor: Colors.white,
      title: Text(
        attributeName,
        style: const TextStyle(
          fontFamily: 'OtomanopeeOne',
          fontSize: 12.0,
          color: Color(0xFF726662),
        ),
      ),
      subtitle: Text(
        value.toString(),
        style: const TextStyle(
          fontFamily: 'OtomanopeeOne',
          color: Color(0xFF726662),
        ),
      ),
      trailing: IconButton(
        icon: const Icon(Icons.edit, color: Color(0xFF726662)),
        onPressed: () {
          _changeVal(context, attributeName.toLowerCase(), value);
        },
      ),
    );
  }

  Widget _buildRemainingTile(BuildContext context, String attributeName, AsyncValue<int> remainingStream) {
    return ListTile(
      tileColor: Colors.white,
      title: Text(
        attributeName,
        style: const TextStyle(
          fontFamily: 'OtomanopeeOne',
          fontSize: 12.0,
          color: Color(0xFF726662),
        ),
      ),
      subtitle: remainingStream.when(
        data: (remaining) => Text(
          remaining.toString(),
          style: const TextStyle(
            fontFamily: 'OtomanopeeOne',
            color: Color(0xFF726662),
          ),
        ),
        loading: () => const CircularProgressIndicator(),
        error: (error, stackTrace) => Text('Error: $error'),
      ),
    );
  }

  void _changeVal(BuildContext context, String attributeName, int value) {
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
              final newValue = int.parse(_amountController.text);
              _amountController.text = '';
              Navigator.of(context).pop();
              ref.read(taskNotifierProvider.notifier).updateTaskIntValue(user.uid, attributeName, newValue);
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

}