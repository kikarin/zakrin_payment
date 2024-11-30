import 'package:flutter/material.dart';
import '../pages/all_cards_page.dart';
import '../pages/add_card_page.dart';
import '../pages/home_page.dart';
import '../pages/profile_page.dart';
import '../pages/transfer_page.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final List<Map<String, dynamic>> cards;
  final Function(Map<String, dynamic>) onAddCard;
  final Function(int) onRemoveCard;
  final String userName;
  final String userEmail;

  const BottomNavBar({
    Key? key,
    required this.currentIndex,
    required this.cards,
    required this.onAddCard,
    required this.onRemoveCard,
    required this.userName,
    required this.userEmail,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 118,
      child: Stack(
        children: [
          // Bottom Navigation Bar Background
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              width: 375,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: Offset(0, -5),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNavItem(
                    icon: Icons.home,
                    isSelected: currentIndex == 0,
                    onTap: () {
                      if (currentIndex != 0) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomePage(
                              userName: userName,
                              userEmail: userEmail,
                            ),
                          ),
                        );
                      }
                    },
                  ),
                  _buildNavItem(
                    icon: Icons.swap_horiz,
                    isSelected: currentIndex == 1,
                    onTap: () {
                      if (currentIndex != 1) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TransferPage(
                              userCards: cards,
                            ),
                          ),
                        );
                      }
                    },
                  ),
                  SizedBox(width: 50), // Space for FAB
                  _buildNavItem(
                    icon: Icons.account_balance_wallet_outlined,
                    isSelected: currentIndex == 2,
                    onTap: () {
                      if (currentIndex != 2) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AllCardsPage(
                              cards: cards,
                              onRemoveCard: onRemoveCard,
                              onAddCard: onAddCard,
                            ),
                          ),
                        );
                      }
                    },
                  ),
                  _buildNavItem(
                    icon: Icons.person_outline,
                    isSelected: currentIndex == 3,
                    onTap: () {
                      if (currentIndex != 3) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProfilePage(
                              userName: userName,
                              userEmail: userEmail,
                              onUpdateProfile: (newName, newEmail) {
                                // Ini akan dihandle di HomePage
                              },
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
          // Add Button (FAB)
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            child: Center(
              child: GestureDetector(
                onTap: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddCardPage()),
                  );
                  
                  if (result != null) {
                    onAddCard(result);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Card added successfully')),
                    );
                  }
                },
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: ShapeDecoration(
                    color: Color(0xFF608EE9),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 3, color: Colors.white),
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Container(
      width: 28,
      height: 28,
      child: IconButton(
        padding: EdgeInsets.zero,
        icon: Icon(
          icon,
          color: isSelected 
              ? Color(0xFF608EE9)
              : Color.fromARGB(255, 136, 139, 145),
          size: 24,
        ),
        onPressed: onTap,
      ),
    );
  }
} 