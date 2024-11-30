import 'package:flutter/material.dart';

class CardProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _cards = [
    {
      'bankName': 'VISA',
      'cardNumber': '**** **** **** 4685',
      'cardType': 'Ilham Pauzan',
      'expiry': '01/25',
      'gradient': [Color(0xFF1D1D1D), Color(0xFF525252)],
      'logo': 'images/visa.jpg',
    },
    {
      'bankName': 'BCA',
      'cardNumber': '**** **** **** 5678',
      'cardType': 'Zankikarin',
      'expiry': '03/26',
      'gradient': [Color(0xFF2C3E7B), Color(0xFF4B6CB7)],
      'logo': 'images/bca.jpg',
    },
    {
      'bankName': 'Mandiri',
      'cardNumber': '**** **** **** 9012',
      'cardType': 'Zannn',
      'expiry': '12/24',
      'gradient': [Color.fromARGB(255, 180, 198, 255), Color.fromARGB(255, 16, 43, 80)],
      'logo': 'images/mandiri.png',
    },
  ];

  List<Map<String, dynamic>> get cards => _cards;

  void addCard(Map<String, dynamic> newCard) {
    _cards.add(newCard);
    notifyListeners();
  }

  void removeCard(int index) {
    _cards.removeAt(index);
    notifyListeners();
  }
} 