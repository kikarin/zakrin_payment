import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_theme.dart';

class InviteFriendsPage extends StatelessWidget {
  final String referralCode = 'ZAKRIN123';

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
          'Invite Friends',
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
          children: [
            Image.asset(
              'images/invite-friends.png',  // Tambahkan gambar ilustrasi
              height: 200,
            ),
            SizedBox(height: 24),
            Text(
              'Share ZakrinPay with Friends',
              style: TextStyle(
                color: AppTheme.colorSecondary,
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            Text(
              'Get \$10 for every friend who joins using your referral code',
              style: TextStyle(
                color: AppTheme.colorSecondary.withOpacity(0.7),
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 32),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Color(0xFFF5F8FF),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    referralCode,
                    style: TextStyle(
                      color: AppTheme.colorSecondary,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 2,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.copy),
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: referralCode));
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Referral code copied!')),
                      );
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 32),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // Implementasi share ke WhatsApp
                    },
                    icon: Icon(Icons.message),
                    label: Text('WhatsApp'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF25D366),
                      padding: EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // Implementasi share ke media sosial lain
                    },
                    icon: Icon(Icons.share),
                    label: Text('Share'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF608EE9),
                      padding: EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
} 