
import 'package:flutter/material.dart';
import 'transc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  // Navigate to the transactions page
  void _openTransactions() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const TransactionPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const teal = Color(0xFF30847F);
    const green = Color(0xFF0BB66A);
    const red = Color(0xFFFF4545);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Greeting
                    const Text(
                      'Good afternoon,',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 2),
                    const Text(
                      'Sahal Muhammed',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),

                    const SizedBox(height: 15),

                    // Total balance card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(17),
                      decoration: BoxDecoration(
                        color: teal,
                        borderRadius: BorderRadius.circular(17),
                        boxShadow: [
                          BoxShadow(
                            color: teal.withValues(alpha: 0.20),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Total Balance',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(height: 5),
                          const Text(
                            '\$ 2,548.00',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 23),
                          Row(
                            children: [
                              Expanded(
                                child: _balanceItem(
                                  icon: Icons.arrow_downward,
                                  title: 'Income',
                                  amount: '\$1,840.00',
                                ),
                              ),
                              Expanded(
                                child: _balanceItem(
                                  icon: Icons.arrow_upward,
                                  title: 'Expenses',
                                  amount: '\$284.00',
                                  alignEnd: true,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 27),

                    // Daily average and weekly cards
                    Row(
                      children: [
                        Expanded(
                          child: _averageCard(
                            title: 'DAILY AVERAGE',
                            amount: '\$1,548.00',
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _averageCard(
                            title: 'WEEKLY',
                            amount: '\$548.00',
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 26),

                    // Transaction heading
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Transactions History',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextButton(
                          onPressed: _openTransactions,
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: const Size(35, 30),
                            tapTargetSize:
                            MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: const Text(
                            'See all',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    // Transaction 1
                    _transactionItem(
                      title: 'Upwork',
                      date: 'Today',
                      amount: '+ \$ 850.00',
                      amountColor: green,
                    ),

                    const SizedBox(height: 17),

                    // Transaction 2
                    _transactionItem(
                      title: 'Transfer',
                      date: 'Yesterday',
                      amount: '- \$ 85.00',
                      amountColor: red,
                    ),

                    const SizedBox(height: 17),

                    // Transaction 3
                    _transactionItem(
                      title: 'Paypal',
                      date: 'Jan 30, 2022',
                      amount: '+ \$ 1,406.00',
                      amountColor: green,
                    ),
                  ],
                ),
              ),
            ),

            // Bottom navigation bar
            SizedBox(
              height: 65,
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.topCenter,
                children: [
                  Container(
                    height: 65,
                    width: double.infinity,
                    color: const Color(0xFF438D87),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _navIcon(Icons.home_outlined, 0),
                        _navIcon(Icons.history, 1),
                        const SizedBox(width: 60),
                        _navIcon(
                          Icons.account_balance_wallet_outlined,
                          2,
                        ),
                        _navIcon(Icons.person_outline, 3),
                      ],
                    ),
                  ),

                  // Center plus button
                  Positioned(
                    top: -32,
                    child: Container(
                      width: 69,
                      height: 69,
                      decoration: BoxDecoration(
                        color: const Color(0xFF438D87),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                          width: 6,
                        ),
                      ),
                      child: IconButton(
                        onPressed: _openTransactions,
                        icon: const Icon(
                          Icons.add,
                          size: 31,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Balance card income and expenses
  Widget _balanceItem({
    required IconData icon,
    required String title,
    required String amount,
    bool alignEnd = false,
  }) {
    return Column(
      crossAxisAlignment:
      alignEnd ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment:
          alignEnd ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
              width: 19,
              height: 19,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.20),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 13,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 6),
            Text(
              title,
              style: const TextStyle(
                color: Color(0xFFD6E9E7),
                fontSize: 13,
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Text(
          amount,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  // Daily and weekly average cards
  Widget _averageCard({
    required String title,
    required String amount,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 10,
            color: Colors.grey,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          height: 56,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: const Color(0xFFDDDDDD),
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              amount,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Transaction row
  Widget _transactionItem({
    required String title,
    required String date,
    required String amount,
    required Color amountColor,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                date,
                style: const TextStyle(
                  fontSize: 10,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
        Text(
          amount,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: amountColor,
          ),
        ),
      ],
    );
  }

  // Bottom navigation icons
  Widget _navIcon(IconData icon, int index) {
    return IconButton(
      onPressed: () {
        if (index == 1) {
          _openTransactions();
        } else {
          setState(() {
            selectedIndex = index;
          });
        }
      },
      icon: Icon(
        icon,
        size: 27,
        color: selectedIndex == index
            ? Colors.white
            : const Color(0xFF286D69),
      ),
    );
  }
}
