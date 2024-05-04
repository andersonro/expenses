import 'package:expenses/model/transaction_model.dart';
import 'package:expenses/view/chart_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChartCardWidget extends StatelessWidget {
  final List<TransactionModel> transactions;

  const ChartCardWidget({super.key, required this.transactions});

  bool _compareOnlyByDate(DateTime dt1, DateTime dt2) {
    var i = DateTime(dt1.year, dt1.month, dt1.day).compareTo(
      DateTime(dt2.year, dt2.month, dt2.day),
    );
    return i == 0;
  }

  List<Map<String, Object>> get _groupedTransactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double totalSum = 0.0;

      for (var i = 0; i < transactions.length; i++) {
        bool sameDay = transactions[i].date.day == weekDay.day;
        bool sameMonth = transactions[i].date.month == weekDay.month;
        bool sameYear = transactions[i].date.year == weekDay.year;

        if (sameDay && sameMonth && sameYear) {
          totalSum += transactions[i].value;
        }
      }
      //DateFormat.E().format(weekDay)[0] - dia da semana primeira letra
      return {
        'day': DateFormat('dd/MM').format(weekDay),
        'value': totalSum * 5,
        'actual': _compareOnlyByDate(weekDay, DateTime.now()),
      };
    });
  }

  double get _weekTotalTransaction {
    return _groupedTransactions.fold(0.0, (sum, item) {
      return sum + (double.tryParse(item['value'].toString()) ?? 0.00);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(10),
      child: ListView(
        reverse: true,
        scrollDirection: Axis.horizontal,
        children: _groupedTransactions.map((transaction) {
          return ChartBarWidget(
            label: transaction['day'].toString(),
            value: double.tryParse(transaction['value'].toString()) ?? 0.00,
            percente: _weekTotalTransaction == 0
                ? 0
                : (double.tryParse(transaction['value'].toString()) ?? 0.00) /
                    _weekTotalTransaction,
            dayActual: bool.tryParse(transaction['actual'].toString()) ?? false,
          );
        }).toList(),
      ),
    );
  }
}
