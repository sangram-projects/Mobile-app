import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransactions extends StatefulWidget {
  final Function displayTx;
  NewTransactions(this.displayTx);

  @override
  _NewTransactionsState createState() => _NewTransactionsState();
}

class _NewTransactionsState extends State<NewTransactions> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  void _submitData() {
    if(_amountController.text.isEmpty){
      return;
    }
    final enterdTitle = _titleController.text;
    final enterdAmount = double.parse(_amountController.text);
    if (enterdTitle.isEmpty || enterdAmount <= 0  || _selectedDate == null) {
      return;
    }
    widget.displayTx(enterdTitle, enterdAmount, _selectedDate);
    Navigator.of(context).pop();
    _amountController.clear();
    _titleController.clear();
   
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.teal[50],
      elevation: 15,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Title',
              ),
              controller: _titleController,
              onSubmitted: (_) => _submitData(),
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Amount',
              ),
              controller: _amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _submitData(),
            ),
            Container(
              height: 70,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      _selectedDate == null
                          ? 'No Date Choosen!'
                          : 'Picked Date: ${DateFormat.yMd().format(_selectedDate)}',
                    ),
                  ),
                  FlatButton(
                    textColor: Theme.of(context).primaryColor,
                    child: Text(
                      'Choose Date',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: _presentDatePicker,
                  )
                ],
              ),
            ),
            RaisedButton(
              textColor: Colors.white,
              color: Theme.of(context).primaryColor,
              shape: OutlineInputBorder(
                  borderSide: BorderSide(
                      style: BorderStyle.solid,
                      width: 1.0,
                      color: Colors.blueAccent),
                  borderRadius: new BorderRadius.circular(20.0)),
              child: Text(
                "Add Transaction",
              ),
              onPressed: _submitData,
            ),
          ],
        ),
      ),
    );
  }
}
