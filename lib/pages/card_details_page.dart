import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/stats_chart.dart';
import '../utils/responsive_helper.dart';
import '../widgets/card_template.dart';

class CardDetailsPage extends StatelessWidget {
  final String bankName;
  final String cardNumber;
  final String cardType;
  final String expiry;
  final List<Color> gradient;
  final String logo;
  final VoidCallback onRemove;

  const CardDetailsPage({
    super.key,
    required this.bankName,
    required this.cardNumber,
    required this.cardType,
    required this.expiry,
    required this.gradient,
    required this.logo,
    required this.onRemove,
  });

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
          'Card Details',
          style: TextStyle(
            color: AppTheme.colorSecondary,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Center(
        child: Container(
          constraints: BoxConstraints(
            maxWidth: ResponsiveHelper.getMaxWidth(context),
          ),
          child: SingleChildScrollView(
            padding: EdgeInsets.all(ResponsiveHelper.getPadding(context)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Card Display
                _buildCardDisplay(),
                const SizedBox(height: 24),
                // Current Balance
                _buildCurrentBalance(),
                const SizedBox(height: 24),
                // Stats
                _buildStats(),
                const SizedBox(height: 32),
                // Card Actions
                Text(
                  'Card Actions',
                  style: TextStyle(
                    color: AppTheme.colorSecondary,
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                _buildActionItem(
                  icon: Icons.lock_outline,
                  title: 'Lock Card',
                  subtitle: 'Lock your card temporarily',
                  onTap: () => _handleLockCard(context),
                ),
                _buildActionItem(
                  icon: Icons.delete_outline,
                  title: 'Remove Card',
                  subtitle: 'Delete this card',
                  onTap: () => _handleRemoveCard(context),
                  isDestructive: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCardDisplay() {
    return Container(
      width: 327,
      height: 200,
      child: buildCardTemplate(
        card: {
          'bankName': bankName,
          'cardNumber': cardNumber,
          'cardType': cardType,
          'expiry': expiry,
          'gradient': gradient,
          'logo': logo,
        },
      ),
    );
  }

  Widget _buildCurrentBalance() {
    return Container(
      width: 326,
      height: 110,
      decoration: ShapeDecoration(
        color: Color(0xFFE6F2FF),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Current Balance',
            style: TextStyle(
              color: Color(0xFF608EE9),
              fontSize: 16,
              fontFamily: 'HK Grotesk',
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '\$3,567.12',
            style: TextStyle(
              color: Color(0xFF608EE9),
              fontSize: 40,
              fontFamily: 'HK Grotesk',
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStats() {
    return StatsChart();
  }

  Widget _buildActionItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
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
            color: isDestructive ? Color(0xFFFDEAEB) : Color(0xFFE4F3F4),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: isDestructive ? Color(0xFFFF364A) : Color(0xFF37D69E),
            size: 24,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            color: isDestructive ? Color(0xFFFF364A) : AppTheme.colorSecondary,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Text(
          subtitle,
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
        onTap: onTap,
      ),
    );
  }

  // Action handlers
  void _handleLockCard(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Lock Card'),
        content: Text('Are you sure you want to lock this card?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // Implement card locking logic here
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Card locked successfully')),
              );
            },
            child: Text('Lock'),
          ),
        ],
      ),
    );
  }



  void _handleRemoveCard(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Remove Card'),
        content: Text('Are you sure you want to remove this card? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              onRemove(); // Call the callback
              Navigator.pop(context); // Close dialog
              Navigator.pop(context, 'removed'); // Return to previous screen with result
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Card removed successfully')),
              );
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.red,
            ),
            child: Text('Remove'),
          ),
        ],
      ),
    );
  }
} 