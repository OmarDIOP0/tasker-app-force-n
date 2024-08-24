import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tasker/constantes/colors.dart';
import 'package:tasker/services/NotificationModel.dart';
import '../../services/task_api.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  List<NotificationModel> _notifications = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadNotifications();
  }

  Future<void> _loadNotifications() async {
    try {
      List<NotificationModel> notifications = await fetchNotifications();
      setState(() {
        _notifications = notifications;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }


  String formatDueDate(String dateStr) {
    DateTime date = DateTime.parse(dateStr);
    return DateFormat('dd/MM/yy').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
        backgroundColor: verylightgreenColor,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : _notifications.isEmpty
          ? const Center(child: Text("Aucune notification disponible."))
          : ListView.builder(
        itemCount: _notifications.length,
        itemBuilder: (context, index) {
          final notification = _notifications[index];
          return Column(
            children: [
              ListTile(
                title: Text(notification.title),
                subtitle: Text(notification.body),
                trailing: Text(formatDueDate(notification.date.toString())),
              ),
              if (index < _notifications.length - 1)
                const Divider(
                  color: lightgreenColor,
                  thickness: 1.0,
                ),
            ],
          );
        },
      ),
    );
  }
}
