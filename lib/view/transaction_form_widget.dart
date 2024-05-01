import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TransactionFormWidget extends StatefulWidget {
  final void Function(String, double) addTransaction;

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

  void _onSubmitForm() {
    if (_formKey.currentState!.validate()) {
      var title = _titleController.text;
      var value = double.tryParse(_valueController.text) ?? 0.0;
      widget.addTransaction(title, value);

      _titleController.clear();
      _valueController.clear();
      _formKey.currentState!.reset();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  key: _titleKey,
                  controller: _titleController,
                  decoration: const InputDecoration(
                    labelText: 'Descrição',
                    hintText: 'Camisa Azul',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == '') {
                      return 'O campo titulo não pode ser vazio!';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  key: _valueKey,
                  controller: _valueController,
                  decoration: const InputDecoration(
                    labelText: 'Valor R\$',
                    hintText: '10.99',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                        RegExp(r'^\d+\.?\d{0,2}')),
                  ],
                  validator: (value) {
                    if (value == '') {
                      return 'O Campo não pode ser vazio';
                    }
                    return null;
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: _onSubmitForm,
                      child: const Text('Nova Transação'),
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
