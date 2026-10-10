import 'package:flutter/material.dart';
import 'edit.dart';

const Color appTeal = Color(0xFF30847F);
const Color navTeal = Color(0xFF438D87);
const Color incomeGreen = Color(0xFF0BB66A);
const Color expenseRed = Color(0xFFFF4545);

class TransactionData {
  String type;
  String name;
  String amount;
  DateTime date;

  TransactionData({
    this.type = 'Expense',
    this.name = '',
    this.amount = '',
    DateTime? date,
  }) : date = date ?? DateTime(2026, 2, 22);
}

String moneyText(String amount) {
  final clean = amount.trim().replaceAll('\$', '').replaceAll('₹', '').trim();
  return '₹ ${clean.isEmpty ? '0.00' : clean}';
}

String dateText(DateTime date) {
  const weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  const months = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
  ];
  return '${weekdays[date.weekday - 1]}, '
      '${date.day.toString().padLeft(2, '0')} '
      '${months[date.month - 1]} ${date.year}';
}

class TransactionPage extends StatefulWidget {
  final TransactionData? initialData;
  final String pageTitle;
  final ValueChanged<TransactionData>? onSave;

  const TransactionPage({
    super.key,
    this.initialData,
    this.pageTitle = 'Transaction',
    this.onSave,
  });

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  late final TextEditingController _nameController;
  late final TextEditingController _amountController;
  late String _type;
  late DateTime _date;

  @override
  void initState() {
    super.initState();
    final data = widget.initialData ?? TransactionData();
    _nameController = TextEditingController(text: data.name);
    _amountController = TextEditingController(text: data.amount);
    _type = data.type;
    _date = data.date;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  Future<void> _chooseDate() async {
    final selected = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (selected != null) {
      setState(() => _date = selected);
    }
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
        title: Text(
          widget.pageTitle,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(17, 17, 17, 20),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(14, 21, 14, 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(17),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.07),
                        blurRadius: 20,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _fieldLabel('TRANSACTION TYPE'),
                      const SizedBox(height: 6),
                      Container(
                        height: 34,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xFFE3E3E3)),
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: _type,
                            isExpanded: true,
                            icon: const Icon(
                              Icons.keyboard_arrow_down,
                              size: 18,
                              color: Colors.grey,
                            ),
                            style: const TextStyle(
                              fontSize: 11,
                              color: Color(0xFF555555),
                            ),
                            items: const [
                              DropdownMenuItem(
                                  value: 'Expense', child: Text('Expense')),
                              DropdownMenuItem(
                                  value: 'Income', child: Text('Income')),
                            ],
                            onChanged: (value) {
                              if (value != null) {
                                setState(() => _type = value);
                              }
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),
                      _fieldLabel('NAME'),
                      const SizedBox(height: 6),
                      _textField(_nameController, hint: 'Netflix'),
                      const SizedBox(height: 16),
                      _fieldLabel('AMOUNT'),
                      const SizedBox(height: 6),
                      Container(
                        height: 34,
                        decoration: BoxDecoration(
                          border: Border.all(color: appTeal),
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: Row(
                          children: [
                            const SizedBox(width: 10),
                            const Text(
                              '₹',
                              style: TextStyle(
                                color: appTeal,
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(width: 5),
                            Expanded(
                              child: TextField(
                                controller: _amountController,
                                keyboardType:
                                const TextInputType.numberWithOptions(
                                  decimal: true,
                                ),
                                style: const TextStyle(
                                  fontSize: 11,
                                  color: appTeal,
                                ),
                                decoration: const InputDecoration(
                                  hintText: '48.00',
                                  hintStyle: TextStyle(
                                    fontSize: 11,
                                    color: appTeal,
                                  ),
                                  border: InputBorder.none,
                                  isDense: true,
                                  contentPadding: EdgeInsets.zero,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () => _amountController.clear(),
                              style: TextButton.styleFrom(
                                padding:
                                const EdgeInsets.symmetric(horizontal: 8),
                                minimumSize: Size.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              child: const Text(
                                'Clear',
                                style: TextStyle(fontSize: 9, color: appTeal),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 17),
                      _fieldLabel('DATE'),
                      const SizedBox(height: 6),
                      InkWell(
                        onTap: _chooseDate,
                        borderRadius: BorderRadius.circular(7),
                        child: Container(
                          height: 34,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xFFE3E3E3)),
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  dateText(_date),
                                  style: const TextStyle(
                                    fontSize: 10,
                                    color: Color(0xFF666666),
                                  ),
                                ),
                              ),
                              const Icon(
                                Icons.calendar_month,
                                size: 15,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 47),
              child: SizedBox(
                width: double.infinity,
                height: 40,
                child: ElevatedButton(
                  onPressed: () {
                    final data = TransactionData(
                      type: _type,
                      name: _nameController.text.trim(),
                      amount: _amountController.text.trim(),
                      date: _date,
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditTransactionPage(transaction: data),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: appTeal,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: const StadiumBorder(),
                  ),
                  child: const Text(
                    'Save',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _fieldLabel(String text) => Text(
  text,
  style: const TextStyle(
    fontSize: 8,
    letterSpacing: 0.7,
    color: Color(0xFF777777),
    fontWeight: FontWeight.w500,
  ),
);

Widget _textField(TextEditingController controller, {String hint = ''}) =>
    SizedBox(
      height: 34,
      child: TextField(
        controller: controller,
        style: const TextStyle(fontSize: 11, color: Color(0xFF555555)),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(fontSize: 11, color: Color(0xFF666666)),
          contentPadding:
          const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7),
            borderSide: const BorderSide(color: Color(0xFFE3E3E3)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7),
            borderSide: const BorderSide(color: Color(0xFFE3E3E3)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7),
            borderSide: const BorderSide(color: appTeal),
          ),
        ),
      ),
    );
