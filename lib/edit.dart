
import 'package:flutter/material.dart';
import 'add.dart';
import 'transc.dart';

class EditTransactionPage extends StatelessWidget {
  final TransactionData transaction;
  final ValueChanged<TransactionData>? onSave;

  const EditTransactionPage({
    super.key,
    required this.transaction,
    this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Keep the existing UI unchanged
        TransactionPage(
          pageTitle: 'Edit Transaction',
          initialData: transaction,
          onSave: onSave,
        ),

        // Button to open add.dart page
        Positioned(
          right: 16,
          top: 4,
          child: SafeArea(
            child: IconButton(
              tooltip: 'Add transaction',
              icon: const Icon(
                Icons.add_circle_outline,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TransactionHistoryPage(),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
