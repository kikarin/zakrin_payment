import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../models/transfer_history.dart';
import '../widgets/card_template.dart';

class MobileRechargePage extends StatefulWidget {
  final List<Map<String, dynamic>> userCards;

  const MobileRechargePage({
    Key? key,
    required this.userCards,
  }) : super(key: key);

  @override
  _MobileRechargePageState createState() => _MobileRechargePageState();
}

class _MobileRechargePageState extends State<MobileRechargePage> {
  final phoneController = TextEditingController();
  final amountController = TextEditingController();
  String selectedProvider = 'Telkomsel';
  Map<String, dynamic>? selectedCard;

  final List<Map<String, dynamic>> providers = [
    {
      'name': 'Telkomsel',
      'icon': Icons.cell_tower,
      'color': Color(0xFFFF6B6B),
    },
    {
      'name': 'Indosat',
      'icon': Icons.cell_tower,
      'color': Color(0xFF4ECDC4),
    },
    {
      'name': 'XL',
      'icon': Icons.cell_tower,
      'color': Color(0xFF45B7D1),
    },
    {
      'name': 'Smartfren',
      'icon': Icons.cell_tower,
      'color': Color(0xFFFF9F43),
    },
  ];

  final List<String> quickAmounts = ['10', '20', '50', '100'];

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
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppTheme.colorSecondary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Mobile Recharge',
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
              'Via Card',
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
                  'Please add a card first to make recharge',
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
                      child: buildCardTemplate(
                        card: card,
                        isSelected: selectedCard == card,
                      ),
                    );
                  },
                ),
              ),
            SizedBox(height: 24),
            _buildTextField(
              label: 'Phone Number',
              controller: phoneController,
              hint: 'Enter phone number',
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 24),
            Text(
              'Select Amount',
              style: TextStyle(
                color: AppTheme.colorSecondary,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 16),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: quickAmounts.map((amount) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      amountController.text = amount;
                    });
                  },
                  child: Container(
                    width: (MediaQuery.of(context).size.width - 64) / 2,
                    height: 48,
                    decoration: BoxDecoration(
                      color: amountController.text == amount
                          ? Color(0xFF37D69E)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: amountController.text == amount
                            ? Color(0xFF37D69E)
                            : Color(0xFFE0E0E0),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        '\$$amount',
                        style: TextStyle(
                          color: amountController.text == amount
                              ? Colors.white
                              : AppTheme.colorSecondary,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 16),
            _buildTextField(
              label: 'Custom Amount',
              controller: amountController,
              hint: 'Enter amount',
              keyboardType: TextInputType.number,
              prefix: Text('\$ ', style: TextStyle(color: AppTheme.colorSecondary)),
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
                                      'Recharge Successful!',
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
                                    SizedBox(height: 24),
                                    ElevatedButton(
                                      onPressed: () {
                                        // Create transfer history
                                        final history = TransferHistory(
                                          bankName: selectedProvider,
                                          accountNumber: phoneController.text,
                                          amount: amountController.text,
                                          date: DateTime.now(),
                                          note: 'Mobile Recharge',
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
                  backgroundColor: Color(0xFF37D69E),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Recharge Now',
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
    );
  }

  bool _validateInputs() {
    return phoneController.text.isNotEmpty && amountController.text.isNotEmpty;
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required String hint,
    TextInputType? keyboardType,
    Widget? prefix,
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
} 