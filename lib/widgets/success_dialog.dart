import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class SuccessDialog extends StatelessWidget {
  final String amount;
  final String bankName;
  final String accountNumber;

  const SuccessDialog({
    Key? key,
    required this.amount,
    required this.bankName,
    required this.accountNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
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
              'Amount: \$$amount',
              style: TextStyle(
                color: AppTheme.colorSecondary,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              'To: $bankName - $accountNumber',
              style: TextStyle(
                color: AppTheme.colorSecondary.withOpacity(0.7),
                fontSize: 14,
              ),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
                Navigator.pop(context); // Return to previous screen
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF608EE9),
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
    );
  }
} 