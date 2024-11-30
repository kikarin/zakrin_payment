import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'dart:math';

class AddCardPage extends StatefulWidget {
  @override
  _AddCardPageState createState() => _AddCardPageState();
}

class _AddCardPageState extends State<AddCardPage> {
  String selectedBank = 'VISA';
  final cardNumberController = TextEditingController();
  final cardHolderController = TextEditingController();
  final expiryController = TextEditingController();
  final cvvController = TextEditingController();
  final cardNameController = TextEditingController();

  final List<Map<String, dynamic>> bankOptions = [
    {
      'name': 'VISA',
      'gradient': [Color(0xFF1D1D1D), Color(0xFF525252)],
      'logo': 'images/visa.jpg',
    },
    {
      'name': 'BCA',
      'gradient': [Color(0xFF2C3E7B), Color(0xFF4B6CB7)],
      'logo': 'images/bca.jpg',
    },
    {
      'name': 'Mandiri',
      'gradient': [Color.fromARGB(255, 180, 198, 255), Color.fromARGB(255, 16, 43, 80)],
      'logo': 'images/mandiri.png',
    },
    {
      'name': 'BNI',
      'gradient': [Color(0xFF614385), Color(0xFF516395)],
      'logo': 'images/bni.png',
    },
    {
      'name': 'BRI',
      'gradient': [Color(0xFF2193b0), Color(0xFF6dd5ed)],
      'logo': 'images/bri.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
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
          'Add New Card',
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
            SizedBox(height: 24),
            Text(
              'Select Bank',
              style: TextStyle(
                color: AppTheme.colorSecondary,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Color(0xFFE0E0E0)),
              ),
              child: DropdownButton<String>(
                value: selectedBank,
                isExpanded: true,
                underline: SizedBox(),
                items: bankOptions.map<DropdownMenuItem<String>>((bank) {
                  return DropdownMenuItem<String>(
                    value: bank['name'],
                    child: Text(
                      bank['name'],
                      style: TextStyle(
                        color: AppTheme.colorSecondary,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedBank = value!;
                  });
                },
              ),
            ),
            SizedBox(height: 24),
            _buildCardPreview(),
            SizedBox(height: 24),
            _buildTextField(
              label: 'Card Number',
              controller: cardNumberController,
              hint: '**** **** **** ****',
            ),
            SizedBox(height: 16),
            _buildTextField(
              label: 'Card Holder Name',
              controller: cardHolderController,
              hint: 'Enter card holder name',
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildTextField(
                    label: 'Expiry Date',
                    controller: expiryController,
                    hint: 'MM/YY',
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: _buildTextField(
                    label: 'CVV',
                    controller: cvvController,
                    hint: '***',
                    isPassword: true,
                  ),
                ),
              ],
            ),
            SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  if (_validateInputs()) {
                    Navigator.pop(context, {
                      'bankName': selectedBank,
                      'cardNumber': '**** **** **** ${cardNumberController.text.substring(max(0, cardNumberController.text.length - 4))}',
                      'cardType': cardHolderController.text.toUpperCase(),
                      'expiry': expiryController.text,
                      'gradient': bankOptions.firstWhere((bank) => bank['name'] == selectedBank)['gradient'],
                      'logo': bankOptions.firstWhere((bank) => bank['name'] == selectedBank)['logo'],
                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Please fill all required fields')),
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
                  'Add Card',
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

  Widget _buildCardPreview() {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: bankOptions.firstWhere((bank) => bank['name'] == selectedBank)['gradient'],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 12,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Bank Logo & Name
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
                    bankOptions.firstWhere((bank) => bank['name'] == selectedBank)['logo'],
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(width: 12),
                Text(
                  selectedBank,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          // Card Number
          Positioned(
            left: 24,
            top: 90,
            child: Text(
              cardNumberController.text.isEmpty 
                  ? '**** **** **** ****' 
                  : cardNumberController.text.replaceAllMapped(
                      RegExp(r'.{4}'), (match) => '${match.group(0)} '
                    ),
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                letterSpacing: 1.5,
              ),
            ),
          ),
          // Card Holder
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
                  cardHolderController.text.isEmpty 
                      ? 'YOUR NAME' 
                      : cardHolderController.text.toUpperCase(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          // Expiry Date
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
                  expiryController.text.isEmpty ? 'MM/YY' : expiryController.text,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          // Chip
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
    );
  }

  bool _validateInputs() {
    return cardNumberController.text.isNotEmpty &&
           cardHolderController.text.isNotEmpty &&
           expiryController.text.isNotEmpty &&
           cvvController.text.isNotEmpty;
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required String hint,
    bool isPassword = false,
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
          obscureText: isPassword,
          onChanged: (value) {
            setState(() {});
          },
          decoration: InputDecoration(
            hintText: hint,
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