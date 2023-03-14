import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projeto_despesas/components/transaction_form.dart';
import 'dart:math';
import 'dart:io';
import 'components/chart.dart';
import 'components/transaction_list.dart';
import 'models/transaction.dart';

main() => runApp(const ExpensesApp());

class ExpensesApp extends StatefulWidget {
  const ExpensesApp({super.key});

  @override
  State<ExpensesApp> createState() => _ExpensesAppState();
}

class _ExpensesAppState extends State<ExpensesApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MyHomePage(),
      theme: ThemeData(
          primarySwatch: Colors.purple,
          fontFamily: 'Quicksend',
          textTheme: ThemeData.light().textTheme.copyWith(
              headlineSmall: const TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                  fontWeight: FontWeight.bold))),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transaction = [];
  bool _showChart = false;

  List<Transaction> get _recentTransactions {
    return _transaction.where((tr) {
      return tr.date.isAfter(DateTime.now().subtract(const Duration(days: 7)));
    }).toList();
  }

  _addTransection(String title, double value, DateTime date) {
    final newTransaction = Transaction(
        id: Random().nextDouble().toString(),
        title: title,
        value: value,
        date: date);
    setState(
      () {
        _transaction.add(newTransaction);
      },
    );

    Navigator.of(context).pop();
  }

  _removeTransaction(String id) {
    setState(
      () {
        _transaction.removeWhere((tr) => tr.id == id);
      },
    );
  }

  _opemTransectionFormModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return TransectionForm(_addTransection);
        });
  }

  Widget _getIconButton(IconData icon, Function() fn) {
    return Platform.isIOS
        ? GestureDetector(onTap: fn, child: Icon(icon))
        : IconButton(onPressed: fn, icon: Icon(icon));
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    final iconList = Platform.isIOS ? CupertinoIcons.refresh : Icons.list;
    final chartList =
        Platform.isIOS ? CupertinoIcons.refresh : Icons.show_chart;

    final actions = [
      if (isLandscape)
        _getIconButton(
          _showChart ? iconList : chartList,
          () {
            setState(() {
              _showChart = !_showChart;
            });
          },
        ),
      _getIconButton(
        Platform.isIOS ? CupertinoIcons.add : Icons.add,
        () => _opemTransectionFormModal(context),
      ),
    ];

    // bool verificarIos = Platform.isIOS;
    // PreferredSizeWidget appBar;

    // if (verificarIos) {
    //   appBar = CupertinoNavigationBar(
    //     middle: const Text(
    //       'Despesas Pessoais',
    //     ),
    //     trailing: Row(
    //       children: actions,
    //     ),
    //   );
    // } else {
    //   appBar = AppBar(
    //     title: const Text(
    //       'Despesas Pessoais',
    //     ),
    //     actions: actions,
    //   );
    // }

    // final PreferredSizeWidget appBar = (Platform.isIOS
    //     ? CupertinoNavigationBar(
    //         middle: const Text('Despesas Pessoais'),
    //         trailing: Row(
    //           children: actions,
    //         ))
    //     : AppBar(
    //         title: const Text(
    //           'Despesas Pessoais',
    //         ),
    //         actions: actions) as PreferredSizeWidget);

    PreferredSizeWidget appBar = AppBar(
      title: const Text(
        'Despesas Pessoais',
      ),
      actions: actions,
    );

    final availabeHight = mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top;

    final bodyPage = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            //if (isLandscape)
            //   Row(
            //     children: <Widget>[
            //       const Text('Exibir Gráfico'),
            //       Switch.adaptive(
            //         activeColor: Theme.of(context).colorScheme.secondary,
            //         value: _showChart,
            //         onChanged: (value) {
            //           setState(
            //             () {
            //               _showChart = value;
            //             },
            //           );
            //         },
            //       ),
            //     ],
            //   ),
            if (_showChart || !isLandscape)
              Container(
                height: availabeHight * (isLandscape ? 0.8 : 0.30),
                child: Chart(_recentTransactions),
              ),
            if (!_showChart || !isLandscape)
              Container(
                height: availabeHight * (isLandscape ? 1 : 0.7),
                child: TransactionList(
                  _transaction,
                  transections: _transaction,
                  onRemove: _removeTransaction,
                ),
              ),
          ],
        ),
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              middle: const Text('Despesas Pessoais'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: actions,
              ),
            ),
            child: bodyPage,
          )
        : Scaffold(
            appBar: appBar,
            body: bodyPage,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    onPressed: () => _opemTransectionFormModal(context),
                    child: const Icon(Icons.add),
                  ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
  }
}
