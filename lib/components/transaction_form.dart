import 'dart:async';
import 'adaptative_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'adaptative_date_picker.dart';
import 'adaptative_text_fild.dart';

class TransectionForm extends StatefulWidget {
  final dynamic Function(String, double, DateTime) onSubmit;

  const TransectionForm(this.onSubmit, {super.key});

  @override
  State<TransectionForm> createState() => _TransectionFormState();
}

class _TransectionFormState extends State<TransectionForm> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  _submitForm() {
    final title = _titleController.text;
    final value = double.tryParse(_valueController.text) ?? 0.0;

    if (title.isEmpty || value <= 0 || _selectedDate == null) {
      return;
    }

    widget.onSubmit(title, value, _selectedDate);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.only(
            top: 10,
            right: 10,
            left: 10,
            bottom: 10 + MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            children: <Widget>[
              AdaptativeTextFild(
                controller: _titleController,
                label: 'Title',
              ),
              AdaptativeTextFild(
                controller: _valueController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                onSubmitted: (value) => _submitForm(),
                label: 'Valor (R\$)',
              ),
              AdaptativeDatePicker(
                  selectedDate: _selectedDate,
                  onDateChanged: (newDate) {
                    setState(
                      () {
                        _selectedDate = newDate;
                      },
                    );
                  }),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  AdaptativeButton(
                    label: 'Nova Transação',
                    onPressed: _submitForm,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  FutureOr pickedDate(DateTime? value) {}
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
        .add(DiagnosticsProperty<DateTime?>('_selectedDate', _selectedDate));
  }
}
