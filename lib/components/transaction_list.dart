import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projeto_despesas/models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transections;
  const TransactionList(
    List<Transaction> transactions, {
    super.key,
    required this.transections,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: transections.map((tr) {
        return Card(
            child: Row(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: BoxDecoration(
                  border: Border.all(
                color: Colors.purple,
                width: 2,
              )),
              padding: const EdgeInsets.all(5),
              child: Text(
                'R\$ ${tr.value.toStringAsFixed(2)}',
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.purple),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tr.title,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  DateFormat('d MMM y').format(tr.date),
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            )
          ],
        ));
      }).toList(),
    );
  }
}
