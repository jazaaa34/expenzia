import 'package:flutter/material.dart';
import 'transc.dart';
import 'edit.dart';
import 'page4.dart' hide appTeal, navTeal;
import 'page5.dart';

class TransactionHistoryPage extends StatefulWidget {
  const TransactionHistoryPage({super.key});

  @override
  State<TransactionHistoryPage> createState() => _TransactionHistoryPageState();
}

class _TransactionHistoryPageState extends State<TransactionHistoryPage> {
  final List<TransactionData> _transactions = [
    TransactionData(type: 'Income', name: 'Upwork', amount: '850.00',
        date: DateTime(2026, 10, 10)),
    TransactionData(type: 'Expense', name: 'Transfer', amount: '85.00',
        date: DateTime(2026, 10, 9)),
    TransactionData(type: 'Income', name: 'Paypal', amount: '1,406.00',
        date: DateTime(2022, 1, 30)),
    TransactionData(type: 'Expense', name: 'Youtube', amount: '11.99',
        date: DateTime(2022, 1, 16)),
  ];

  String _shortDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final d = DateTime(date.year, date.month, date.day);
    if (d == today) return 'Today';
    if (d == today.subtract(const Duration(days: 1))) return 'Yesterday';
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }


  Future<void> _editTransaction(int index) async {
    final result = await Navigator.push<TransactionData>(
      context,
      MaterialPageRoute(
        builder: (_) => EditTransactionPage(transaction: _transactions[index]),
      ),
    );
    if (result != null) setState(() => _transactions[index] = result);
  }

  void _deleteTransaction(int index) {
    setState(() => _transactions.removeAt(index));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Transaction deleted')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: appTeal,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text('Transaction History',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
      ),
      body: SafeArea(
        child: ListView.separated(
          padding: const EdgeInsets.fromLTRB(14, 18, 14, 95),
          itemCount: _transactions.length,
          separatorBuilder: (context, index) => const SizedBox(height: 17),
          itemBuilder: (context, index) {
            final transaction = _transactions[index];
            final isIncome = transaction.type == 'Income';
            final amountColor = isIncome ? const Color(0xFF0BB66A) : const Color(0xFFFF4545);
            final prefix = isIncome ? '+ ' : '- ';
            return Dismissible(
              key: ObjectKey(transaction),
              direction: DismissDirection.endToStart,
              background: Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 20),
                color: const Color(0xFFFF4545),
                child: const Icon(Icons.delete, color: Colors.white),
              ),
              onDismissed: (_) => _deleteTransaction(index),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(transaction.name,
                            style: const TextStyle(fontSize: 11,
                                color: Colors.black, fontWeight: FontWeight.w500)),
                        const SizedBox(height: 5),
                        Text(_shortDate(transaction.date),
                            style: const TextStyle(fontSize: 9, color: Colors.grey)),
                      ],
                    ),
                  ),
                  Text('$prefix${moneyText(transaction.amount)}',
                      style: TextStyle(fontSize: 12, color: amountColor,
                          fontWeight: FontWeight.w600)),
                  const SizedBox(width: 4),
                  SizedBox(
                    width: 30,
                    height: 28,
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      tooltip: 'Edit',
                      onPressed: () => _editTransaction(index),
                      icon: const Icon(Icons.edit, size: 15, color: Colors.black87),
                    ),
                  ),
                  SizedBox(
                    width: 30,
                    height: 28,
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      tooltip: 'Delete',
                      onPressed: () => _deleteTransaction(index),
                      icon: const Icon(Icons.delete, size: 15, color: Color(0xFFFF4545)),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: Container(
        height: 54,
        color: navTeal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _navIcon(Icons.home_outlined, () => Navigator.pop(context)),
            _navIcon(Icons.history, () {}),
            const SizedBox(width: 42),
            _navIcon(Icons.account_balance_wallet_outlined, () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const Page4()),
              );
            }),
            _navIcon(Icons.person_outline, () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const Page5()),
              );
            }),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 25),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 5),
          ),
          child: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const Page4()),
              );
            },
            backgroundColor: navTeal,
            elevation: 0,
            shape: const CircleBorder(),
            child: const Icon(Icons.add, color: Colors.white, size: 29),
          ),
        ),
      ),
    );
  }

  Widget _navIcon(IconData icon, VoidCallback onPressed) => IconButton(
    onPressed: onPressed,
    icon: Icon(icon, size: 25, color: const Color(0xFF286D69)),
  );
}
