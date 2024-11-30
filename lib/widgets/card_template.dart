import 'package:flutter/material.dart';

Widget buildCardTemplate({
  required Map<String, dynamic> card,
  bool isSelected = false,
}) {
  return Container(
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
        // Card Number
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