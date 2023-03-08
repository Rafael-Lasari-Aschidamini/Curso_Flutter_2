import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projeto_despesas/models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transections;
  final void Function(String) onRemove;
  const TransactionList(
    List<Transaction> transactions, {
    super.key,
    required this.transections,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return transections.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
            return Column(
              children: <Widget>[
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Sem Transação Cadastrada',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: constraints.maxHeight * 0.6,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            );
          })
        : ListView.builder(
            itemCount: transections.length,
            itemBuilder: (ctx, index) {
              final tr = transections[index];
              return Card(
                elevation: 5,
                margin: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 5,
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 40,
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: FittedBox(
                        child: Text('R\$${tr.value}'),
                      ),
                    ),
                  ),
                  title: Text(
                    tr.title,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  subtitle: Text(
                    DateFormat('d MMM Y').format(tr.date),
                  ),
                  trailing: MediaQuery.of(context).size.width > 480
                      ? TextButton.icon(
                          style: TextButton.styleFrom(
                              iconColor: Theme.of(context).colorScheme.error),
                          onPressed: () => onRemove(tr.id),
                          icon: const Icon(Icons.delete),
                          label: const Text('Excluir'),
                        )
                      : IconButton(
                          icon: const Icon(Icons.delete),
                          color: Theme.of(context).colorScheme.error,
                          onPressed: () => onRemove(tr.id),
                        ),
                ),
              );
            },
          );
  }
}
