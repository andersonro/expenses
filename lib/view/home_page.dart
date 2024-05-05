import 'dart:math';
import 'dart:io';

import 'package:expenses/model/transaction_model.dart';
import 'package:expenses/view/chart_card_widget.dart';
import 'package:expenses/view/transaction_form_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<TransactionModel> _transactions = [];
  bool _isChart = false;

  _loadTransactions() {
    for (var i = 1; i < 15; i++) {
      _transactions.add(TransactionModel(
          id: '$i-',
          title: 'Teste $i',
          value: (13.10 * i),
          date: DateTime.now().subtract(Duration(days: i))));
    }
  }

  void addTransaction(String vTitle, double vValue, DateTime vDate) {
    setState(() {
      _transactions.add(TransactionModel(
        id: Random().nextDouble().toString(),
        title: vTitle,
        value: vValue,
        date: vDate,
      ));
    });
    Navigator.of(context).pop();
  }

  _deleteTransaction(String id) {
    setState(() {
      _transactions.removeWhere((element) => element.id == id);
    });
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

  Widget _getIconButton(IconData icon, Function() fn) {
    return Platform.isIOS
        ? GestureDetector(
            onTap: fn,
            child: Icon(icon),
          )
        : IconButton(
            onPressed: fn,
            icon: Icon(icon),
          );
  }

  @override
  Widget build(BuildContext context) {
    final _isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    final actions = [
      if (_isLandscape)
        _getIconButton(
          (_isChart ? Icons.list : Icons.bar_chart),
          () {
            setState(() {
              _isChart = !_isChart;
            });
          },
        ),
      _getIconButton(Platform.isIOS ? CupertinoIcons.add : Icons.add,
          () => _onShowModalTransactionForm(context)),
    ];

    final appBar = AppBar(
      title: const Text("Minhas despesas"),
      actions: actions,
    );

    final availableHeight = MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).viewInsets.bottom;

    final bodyPage = SafeArea(
      child: Column(
        children: [
          if (_isChart || !_isLandscape)
            SizedBox(
              height: availableHeight * (_isLandscape ? 0.7 : 0.2),
              child: ChartCardWidget(transactions: _recentTransactions),
            ),
          if (!_isChart || !_isLandscape)
            Container(
              padding: const EdgeInsets.all(4),
              height: availableHeight * (_isLandscape ? 0.9 : 0.8),
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
                                padding: const EdgeInsets.all(6),
                                child: FittedBox(
                                  child: Text(
                                    'R\$ ${transaction.value.toStringAsFixed(2)}',
                                    style: const TextStyle(color: Colors.white),
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
                              onPressed: () {
                                _deleteTransaction(transaction.id);
                              },
                            ),
                          ),
                        );
                      },
                    )
                  : const Center(
                      child: Text("Nenhuma despesa cadastrada."),
                    ),
            ),
        ],
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              middle: const Text("Minhas despesas"),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: actions,
              ),
            ),
            child: bodyPage,
          )
        : SafeArea(
            child: Scaffold(
              appBar: appBar,
              body: bodyPage,
              floatingActionButton: Platform.isIOS
                  ? Container()
                  : FloatingActionButton(
                      onPressed: () => _onShowModalTransactionForm(context),
                      child: const Icon(
                        Icons.add,
                      ),
                    ),
            ),
          );
  }
}
