import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../models/notification_model.dart';

class OpenAccountPage extends StatelessWidget {
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
          'Open Account',
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
              'Choose Account Type',
              style: TextStyle(
                color: AppTheme.colorSecondary,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 16),
            _buildAccountTypeCard(
              context,
              'Savings Account',
              'Basic savings account with competitive interest rates',
              Icons.savings,
              Color(0xFFFDEEEA),
              Color(0xFFFF6E66),
            ),
            _buildAccountTypeCard(
              context,
              'Checking Account',
              'Everyday banking with no minimum balance',
              Icons.account_balance_wallet,
              Color(0xFFE4F3F4),
              Color(0xFF37D69E),
            ),
            _buildAccountTypeCard(
              context,
              'Business Account',
              'Designed for small to medium businesses',
              Icons.business,
              Color(0xFFFDEAFC),
              Color(0xFFDA35C9),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAccountTypeCard(
    BuildContext context,
    String title,
    String description,
    IconData icon,
    Color bgColor,
    Color iconColor,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Color(0x141A1F44),
            blurRadius: 30,
            offset: Offset(0, 16),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: EdgeInsets.all(16),
        leading: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: iconColor),
        ),
        title: Text(
          title,
          style: TextStyle(
            color: AppTheme.colorSecondary,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Text(
          description,
          style: TextStyle(
            color: AppTheme.colorSecondary.withOpacity(0.6),
            fontSize: 14,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          color: AppTheme.colorSecondary,
          size: 16,
        ),
        onTap: () => _showReminderDialog(context),
      ),
    );
  }

  void _showReminderDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Set Reminder'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('We\'ll remind you to complete your account opening process.'),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final notification = NotificationModel(
                  title: 'Account Opening Reminder',
                  message: 'Don\'t forget to complete your account opening process',
                  time: DateTime.now().add(Duration(days: 1)),
                );
                
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Reminder set for tomorrow')),
                );
              },
              child: Text('Set Reminder'),
            ),
          ],
        ),
      ),
    );
  }
} 