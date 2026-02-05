import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pickup_load_update/src/configs/appColors.dart';
import 'package:pickup_load_update/src/configs/date_format.dart';
import 'package:pickup_load_update/src/configs/loader.dart';
import 'package:pickup_load_update/src/controllers/notification%20controller/notification_controller.dart';
import 'package:pickup_load_update/src/widgets/appbar/customAppbar.dart';
import 'package:pickup_load_update/src/widgets/notification_card.dart' hide formatDateTime;

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  final NotificationController _controller = Get.put(NotificationController());

  @override
  void initState() {
    super.initState();
    _controller.getNotification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notifications',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        backgroundColor: primaryColor, // Primary color
        elevation: 0,
        actions: [
          if (_controller.notificationData.isNotEmpty)
            IconButton(
              icon: Icon(Icons.delete_sweep, color: Colors.white),
              onPressed: () => _showDeleteConfirmation(context),
              tooltip: 'Clear all',
            ),
        ],
      ),
      body: Obx(() {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
               primaryColor.withOpacity(0.05),
                Colors.grey[50]!,
              ],
            ),
          ),
          child: RefreshIndicator(
            color: primaryColor,
            onRefresh: _refreshNotifications,
            child: _buildNotificationList(),
          ),
        );
      }),
    );
  }

  Widget _buildNotificationList() {
    if (_controller.isLoading.value) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: primaryColor),
            SizedBox(height: 16),
            Text(
              'Loading notifications...',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 16,
              ),
            ),
          ],
        ),
      );
    } else {
      if (_controller.notificationData.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.notifications_off_outlined,
                size: 80,
                color: Colors.grey[300],
              ),
              SizedBox(height: 20),
              Text(
                'No notifications yet',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 8),
              Text(
                'We\'ll notify you when something arrives',
                style: TextStyle(
                  color: Colors.grey[500],
                ),
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: _refreshNotifications,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF4A6EF6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                ),
                child: Text('Refresh'),
              ),
            ],
          ),
        );
      } else {
        return CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildBuilderDelegate(
                    (context, index) {
                  final notification = _controller.notificationData[index];
                  final bool isUnread = notification.status == 0;

                  return NotificationCard(
                    title: notification.title.toString(),
                    subTitle: notification.body.toString(),
                    date: formatDateTime(notification.createdAt.toString()),
                    isUnread: isUnread,
                    onTap: () {
                      // Mark as read if unread
                      if (isUnread) {
                        // Add mark as read logic here
                      }
                    },
                  );
                },
                childCount: _controller.notificationData.length,
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: 20),
            ),
          ],
        );
      }
    }
  }

  Future<void> _refreshNotifications() async {
    await _controller.getNotification();
  }

  void _showDeleteConfirmation(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.delete_outline,
                size: 64,
                color: Colors.red,
              ),
              SizedBox(height: 16),
              Text(
                'Clear all notifications?',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 12),
              Text(
                'This action cannot be undone',
                style: TextStyle(
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        side: BorderSide(color: Colors.grey[300]!),
                      ),
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          color: Colors.grey[700],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        Navigator.pop(context);
                        await _controller.deleteNotification();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Clear All',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }
}

