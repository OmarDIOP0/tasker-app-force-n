import 'package:flutter/material.dart';

class NoReadNotification extends StatefulWidget {
  const NoReadNotification({Key? key}) : super(key: key);

  @override
  State<NoReadNotification> createState() => _NoReadNotificationState();
}

class _NoReadNotificationState extends State<NoReadNotification> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Notification non lues"),
    );
  }
}
