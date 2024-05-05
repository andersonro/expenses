import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatepickerAdaptativeWidget extends StatelessWidget {
  final DateTime dateSelected;
  final Function(DateTime) onDateChanged;

  const DatepickerAdaptativeWidget(
      {super.key, required this.dateSelected, required this.onDateChanged});

  _showModalDatePicker(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      onDateChanged(pickedDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? SizedBox(
            height: 180,
            child: CupertinoDatePicker(
              onDateTimeChanged: onDateChanged,
              mode: CupertinoDatePickerMode.date,
              initialDateTime: DateTime.now(),
              minimumDate: DateTime(2019),
              maximumDate: DateTime.now(),
            ),
          )
        : Row(
            children: [
              Expanded(
                child: Text(
                  'Data selecionada ${DateFormat('dd/MM/yyyy').format(dateSelected)}',
                ),
              ),
              IconButton(
                onPressed: () => _showModalDatePicker(context),
                icon: const Icon(Icons.calendar_month_outlined),
                color: Theme.of(context).primaryColor,
              )
            ],
          );
  }
}
