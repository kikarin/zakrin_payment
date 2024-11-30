import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../models/transfer_history.dart';

class RequestMoneyPage extends StatefulWidget {
  @override
  _RequestMoneyPageState createState() => _RequestMoneyPageState();
}

class _RequestMoneyPageState extends State<RequestMoneyPage> {
  final phoneController = TextEditingController();
  final amountController = TextEditingController();
  final noteController = TextEditingController();

  final List<String> quickAmounts = ['10', '20', '50', '100'];

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
          'Request Money',
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
                          ? Color(0xFF3642DA)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: amountController.text == amount
                            ? Color(0xFF3642DA)
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
            SizedBox(height: 16),
            _buildTextField(
              label: 'Note (Optional)',
              controller: noteController,
              hint: 'Enter request note',
              maxLines: 3,
            ),
            SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
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
                                  color: Color(0xFF3642DA).withOpacity(0.1),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.check_circle,
                                  color: Color(0xFF3642DA),
                                  size: 40,
                                ),
                              ),
                              SizedBox(height: 16),
                              Text(
                                'Request Sent!',
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
                                'From: ${phoneController.text}',
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
                                  final history = TransferHistory(
                                    bankName: 'Request Money',
                                    accountNumber: phoneController.text,
                                    amount: amountController.text,
                                    date: DateTime.now(),
                                    note: noteController.text,
                                  );

                                  Navigator.pop(context);
                                  Navigator.pop(context, history);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFF3642DA),
                                  minimumSize: Size(double.infinity, 50),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: Text('Done'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Please fill all required fields')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF3642DA),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Request Now',
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
} 