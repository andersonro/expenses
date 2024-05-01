import 'dart:math';

import 'package:expenses/model/transaction_model.dart';
import 'package:expenses/view/card_transaction_widget.dart';
import 'package:expenses/view/chart_card_widget.dart';
import 'package:expenses/view/transaction_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<TransactionModel> _transactions = [];

  _loadTransactions() {
    for (var i = 1; i < 15; i++) {
      _transactions.add(TransactionModel(
          id: '$i-',
          title: 'Teste $i',
          value: (13.10 * i),
          date: DateTime.now().subtract(Duration(days: i))));
    }
  }

  void addTransaction(String vTitle, double vValue) {
    setState(() {
      _transactions.add(TransactionModel(
          id: Random().nextDouble().toString(),
          title: vTitle,
          value: vValue,
          date: DateTime.now()));
    });
    Navigator.of(context).pop();
  }

  List<TransactionModel> get _recentTransactions {
    return _transactions.where((element) {
      return element.date
          .isAfter(DateTime.now().subtract(const Duration(days: 7)));
    }).toList();
  }

  _onShowModalTransactionForm(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) => TransactionFormWidget(addTransaction: addTransaction),
    );
  }

  @override
  void initState() {
    super.initState();
    _loadTransactions();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Minhas despesas"),
          actions: [
            IconButton(
              onPressed: () => _onShowModalTransactionForm(context),
              icon: const Icon(Icons.add),
            )
          ],
        ),
        body: Column(
          children: [
            SizedBox(
              height: 120,
              width: double.infinity,
              child: ChartCardWidget(transactions: _recentTransactions),
            ),
            Expanded(
              flex: 1,
              child: SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: _transactions.isNotEmpty
                    ? ListView.builder(
                        itemCount: _transactions.length,
                        itemBuilder: (context, index) {
                          var transaction = _transactions[index];
                          return Card(
                            elevation: 4,
                            color: const Color.fromARGB(255, 248, 247, 247),
                            shadowColor: Theme.of(context).primaryColor,
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Theme.of(context).primaryColor,
                                radius: 30,
                                child: Padding(
                                  padding: EdgeInsets.all(6),
                                  child: FittedBox(
                                    child: Text(
                                      'R\$ ${transaction.value.toStringAsFixed(2)}',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                              title: Text(transaction.title),
                              subtitle: Text(
                                DateFormat('dd/MM/yyyy HH:mm:ss')
                                    .format(transaction.date),
                                style: const TextStyle(fontSize: 10),
                              ),
                              trailing: IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {},
                              ),
                            ),
                          );
                        },
                      )
                    : const Center(
                        child: Text("Nenhuma despesa cadastrada."),
                      ),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _onShowModalTransactionForm(context),
          child: const Icon(
            Icons.add,
          ),
        ),
      ),
    );
  }
}
