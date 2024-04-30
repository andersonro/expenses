import 'dart:ffi';
import 'dart:math';

import 'package:expenses/model/transaction_model.dart';
import 'package:expenses/view/card_transaction_widget.dart';
import 'package:expenses/view/transaction_form_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<TransactionModel> _transactions = [];

  loadTransactions() {
    for (var i = 1; i < 10; i++) {
      _transactions.add(TransactionModel(
          id: '$i-',
          title: 'Teste $i',
          value: (13.10 * i),
          date: DateTime.now()));
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
  }

  @override
  void initState() {
    super.initState();
    loadTransactions();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("My Expenses"),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.add),
              color: Colors.white,
            )
          ],
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 50,
              width: double.infinity,
              child: Card(
                elevation: 4,
                child: Text(
                  "Gráfico",
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: ListView.builder(
                  reverse: true,
                  itemCount: _transactions.length,
                  itemBuilder: (context, index) {
                    var transaction = _transactions[index];
                    return CardTransactionWidget(
                        value: transaction.value,
                        date: transaction.date,
                        title: transaction.title);
                  },
                ),
              ),
            ),
            TransactionFormWidget(addTransaction: addTransaction)
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () {},
          backgroundColor: Colors.blue,
        ),
      ),
    );
  }
}
