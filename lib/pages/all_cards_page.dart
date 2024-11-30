import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'card_details_page.dart';
import '../widgets/bottom_nav_bar.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';

class AllCardsPage extends StatelessWidget {
  final List<Map<String, dynamic>> cards;
  final Function(int) onRemoveCard;
  final Function(Map<String, dynamic>) onAddCard;

  const AllCardsPage({
    Key? key,
    required this.cards,
    required this.onRemoveCard,
    required this.onAddCard,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Mengambil data user dari provider
    final userProvider = context.watch<UserProvider>();
    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'My Cards',
          style: TextStyle(
            color: AppTheme.colorSecondary,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Column(
        children: [
          // Cards List
          Expanded(
            child: cards.isEmpty
                ? Center(
                    child: Text(
                      'No cards available',
                      style: TextStyle(
                        color: AppTheme.colorSecondary,
                        fontSize: 16,
                      ),
                    ),
                  )
                : ListView.builder(
                    padding: EdgeInsets.all(24),
                    itemCount: cards.length,
                    itemBuilder: (context, index) {
                      return _buildCardItem(context, cards[index], index);
                    },
                  ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: 2,
        cards: cards,
        onAddCard: onAddCard,
        onRemoveCard: onRemoveCard,
        userName: userProvider.userName,
        userEmail: userProvider.userEmail,
      ),
    );
  }

  Widget _buildCardItem(BuildContext context, Map<String, dynamic> card, int index) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      child: GestureDetector(
        onTap: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CardDetailsPage(
                bankName: card['bankName'],
                cardNumber: card['cardNumber'],
                cardType: card['cardType'],
                expiry: card['expiry'],
                gradient: card['gradient'],
                logo: card['logo'],
                onRemove: () => onRemoveCard(index),
              ),
            ),
          );

          if (result == 'removed') {
            onRemoveCard(index);
          }
        },
        child: Container(
          width: double.infinity,
          height: 100,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(0.91, 0.41),
              end: Alignment(-0.91, -0.41),
              colors: card['gradient'],
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              // Card Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      card['bankName'],
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      card['cardNumber'],
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      card['expiry'],
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              // Bank Logo
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
            ],
          ),
        ),
      ),
    );
  }
} 