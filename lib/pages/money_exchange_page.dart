import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class MoneyExchangePage extends StatefulWidget {
  @override
  _MoneyExchangePageState createState() => _MoneyExchangePageState();
}

class _MoneyExchangePageState extends State<MoneyExchangePage> {
  final fromController = TextEditingController();
  final toController = TextEditingController();
  String fromCurrency = 'USD';
  String toCurrency = 'EUR';

  final List<String> currencies = [
    'IDR',
    'USD',
    'EUR',
    'GBP',
    'JPY',
    'AUD',
    'CAD',
  ];
  final Map<String, double> rates = {
    'IDR': 15700.0,
    'USD': 1.0,
    'EUR': 0.85,
    'GBP': 0.73,
    'JPY': 110.0,
    'AUD': 1.35,
    'CAD': 1.25,
  };

  final Map<String, String> currencySymbols = {
    'IDR': 'Rp',
    'USD': '\$',
    'EUR': '€',
    'GBP': '£',
  };

  final Map<String, String> currencyNames = {
    'IDR': 'Indonesian Rupiah',
    'USD': 'US Dollar',
    'EUR': 'Euro',
    'GBP': 'British Pound',
  };

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
          'Money Exchange',
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
            _buildCurrencyInput(
              'From',
              fromController,
              fromCurrency,
              (value) {
                setState(() {
                  fromCurrency = value!;
                  _calculateExchange();
                });
              },
            ),
            SizedBox(height: 16),
            Center(
              child: IconButton(
                icon: Icon(Icons.swap_vert, color: Color(0xFFDA35C9)),
                onPressed: _swapCurrencies,
              ),
            ),
            SizedBox(height: 16),
            _buildCurrencyInput(
              'To',
              toController,
              toCurrency,
              (value) {
                setState(() {
                  toCurrency = value!;
                  _calculateExchange();
                });
              },
            ),
            SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  // Handle exchange
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Exchange successful')),
                  );
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFDA35C9),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Exchange Now',
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

  Widget _buildCurrencyInput(
    String label,
    TextEditingController controller,
    String selectedCurrency,
    Function(String?) onCurrencyChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: DropdownButton<String>(
                  value: selectedCurrency,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                  isExpanded: true,
                  underline: SizedBox(),
                  items: currencies.map((currency) {
                    return DropdownMenuItem(
                      value: currency,
                      child: Text(currency),
                    );
                  }).toList(),
                  onChanged: onCurrencyChanged,
                ),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              flex: 3,
              child: TextField(
                controller: controller,
                keyboardType: TextInputType.number,
                onChanged: (value) => _calculateExchange(),
                decoration: InputDecoration(
                  hintText: '0.00',
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
            ),
          ],
        ),
      ],
    );
  }

  void _swapCurrencies() {
    setState(() {
      final tempCurrency = fromCurrency;
      fromCurrency = toCurrency;
      toCurrency = tempCurrency;

      final tempAmount = fromController.text;
      fromController.text = toController.text;
      toController.text = tempAmount;
    });
  }

  void _calculateExchange() {
    if (fromController.text.isEmpty) {
      toController.text = '';
      return;
    }

    try {
      final amount = double.parse(fromController.text);
      final fromRate = rates[fromCurrency]!;
      final toRate = rates[toCurrency]!;
      
      final usdAmount = fromCurrency == 'USD' 
          ? amount 
          : amount / fromRate;
      
      final result = toCurrency == 'USD' 
          ? usdAmount 
          : usdAmount * toRate;
      
      if (toCurrency == 'IDR') {
        final formattedResult = result.toStringAsFixed(0)
            .replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');
        toController.text = formattedResult;
      } else {
        toController.text = result.toStringAsFixed(2);
      }
    } catch (e) {
      toController.text = '';
    }
  }
} 