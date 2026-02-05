import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../configs/appColors.dart';

class NotificationCard extends StatelessWidget {
  final String title;
  final String subTitle;
  final String date;
  final bool isUnread;
  final VoidCallback onTap;

  const NotificationCard({
    super.key,
    required this.title,
    required this.subTitle,
    required this.date,
    this.isUnread = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Material(
        color: isUnread ? Color(0xFFE8F0FE) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        elevation: 1,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isUnread ? primaryColor.withOpacity(0.1) : Colors.grey[200]!,
                width: 1,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: _getNotificationColor(title),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    _getNotificationIcon(title),
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              title,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: Colors.grey[800],
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (isUnread)
                            Container(
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                color: primaryColor,
                                shape: BoxShape.circle,
                              ),
                            ),
                        ],
                      ),
                      SizedBox(height: 6),
                      Text(
                        subTitle,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                          height: 1.4,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            size: 14,
                            color: Colors.grey[400],
                          ),
                          SizedBox(width: 4),
                          Text(
                            date,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[500],
                            ),
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              _getTimeAgo(date),
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.grey[600],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _getNotificationColor(String title) {
    final titleLower = title.toLowerCase();
    if (titleLower.contains('alert') || titleLower.contains('urgent')) {
      return Color(0xFFFF6B6B); // Red
    } else if (titleLower.contains('success') || titleLower.contains('complete')) {
      return Color(0xFF4CAF50); // Green
    } else if (titleLower.contains('warning') || titleLower.contains('important')) {
      return Color(0xFFFFA726); // Orange
    } else if (titleLower.contains('update') || titleLower.contains('info')) {
      return Color(0xFF2196F3); // Blue
    }
    return primaryColor; // Default primary color
  }

  IconData _getNotificationIcon(String title) {
    final titleLower = title.toLowerCase();
    if (titleLower.contains('alert') || titleLower.contains('urgent')) {
      return Icons.warning_rounded;
    } else if (titleLower.contains('success') || titleLower.contains('complete')) {
      return Icons.check_circle_rounded;
    } else if (titleLower.contains('warning')) {
      return Icons.error_outline_rounded;
    } else if (titleLower.contains('update')) {
      return Icons.update_rounded;
    } else if (titleLower.contains('message')) {
      return Icons.message_rounded;
    } else if (titleLower.contains('order')) {
      return Icons.shopping_bag_rounded;
    }
    return Icons.notifications_rounded;
  }

  String _getTimeAgo(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      final now = DateTime.now();
      final difference = now.difference(date);

      if (difference.inMinutes < 1) return 'Just now';
      if (difference.inMinutes < 60) return '${difference.inMinutes}m ago';
      if (difference.inHours < 24) return '${difference.inHours}h ago';
      if (difference.inDays < 7) return '${difference.inDays}d ago';
      if (difference.inDays < 30) return '${(difference.inDays / 7).floor()}w ago';
      if (difference.inDays < 365) return '${(difference.inDays / 30).floor()}mo ago';
      return '${(difference.inDays / 365).floor()}y ago';
    } catch (e) {
      return '';
    }
  }
}

// Helper function for date formatting
String formatDateTime(String dateString) {
  try {
    final date = DateTime.parse(dateString);
    return DateFormat('MMM dd, yyyy • hh:mm a').format(date);
  } catch (e) {
    return dateString;
  }
}
