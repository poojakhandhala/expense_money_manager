import 'package:flutter/material.dart';

class TransactionCard extends StatelessWidget {
  final Map<String, dynamic> transaction;

  const TransactionCard({required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Date: ${transaction["date"]}",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text("Customer: ${transaction["customer"]}"),
            Text("Description: ${transaction["description"]}"),
            Text(
              "Amount: ₹${transaction["amount"]}",
              style: TextStyle(
                color:
                    transaction["transactionType"] == "Given"
                        ? Colors.green
                        : Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
