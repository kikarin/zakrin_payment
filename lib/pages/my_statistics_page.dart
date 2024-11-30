import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/stats_chart.dart';

class MyStatisticsPage extends StatelessWidget {
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
          'My Statistics',
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
            _buildBalanceCard(),
            SizedBox(height: 24),
            Text(
              'Spending Analysis',
              style: TextStyle(
                color: AppTheme.colorSecondary,
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 16),
            StatsChart(),
            SizedBox(height: 24),
            _buildSpendingCategories(),
          ],
        ),
      ),
    );
  }

  Widget _buildBalanceCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Color(0xFFE6F2FF),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Total Balance',
            style: TextStyle(
              color: Color(0xFF608EE9),
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8),
          Text(
            '\$3,567.12',
            style: TextStyle(
              color: Color(0xFF608EE9),
              fontSize: 32,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpendingCategories() {
    final categories = [
      {'name': 'Shopping', 'amount': 850.50, 'icon': Icons.shopping_bag, 'color': Color(0xFFFF6B6B)},
      {'name': 'Bills', 'amount': 420.75, 'icon': Icons.receipt, 'color': Color(0xFF4ECDC4)},
      {'name': 'Transfer', 'amount': 1250.00, 'icon': Icons.swap_horiz, 'color': Color(0xFF45B7D1)},
      {'name': 'Others', 'amount': 180.25, 'icon': Icons.more_horiz, 'color': Color(0xFFDA35C9)},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Spending Categories',
          style: TextStyle(
            color: AppTheme.colorSecondary,
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 16),
        ...categories.map((category) => _buildCategoryItem(category)).toList(),
      ],
    );
  }

  Widget _buildCategoryItem(Map<String, dynamic> category) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: category['color'].withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(category['icon'], color: category['color']),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Text(
              category['name'],
              style: TextStyle(
                color: AppTheme.colorSecondary,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Text(
            '\$${category['amount'].toStringAsFixed(2)}',
            style: TextStyle(
              color: AppTheme.colorSecondary,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
} 