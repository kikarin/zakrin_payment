import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/bottom_nav_bar.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../models/transfer_history.dart';

class TransferPage extends StatefulWidget {
  final List<Map<String, dynamic>> userCards;

  const TransferPage({
    Key? key,
    required this.userCards,
  }) : super(key: key);

  @override
  _TransferPageState createState() => _TransferPageState();
}

class _TransferPageState extends State<TransferPage> {
  final accountNumberController = TextEditingController();
  final amountController = TextEditingController();
  final noteController = TextEditingController();
  String selectedBank = 'BCA';
  Map<String, dynamic>? selectedCard;

  @override
  void initState() {
    super.initState();
    if (widget.userCards.isNotEmpty) {
      selectedCard = widget.userCards[0];
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();
    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Transfer',
          style: TextStyle(
            color: AppTheme.colorSecondary,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'via transfer',
              style: TextStyle(
                color: AppTheme.colorSecondary,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 16),
            if (widget.userCards.isEmpty)
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Please add a card first to make transfers',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 14,
                  ),
                ),
              )
            else
              Container(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.userCards.length,
                  itemBuilder: (context, index) {
                    final card = widget.userCards[index];
                    final isSelected = selectedCard == card;
                    
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedCard = card;
                        });
                      },
                      child: Container(
                        width: 300,
                        margin: EdgeInsets.only(right: 16),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: card['gradient'],
                          ),
                          borderRadius: BorderRadius.circular(20),
                          border: isSelected 
                            ? Border.all(color: Colors.blue, width: 2)
                            : null,
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              left: 24,
                              top: 24,
                              child: Row(
                                children: [
                                  Container(
                                    width: 50,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    padding: EdgeInsets.all(4),
                                    child: Image.asset(
                                      card['logo'],
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  SizedBox(width: 12),
                                  Text(
                                    card['bankName'],
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              left: 24,
                              top: 90,
                              child: Text(
                                card['cardNumber'],
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 1.5,
                                ),
                              ),
                            ),
                            Positioned(
                              left: 24,
                              bottom: 50,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'CARD HOLDER',
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.7),
                                      fontSize: 12,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    card['cardType'],
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              right: 24,
                              bottom: 50,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    'VALID THRU',
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.7),
                                      fontSize: 12,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    card['expiry'],
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              right: 24,
                              top: 24,
                              child: Container(
                                width: 45,
                                height: 35,
                                decoration: BoxDecoration(
                                  color: Colors.amber.withOpacity(0.8),
                                  borderRadius: BorderRadius.circular(6),
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.amber.shade300,
                                      Colors.amber.shade600,
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            SizedBox(height: 24),
            _buildTextField(
              label: 'Account Number',
              controller: accountNumberController,
              hint: 'Enter account number',
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            _buildTextField(
              label: 'Amount',
              controller: amountController,
              hint: 'Enter amount',
              keyboardType: TextInputType.number,
              prefix: Text('\$ ', style: TextStyle(color: AppTheme.colorSecondary)),
            ),
            SizedBox(height: 16),
            _buildTextField(
              label: 'Note (Optional)',
              controller: noteController,
              hint: 'Enter transfer note',
              maxLines: 3,
            ),
            SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: widget.userCards.isEmpty || selectedCard == null
                    ? null
                    : () {
                        if (_validateInputs()) {
                          showDialog(
                            context: context,
                            builder: (context) => Dialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Container(
                                padding: EdgeInsets.all(24),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      width: 60,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        color: Color(0xFF37D69E).withOpacity(0.1),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Icons.check_circle,
                                        color: Color(0xFF37D69E),
                                        size: 40,
                                      ),
                                    ),
                                    SizedBox(height: 16),
                                    Text(
                                      'Transfer Successful!',
                                      style: TextStyle(
                                        color: AppTheme.colorSecondary,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      'Amount: \$${amountController.text}',
                                      style: TextStyle(
                                        color: AppTheme.colorSecondary,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      'From: ${selectedCard!['bankName']} - ${selectedCard!['cardNumber']}',
                                      style: TextStyle(
                                        color: AppTheme.colorSecondary.withOpacity(0.7),
                                        fontSize: 14,
                                      ),
                                    ),
                                    if (noteController.text.isNotEmpty) ...[
                                      SizedBox(height: 4),
                                      Text(
                                        'Note: ${noteController.text}',
                                        style: TextStyle(
                                          color: AppTheme.colorSecondary.withOpacity(0.7),
                                          fontSize: 14,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                    SizedBox(height: 24),
                                    ElevatedButton(
                                      onPressed: () {
                                        // Create transfer history
                                        final history = TransferHistory(
                                          bankName: selectedBank,
                                          accountNumber: accountNumberController.text,
                                          amount: amountController.text,
                                          date: DateTime.now(),
                                          note: noteController.text,
                                        );

                                        Navigator.pop(context); // Close dialog
                                        Navigator.pop(context, history); // Return to previous screen with history data
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Color(0xFF608EE9),
                                        minimumSize: Size(double.infinity, 50),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                      ),
                                      child: Text(
                                        'Done',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF608EE9),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Transfer Now',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: 1,
        cards: [],
        onAddCard: (card) {},
        onRemoveCard: (index) {},
        userName: userProvider.userName,
        userEmail: userProvider.userEmail,
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required String hint,
    TextInputType? keyboardType,
    Widget? prefix,
    int? maxLines,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: AppTheme.colorSecondary,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines ?? 1,
          decoration: InputDecoration(
            hintText: hint,
            prefix: prefix,
            hintStyle: TextStyle(color: Colors.grey),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Color(0xFFE0E0E0)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Color(0xFFE0E0E0)),
            ),
          ),
        ),
      ],
    );
  }

  bool _validateInputs() {
    if (accountNumberController.text.isEmpty || amountController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill required fields')),
      );
      return false;
    }
    return true;
  }
} 