import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../pages/profile_page.dart';
import '../pages/login_page.dart';
import '../utils/responsive_helper.dart';
import '../pages/my_statistics_page.dart';
import '../pages/invite_friends_page.dart';

class AppDrawer extends StatelessWidget {
  final String userName;
  final String userEmail;

  const AppDrawer({
    super.key,
    required this.userName,
    required this.userEmail,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: ResponsiveHelper.isMobile(context) 
          ? MediaQuery.of(context).size.width * 0.85
          : 400,
      child: SafeArea(
        child: Column(
          children: [
            // Header with gradient background (fixed at top)
            Container(
              width: double.infinity,
              height: 150,
              decoration: BoxDecoration(
                color: Color(0xFF608EE9),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.white,
                          child: Text(
                            userName[0].toUpperCase(),
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 24, 24, 26),
                            ),
                          ),
                        ),
                        Container(
                          width: 28,
                          height: 28,
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                width: 0.50,
                                color: Colors.white.withOpacity(0.16),
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            icon: Icon(Icons.close, color: Colors.white, size: 14),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Text(
                      userName,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontFamily: 'HK Grotesk',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      userEmail,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontFamily: 'HK Grotesk',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Menu Items dalam Expanded dan SingleChildScrollView
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildMenuItem(
                      icon: Icons.bar_chart,
                      title: 'My Statistics',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MyStatisticsPage()),
                        );
                      },
                    ),
                    _buildMenuItem(
                      icon: Icons.person_add_outlined,
                      title: 'Invite Friends',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => InviteFriendsPage()),
                        );
                      },
                    ),
                    _buildMenuItem(
                      icon: Icons.settings_outlined,
                      title: 'Settings',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProfilePage(
                              userName: userName,
                              userEmail: userEmail,
                              onUpdateProfile: (newName, newEmail) {
                                // Handle profile update
                              },
                            ),
                          ),
                        );
                      },
                    ),
                    Divider(),
                    _buildMenuItem(
                      icon: Icons.notifications_outlined,
                      title: 'Reminder',
                      onTap: () {},
                    ),
                    _buildMenuItem(
                      icon: Icons.logout,
                      title: 'Logout',
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('Logout'),
                            content: Text('Are you sure you want to logout?'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(builder: (context) => LoginPage()),
                                    (route) => false,
                                  );
                                },
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.red,
                                ),
                                child: Text('Logout'),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 24),
      leading: Icon(
        icon,
        color: AppTheme.colorSecondary,
        size: 24,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: AppTheme.colorSecondary,
          fontSize: 15,
          fontFamily: 'HK Grotesk',
          fontWeight: FontWeight.w400,
        ),
      ),
      onTap: onTap,
    );
  }
} 