import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../models/transfer_history.dart';
import '../widgets/card_template.dart';

class BillPaymentsPage extends StatefulWidget {
  final List<Map<String, dynamic>> userCards;

  const BillPaymentsPage({
    Key? key,
    required this.userCards,
  }) : super(key: key);

  @override
  _BillPaymentsPageState createState() => _BillPaymentsPageState();
}

class _BillPaymentsPageState extends State<BillPaymentsPage> {
  final accountNumberController = TextEditingController();
  final amountController = TextEditingController();
  String selectedBill = 'Electricity';
  Map<String, dynamic>? selectedCard;

  final List<Map<String, dynamic>> billTypes = [
    {
      'name': 'Electricity',
      'icon': Icons.electric_bolt,
      'color': Color(0xFFFF6B6B),
    },
    {
      'name': 'Water',
      'icon': Icons.water_drop,
      'color': Color(0xFF4ECDC4),
    },
    {
      'name': 'Internet',
      'icon': Icons.wifi,
      'color': Color(0xFF45B7D1),
    },
    {
      'name': 'TV Cable',
      'icon': Icons.tv,
      'color': Color(0xFFFF9F43),
    },
    {
      'name': 'Gas',
      'icon': Icons.local_fire_department,
      'color': Color(0xFFDA35C9),
    },
  ];

  final List<String> quickAmounts = ['50', '100', '150', '200'];

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
          'Bill Payments',
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
                  'Please add a card first to make payments',
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
            Text(
              'Select Bill Type',
              style: TextStyle(
                color: AppTheme.colorSecondary,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 16),
            Container(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: billTypes.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedBill = billTypes[index]['name'];
                      });
                    },
                    child: Container(
                      width: 80,
                      margin: EdgeInsets.only(right: 16),
                      decoration: BoxDecoration(
                        color: selectedBill == billTypes[index]['name']
                            ? billTypes[index]['color']
                            : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: selectedBill == billTypes[index]['name']
                              ? billTypes[index]['color']
                              : Color(0xFFE0E0E0),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            billTypes[index]['icon'],
                            color: selectedBill == billTypes[index]['name']
                                ? Colors.white
                                : billTypes[index]['color'],
                            size: 32,
                          ),
                          SizedBox(height: 8),
                          Text(
                            billTypes[index]['name'],
                            style: TextStyle(
                              color: selectedBill == billTypes[index]['name']
                                  ? Colors.white
                                  : AppTheme.colorSecondary,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
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
              label: 'Customer Number',
              controller: accountNumberController,
              hint: 'Enter customer number',
              keyboardType: TextInputType.number,
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
                          ? billTypes.firstWhere((bill) => bill['name'] == selectedBill)['color']
                          : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: amountController.text == amount
                            ? billTypes.firstWhere((bill) => bill['name'] == selectedBill)['color']
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
                                      'Payment Successful!',
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
                                          bankName: selectedBill,
                                          accountNumber: accountNumberController.text,
                                          amount: amountController.text,
                                          date: DateTime.now(),
                                          note: 'Bill Payment',
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
                  backgroundColor: billTypes.firstWhere((bill) => bill['name'] == selectedBill)['color'],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Pay Now',
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
    return accountNumberController.text.isNotEmpty && amountController.text.isNotEmpty;
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