import 'package:flutter/material.dart';
import 'package:tasker/services/database_helper.dart';
import 'package:tasker/services/NotificationModel.dart';

class AllNotification extends StatefulWidget {
  const AllNotification({Key? key}) : super(key: key);

  @override
  State<AllNotification> createState() => _AllNotificationState();
}

class _AllNotificationState extends State<AllNotification> {
  List<NotificationModel> _notifications = [];

  @override
  void initState() {
    super.initState();
    _loadNotifications();
  }

  Future<void> _loadNotifications() async {
    final dbHelper = DatabaseHelper();
    List<NotificationModel> notifications = await dbHelper.getNotifications();
    setState(() {
      _notifications = notifications;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _notifications.isEmpty
          ? const Center(child: Text("Aucune notification disponible."))
          : ListView.builder(
          itemCount: _notifications.length,
          itemBuilder: (context, index) {
            final notification = _notifications[index];
            return ListTile(
              title: Text(notification.title),
              subtitle: Text(notification.body),
              trailing: Text(notification.scheduledTime.toString()),
            );
          },
      ),
    );
  }
}
