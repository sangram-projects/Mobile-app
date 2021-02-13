import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:second_app/widgets/chart.dart';
import './widgets/newTransactions.dart';
import './widgets/transactionList.dart';
import './models/transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'खर्चा बुक',
      debugShowCheckedModeBanner: false,
      
      theme: ThemeData(
          primarySwatch: Colors.cyan,
          accentColor: Colors.deepPurple,
          errorColor: Colors.blueGrey,
          fontFamily: 'QuickSand',
          textTheme: ThemeData.light().textTheme.copyWith(
                  title: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 18,
                color: Colors.blueGrey,
                fontWeight: FontWeight.bold,
              )),
          appBarTheme: AppBarTheme(
            color: Colors.orange[400],
            textTheme: ThemeData.light().textTheme.copyWith(
                    title: TextStyle(
                fontFamily: 'OpenSans',
                  fontSize: 25,
                  
                  fontWeight: FontWeight.bold,
                )),
          )),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransaction = [
    //   Transaction(
    //     id: 't1',
    //     title: 'shoes',
    //     amount: 20.33,
    //     date: DateTime.now(),
    //   ),
    //   Transaction(
    //     id: 't2',
    //     title: 'Shirt',
    //     amount: 77,
    //     date: DateTime.now(),
    //   ),
  ];

  List<Transaction> get _recentTransactions {
    return _userTransaction.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransactions(String txTitle, double txAmount, DateTime chosenDate) {
    final newTx = Transaction(
      amount: txAmount,
      title: txTitle,
      id: DateTime.now().toString(),
      date: chosenDate,
    );
    setState(() {
      _userTransaction.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: (ctx),
      builder: (_) {
        return GestureDetector(
          child: NewTransactions(_addNewTransactions),
          behavior: HitTestBehavior.opaque,
          onTap: () {},
        );
      },
    );
  }

void _deleteTransaction(String id){
setState(() {
  _userTransaction.removeWhere((tx) => tx.id == id);
});
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[100],
      appBar: AppBar(
        title: Text(
          'खर्चा बुक',
         // style: TextStyle(color: Colors.orange),
        ),
        actions: [
          FloatingActionButton(
          
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () => _startAddNewTransaction(context),
            elevation: 0,
            backgroundColor: Colors.orange[400],
            //backgroundColor: Theme.of(context).primaryColor,
          ),
        ],
      ),
      body: SingleChildScrollView(
        
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Chart(_recentTransactions),
            TransactionList(_userTransaction, _deleteTransaction),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        focusColor: Colors.green,
        child: Icon(
          Icons.add,
          size: 40,
          
        ),
        //backgroundColor: Theme.of(context).primaryColor,
        backgroundColor: Colors.orange[400],
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}
