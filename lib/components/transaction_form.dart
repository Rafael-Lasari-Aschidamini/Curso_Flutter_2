import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class TransectionForm extends StatelessWidget {
  TransectionForm({super.key});

  final titleController = TextEditingController();
  final valueController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
              ),
            ),
            TextField(
              controller: valueController,
              decoration: const InputDecoration(
                labelText: 'Valor (R\$)',
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                  ),
                  onPressed: () {
                    if (kDebugMode) {
                      print(titleController.text);
                    }
                    if (kDebugMode) {
                      print(valueController.text);
                    }
                  },
                  child: const Text(
                    'Nova Transação',
                    style: TextStyle(
                      color: Colors.purple,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
