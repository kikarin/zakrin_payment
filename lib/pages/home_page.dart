import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'card_details_page.dart';
import '/widgets/app_drawer.dart';
import '/widgets/bottom_nav_bar.dart';
import '/utils/responsive_helper.dart';
import 'transfer_page.dart';
import 'history_page.dart';
import '/models/transfer_history.dart';
import 'mobile_recharge_page.dart';
import 'bill_payments_page.dart';
import 'request_money_page.dart';
import 'open_account_page.dart';
import 'all_cards_page.dart';
import 'money_exchange_page.dart';
import 'package:provider/provider.dart';
import '../providers/card_provider.dart';
import '../models/notification_model.dart';
import 'notification_page.dart';


class HomePage extends StatefulWidget {
  final String userName;
  final String userEmail;

  const HomePage({
    Key? key,
    required this.userName,
    required this.userEmail,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<TransferHistory> transferHistory = [];
  List<NotificationModel> notifications = [
    NotificationModel(
      title: 'New Card Added',
      message: 'Your VISA card has been successfully added',
      time: DateTime.now().subtract(Duration(hours: 1)),
    ),
    NotificationModel(
      title: 'Transfer Success',
      message: 'Transfer to John Doe successful',
      time: DateTime.now().subtract(Duration(hours: 2)),
    ),
  ];

  void addCard(Map<String, dynamic> newCard) {
    final cardProvider = Provider.of<CardProvider>(context, listen: false);
    cardProvider.addCard(newCard);
  }

  void removeCard(int index) {
    final cardProvider = Provider.of<CardProvider>(context, listen: false);
    cardProvider.removeCard(index);
  }

  void addTransferHistory(TransferHistory history) {
    setState(() {
      transferHistory.insert(0, history);
    });
  }

  @override
  Widget build(BuildContext context) {
    final cardProvider = Provider.of<CardProvider>(context);
    final cards = cardProvider.cards;

    return Scaffold(
      key: _scaffoldKey,
      drawer: AppDrawer(
        userName: widget.userName,
        userEmail: widget.userEmail,
      ),
      body: Center(
        child: Container(
          constraints: BoxConstraints(
            maxWidth: ResponsiveHelper.getMaxWidth(context),
          ),
          child: Stack(
            children: [
              // Gradient background
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 121,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment(0.00, -1.00),
                      end: Alignment(0, 1),
                      colors: [
                        Color(0x00FBFCFF),  // Transparent white
                        Colors.white,        // Solid white
                        Color(0xF1FEFEFF),   // Semi-transparent white
                      ],
                    ),
                  ),
                ),
              ),
              // Main content
              SafeArea(
                child: Column(
                  children: [
                    _buildAppBar(),
                    Expanded(
                      child: ListView(
                        padding: const EdgeInsets.all(24.0),
                        children: [
                          _buildPaymentCards(context),
                          const SizedBox(height: 24),
                          _buildFrequentlyUsed(),
                          const SizedBox(height: 24),
                          _buildServices(),
                        ],
                      ),
                    ),
                    BottomNavBar(
                      currentIndex: 0,
                      cards: cards,
                      onAddCard: addCard,
                      onRemoveCard: removeCard,
                      userName: widget.userName,
                      userEmail: widget.userEmail,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              _scaffoldKey.currentState?.openDrawer();
            },
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(
                Icons.menu_rounded,
                color: AppTheme.colorSecondary,
                size: 24,
              ),
            ),
          ),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Stack(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.notifications_none_rounded,
                    color: AppTheme.colorSecondary,
                    size: 24,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NotificationPage(
                          notifications: notifications,
                        ),
                      ),
                    );
                  },
                ),
                if (notifications.any((n) => !n.isRead))
                  Positioned(
                    right: 10,
                    top: 10,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentCards(BuildContext context) {
    final cardProvider = Provider.of<CardProvider>(context);
    final cards = cardProvider.cards;

    return Container(
      height: ResponsiveHelper.getCardHeight(context),
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
          : LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                      cards.length,
                      (index) => GestureDetector(
                        onTap: () async {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CardDetailsPage(
                                bankName: cards[index]['bankName'],
                                cardNumber: cards[index]['cardNumber'],
                                cardType: cards[index]['cardType'],
                                expiry: cards[index]['expiry'],
                                gradient: cards[index]['gradient'],
                                logo: cards[index]['logo'],
                                onRemove: () => removeCard(index),
                              ),
                            ),
                          );

                          if (result == 'removed') {
                            removeCard(index);
                          }
                        },
                        child: Container(
                          width: ResponsiveHelper.getCardWidth(context),
                          margin: EdgeInsets.only(
                            right: ResponsiveHelper.getPadding(context),
                          ),
                          child: _buildCardTemplate(
                            bankName: cards[index]['bankName'],
                            cardNumber: cards[index]['cardNumber'],
                            cardType: cards[index]['cardType'],
                            expiry: cards[index]['expiry'],
                            gradient: cards[index]['gradient'],
                            logo: cards[index]['logo'],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }

  Widget _buildCardTemplate({
    required String bankName,
    required String cardNumber,
    required String cardType,
    required String expiry,
    required List<Color> gradient,
    required String logo,
  }) {
    return Container(
      width: 327,
      height: 200,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: gradient,
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
                    logo,
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(width: 12),
                Text(
                  bankName,
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
              cardNumber,
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
                  cardType,
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
                  expiry,
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

  Widget _buildFrequentlyUsed() {
    final cardProvider = Provider.of<CardProvider>(context);
    final cards = cardProvider.cards;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Frequently Used',
              style: TextStyle(
                color: AppTheme.colorSecondary,
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              GestureDetector(
                onTap: () async {
                  if (cards.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Please add a card first')),
                    );
                    return;
                  }
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MobileRechargePage(
                        userCards: cards,
                      ),
                    ),
                  );
                  if (result != null && result is TransferHistory) {
                    addTransferHistory(result);
                  }
                },
                child: _buildFrequentItem(
                  icon: Icons.phone_android,
                  label: 'Mobile\nRecharge',
                  color: Color(0x1437D69E),
                  iconColor: Color(0xFF37D69E),
                  onTap: () {},
                ),
              ),
              GestureDetector(
                onTap: () async {
                  if (cards.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Please add a card first')),
                    );
                    return;
                  }
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BillPaymentsPage(
                        userCards: cards,
                      ),
                    ),
                  );
                  if (result != null && result is TransferHistory) {
                    addTransferHistory(result);
                  }
                },
                child: _buildFrequentItem(
                  icon: Icons.receipt_long,
                  label: 'Bill\nPayments',
                  color: Color(0x14FF6E66),
                  iconColor: Color(0xFFFF6E66),
                  onTap: () {},
                ),
              ),
              GestureDetector(
                onTap: () async {
                  if (cards.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Please add a card first to make transfers')),
                    );
                    return;
                  }
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TransferPage(
                        userCards: cards,
                      ),
                    ),
                  );
                  if (result != null && result is TransferHistory) {
                    addTransferHistory(result);
                  }
                },
                child: _buildFrequentItem(
                  icon: Icons.account_balance,
                  label: 'Bank\nTransfer',
                  color: Color(0x14FFC633),
                  iconColor: Color(0xFFFFC633),
                  onTap: () {},
                ),
              ),
              GestureDetector(
                onTap: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RequestMoneyPage()),
                  );
                  if (result != null && result is TransferHistory) {
                    addTransferHistory(result);
                  }
                },
                child: SizedBox(
                  width: 74,
                  height: 111,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 67,
                        height: 67,
                        decoration: ShapeDecoration(
                          color: Color(0x143642DA),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.request_page,
                            size: 32,
                            color: Color(0xFF3642DA),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(top: 8),
                          child: Text(
                            'Request\nMoney',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xCC2F394E),
                              fontSize: 14,
                              fontFamily: 'HK Grotesk',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // History item
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HistoryPage(
                        history: transferHistory,
                      ),
                    ),
                  );
                },
                child: Container(
                  width: 74,
                  height: 111,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 67,
                        height: 67,
                        decoration: ShapeDecoration(
                          color: Color(0x14DA35C9),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.history,
                            size: 32,
                            color: Color(0xFFDA35C9),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(top: 8),
                          child: Text(
                            'Transfer\nHistory',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xCC2F394E),
                              fontSize: 14,
                              fontFamily: 'HK Grotesk',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFrequentItem({
    required IconData icon,
    required String label,
    required Color color,
    required Color iconColor,
    required Function() onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(right: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 67,
            height: 67,
            child: Stack(
              children: [
                Container(
                  width: 67,
                  height: 67,
                  decoration: ShapeDecoration(
                    color: color,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                Positioned(
                  left: 18,
                  top: 18,
                  child: Container(
                    width: 32,
                    height: 32,
                    child: Icon(
                      icon,
                      size: 32,
                      color: iconColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xCC2F394E),
              fontSize: 14,
              fontFamily: 'HK Grotesk',
              fontWeight: FontWeight.w500,
              height: 0,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServices() {
    final cardProvider = Provider.of<CardProvider>(context);
    final cards = cardProvider.cards;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Service',
          style: TextStyle(
            color: AppTheme.colorSecondary,
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        GridView.count(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 1.55,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OpenAccountPage()),
                );
              },
              child: _buildServiceItem(
                icon: Icons.account_balance,
                title: 'Open Account',
                color: Color(0xFFFDEEEA),
                iconColor: Color(0xFFFF6E66),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AllCardsPage(
                    cards: cards,
                    onRemoveCard: removeCard,
                    onAddCard: addCard,
                  )),
                );
              },
              child: _buildServiceItem(
                icon: Icons.credit_card,
                title: 'Manage Cards',
                color: Color(0xFFE4F3F4),
                iconColor: Color(0xFF37D69E),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MoneyExchangePage()),
                );
              },
              child: _buildServiceItem(
                icon: Icons.currency_exchange,
                title: 'Money Exchange',
                color: Color(0xFFFDEAFC),
                iconColor: Color(0xFFDA35C9),
              ),
            ),
            GestureDetector(
              onTap: () {
                // Show authorization dialog
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Authorization'),
                    content: Text('This feature requires additional authorization. Please contact support.'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text('OK'),
                      ),
                    ],
                  ),
                );
              },
              child: _buildServiceItem(
                icon: Icons.lock_outline,
                title: 'Authorization',
                color: Color(0xFFFDEAEB),
                iconColor: Color(0xFFFF364A),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildServiceItem({
    required IconData icon,
    required String title,
    required Color color,
    required Color iconColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: TextStyle(
              color: AppTheme.colorSecondary,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
