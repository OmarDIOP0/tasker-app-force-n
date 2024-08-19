import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tasker/constantes/colors.dart';
import 'package:tasker/services/NotificationModel.dart';
import 'package:tasker/services/database_helper.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
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

  String formatDueDate(String dateStr) {
    DateTime date = DateTime.parse(dateStr);
    return DateFormat('dd/MM/yy').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notification"),
        backgroundColor: verylightgreenColor,
      ),
      body: _notifications.isEmpty
          ? const Center(child: Text("Aucune notification disponible."))
          : ListView.builder(
        itemCount: _notifications.length,
        itemBuilder: (context, index) {
          final notification = _notifications[index];
          return SingleChildScrollView(
            child: Column(
              children: [
                ListTile(
                  title: Text(notification.title),
                  subtitle: Text(notification.body),
                  trailing: Text(formatDueDate(notification.scheduledTime.toString())),
                ),
                if (index < _notifications.length - 1)
                  const Divider(
                    color: lightgreenColor,
                    thickness: 1.0,
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
