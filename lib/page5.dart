
import 'package:flutter/material.dart';
import 'page4.dart';

class Page5 extends StatefulWidget {
  const Page5({super.key});

  @override
  State<Page5> createState() => _Page5State();
}

class _Page5State extends State<Page5> {
  final TextEditingController nameController =
  TextEditingController(text: 'Sahal Muhammed');

  bool isEditing = false;
  int selectedIndex = 3;

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  void _clearStorage() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Storage cleared'),
      ),
    );
  }

  void _openCreditPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const Page4(),
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
            // Profile header
            Container(
              height: 118,
              width: double.infinity,
              color: appTeal,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.chevron_left,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 18),
                    child: Text(
                      'Profile',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Profile content
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 25,
                    vertical: 20,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Avatar and camera button
                      SizedBox(
                        width: 120,
                        height: 120,
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              width: 106,
                              height: 106,
                              decoration: const BoxDecoration(
                                color: Color(0xFFB5B5B5),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.person,
                                size: 95,
                                color: Color(0xFFE8E8E8),
                              ),
                            ),
                            Positioned(
                              right: 2,
                              bottom: 12,
                              child: Container(
                                width: 39,
                                height: 39,
                                decoration: BoxDecoration(
                                  color: appTeal,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 4,
                                  ),
                                ),
                                child: IconButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: () {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          'Add image picker functionality here',
                                        ),
                                      ),
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.camera_alt,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 7),

                      // Editable profile name
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: isEditing
                                ? SizedBox(
                              width: 220,
                              child: TextField(
                                controller: nameController,
                                autofocus: true,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                                decoration: const InputDecoration(
                                  isDense: true,
                                  border: UnderlineInputBorder(),
                                ),
                                onSubmitted: (_) {
                                  setState(() {
                                    isEditing = false;
                                  });
                                },
                              ),
                            )
                                : Text(
                              nameController.text,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF292929),
                              ),
                            ),
                          ),
                          IconButton(
                            visualDensity: VisualDensity.compact,
                            onPressed: () {
                              setState(() {
                                if (isEditing) {
                                  isEditing = false;
                                } else {
                                  isEditing = true;
                                }
                              });
                            },
                            icon: Icon(
                              isEditing ? Icons.check : Icons.edit,
                              color: Colors.grey,
                              size: 16,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),

                      // Clear storage button
                      OutlinedButton(
                        onPressed: _clearStorage,
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.grey,
                          side: const BorderSide(
                            color: Color(0xFFDDDDDD),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(22),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 17,
                            vertical: 9,
                          ),
                        ),
                        child: const Text(
                          'Clear Storage',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Bottom navigation
            _bottomNavigation(),
          ],
        ),
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
                onPressed: _openCreditPage,
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
        if (index == 2) {
          _openCreditPage();
        } else if (index == 3) {
          setState(() => selectedIndex = index);
        } else if (index == 0) {
          Navigator.popUntil(context, (route) => route.isFirst);
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
