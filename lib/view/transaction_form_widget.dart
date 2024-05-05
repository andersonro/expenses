import 'package:expenses/view/button_adaptative_widget.dart';
import 'package:expenses/view/datepicker_adaptative_widget.dart';
import 'package:expenses/view/text_field_adaptative_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class TransactionFormWidget extends StatefulWidget {
  final void Function(String, double, DateTime) addTransaction;

  const TransactionFormWidget({super.key, required this.addTransaction});

  @override
  State<TransactionFormWidget> createState() => _TransactionFormWidgetState();
}

class _TransactionFormWidgetState extends State<TransactionFormWidget> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _valueController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormFieldState> _titleKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _valueKey = GlobalKey<FormFieldState>();
  DateTime _selectedDate = DateTime.now();

  void _onSubmitForm() {
    if (_formKey.currentState!.validate()) {
      var title = _titleController.text;
      var value = double.tryParse(_valueController.text) ?? 0.0;

      widget.addTransaction(title, value, _selectedDate);

      _titleController.clear();
      _valueController.clear();
      _formKey.currentState!.reset();
      setState(() {});
      FocusScope.of(context).requestFocus(FocusNode());
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        child: Container(
          padding: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              bottom: 10 + MediaQuery.of(context).viewInsets.bottom),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFieldAdaptativeWidget(
                  keyTextField: _titleKey,
                  controller: _titleController,
                  label: 'Descrição',
                  isValidate: true,
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFieldAdaptativeWidget(
                  keyTextField: _valueKey,
                  controller: _valueController,
                  label: 'Valor R\$',
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  isValidate: true,
                  filteringTextInputFormatter:
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^\d+\.?\d{0,2}')),
                ),
                const SizedBox(height: 6),
                DatepickerAdaptativeWidget(
                    dateSelected: _selectedDate,
                    onDateChanged: (newDate) {
                      setState(() {
                        _selectedDate = newDate;
                      });
                    }),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ButtonAdaptativeWidget(
                      label: 'Nova Transação',
                      fn: _onSubmitForm,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
