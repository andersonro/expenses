import 'package:flutter/material.dart';

class TransactionCategoriesModel {
  final UniqueKey id = UniqueKey();
  final String description;

  TransactionCategoriesModel(this.description);

  List<TransactionCategoriesModel> getTransactionCategoriesList() {
    List<TransactionCategoriesModel> list = [];
    list.add(TransactionCategoriesModel('Alimentação'));
    list.add(TransactionCategoriesModel('Veículo'));
    list.add(TransactionCategoriesModel('Casa'));
    list.add(TransactionCategoriesModel('Diversão'));
    list.add(TransactionCategoriesModel('Saúde'));
    list.add(TransactionCategoriesModel('Outros'));
    return [];
  }
}
