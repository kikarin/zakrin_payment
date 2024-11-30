import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../models/notification_model.dart';
import 'package:intl/intl.dart';

class NotificationPage extends StatelessWidget {
  final List<NotificationModel> notifications;

  const NotificationPage({
    Key? key,
    required this.notifications,
  }) : super(key: key);

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
          'Notifications',
          style: TextStyle(
            color: AppTheme.colorSecondary,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: notifications.isEmpty
          ? Center(
              child: Text(
                'No notifications',
                style: TextStyle(
                  color: AppTheme.colorSecondary,
                  fontSize: 16,
                ),
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notification = notifications[index];
                return Container(
                  margin: EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: notification.isRead ? Colors.white : Color(0xFFF5F8FF),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 8,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(16),
                    title: Text(
                      notification.title,
                      style: TextStyle(
                        color: AppTheme.colorSecondary,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 4),
                        Text(
                          notification.message,
                          style: TextStyle(
                            color: AppTheme.colorSecondary.withOpacity(0.7),
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          DateFormat('dd MMM yyyy, HH:mm').format(notification.time),
                          style: TextStyle(
                            color: AppTheme.colorSecondary.withOpacity(0.5),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
} 