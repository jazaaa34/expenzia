
import 'package:flutter/material.dart';
import 'page5.dart';

const Color appTeal = Color(0xFF2F817B);
const Color navTeal = Color(0xFF438D87);

class Page4 extends StatefulWidget {
  const Page4({super.key});

  @override
  State<Page4> createState() => _Page4State();
}

class _CreditItem {
  final String name;
  final String plan;
  final String due;
  final String amount;

  _CreditItem({
    required this.name,
    required this.plan,
    required this.due,
    required this.amount,
  });
}

class _Page4State extends State<Page4> {
  String creditType = 'Subscriptions';
  String planType = 'Monthly';

  final TextEditingController recipientController =
  TextEditingController(text: 'Netflix');

  DateTime selectedDate = DateTime(2026, 2, 22);

  int selectedIndex = 2;

  final List<_CreditItem> savedItems = [
    _CreditItem(
      name: 'Netflix',
      plan: 'Monthly',
      due: 'Today',
      amount: '₹ 850.00',
    ),
    _CreditItem(
      name: 'Rohith',
      plan: 'One-Time',
      due: 'On 10/12/26',
      amount: '₹ 18,500.00',
    ),
    _CreditItem(
      name: 'Electricity Bill',
      plan: 'Monthly',
      due: 'On 05/11/26',
      amount: '₹ 850.00',
    ),
  ];

  @override
  void dispose() {
    recipientController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: appTeal,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  String _formatDate(DateTime date) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];

    const weekdays = [
      'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'
    ];

    return '${weekdays[date.weekday - 1]}, '
        '${date.day.toString().padLeft(2, '0')} '
        '${months[date.month - 1]} ${date.year}';
  }

  void _saveCredit() {
    final name = recipientController.text.trim();

    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a recipient'),
        ),
      );
      return;
    }

    setState(() {
      savedItems.insert(
        0,
        _CreditItem(
          name: name,
          plan: planType,
          due: 'On ${selectedDate.day.toString().padLeft(2, '0')}/'
              '${selectedDate.month.toString().padLeft(2, '0')}/'
              '${selectedDate.year.toString().substring(2)}',
          amount: '₹ 850.00',
        ),
      );
    });

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const Page5(),
      ),
    );
  }

  void _openProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const Page5(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Teal app header
            Container(
              height: 118,
              width: double.infinity,
              color: appTeal,
              alignment: Alignment.center,
              child: const Padding(
                padding: EdgeInsets.only(top: 18),
                child: Text(
                  'Credit',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(21, 19, 21, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _label('CREDIT TYPE'),
                    const SizedBox(height: 7),

                    _dropdown(
                      value: creditType,
                      items: const [
                        'Subscriptions',
                        'Personal',
                        'Shopping',
                        'Bills',
                        'Other',
                      ],
                      onChanged: (value) {
                        if (value != null) {
                          setState(() => creditType = value);
                        }
                      },
                    ),

                    const SizedBox(height: 13),

                    _label('TO'),
                    const SizedBox(height: 7),

                    TextField(
                      controller: recipientController,
                      decoration: _inputDecoration(),
                      style: const TextStyle(fontSize: 13),
                    ),

                    const SizedBox(height: 13),

                    _label('DATE'),
                    const SizedBox(height: 7),

                    InkWell(
                      onTap: _selectDate,
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        height: 45,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0xFFDDDDDD),
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                _formatDate(selectedDate),
                                style: const TextStyle(
                                  color: Color(0xFF666666),
                                  fontSize: 13,
                                ),
                              ),
                            ),
                            const Icon(
                              Icons.calendar_month,
                              color: Colors.grey,
                              size: 19,
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 13),

                    _label('PLAN TYPE'),
                    const SizedBox(height: 7),

                    _dropdown(
                      value: planType,
                      items: const [
                        'Monthly',
                        'Weekly',
                        'Yearly',
                        'One-Time',
                      ],
                      onChanged: (value) {
                        if (value != null) {
                          setState(() => planType = value);
                        }
                      },
                    ),

                    const SizedBox(height: 14),

                    SizedBox(
                      width: double.infinity,
                      height: 53,
                      child: ElevatedButton(
                        onPressed: _saveCredit,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: appTeal,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text(
                          'Save',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 25),

                    const Text(
                      'Your Saved Lists',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 9),

                    ...savedItems.map(
                          (item) => _savedItem(item),
                    ),
                  ],
                ),
              ),
            ),

            _bottomNavigation(),
          ],
        ),
      ),
    );
  }

  Widget _label(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 10,
        color: Color(0xFF666666),
        letterSpacing: 0.6,
      ),
    );
  }

  InputDecoration _inputDecoration() {
    return InputDecoration(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 14,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: Color(0xFFDDDDDD),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: Color(0xFFDDDDDD),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: appTeal,
        ),
      ),
    );
  }

  Widget _dropdown({
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      height: 45,
      padding: const EdgeInsets.symmetric(horizontal: 11),
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xFFDDDDDD),
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          icon: const Icon(
            Icons.keyboard_arrow_down,
            color: Colors.grey,
          ),
          style: const TextStyle(
            color: Color(0xFF666666),
            fontSize: 13,
          ),
          items: items.map((item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _savedItem(_CreditItem item) {
    final isToday = item.due == 'Today';

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFF1F1F1),
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 5),
                RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      fontSize: 11,
                      color: Colors.grey,
                    ),
                    children: [
                      const TextSpan(text: 'Due '),
                      TextSpan(
                        text: item.due,
                        style: TextStyle(
                          color: isToday
                              ? Colors.red
                              : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                item.plan,
                style: const TextStyle(
                  fontSize: 11,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                item.amount,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _bottomNavigation() {
    return SizedBox(
      height: 71,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          Container(
            height: 71,
            color: navTeal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _navButton(Icons.home_outlined, 0),
                _navButton(Icons.history, 1),
                const SizedBox(width: 65),
                _navButton(Icons.account_balance_wallet_outlined, 2),
                _navButton(Icons.person_outline, 3),
              ],
            ),
          ),
          Positioned(
            top: -36,
            child: Container(
              width: 73,
              height: 73,
              decoration: BoxDecoration(
                color: navTeal,
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: 6,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: IconButton(
                onPressed: _openProfile,
                icon: const Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 31,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _navButton(IconData icon, int index) {
    return IconButton(
      onPressed: () {
        if (index == 3) {
          _openProfile();
        } else {
          setState(() => selectedIndex = index);
        }
      },
      icon: Icon(
        icon,
        size: 28,
        color: selectedIndex == index
            ? Colors.white
            : const Color(0xFF286D69),
      ),
    );
  }
}
