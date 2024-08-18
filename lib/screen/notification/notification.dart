import 'package:flutter/material.dart';
import 'package:tasker/constantes/colors.dart';
import 'package:tasker/screen/notification/all_notification.dart';
import 'package:tasker/screen/notification/no_read_notification.dart';
class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> with SingleTickerProviderStateMixin{
  late TabController _tabController;
  @override
  void initState(){
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose(){
    _tabController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notification"),
        backgroundColor: verylightgreenColor,
        bottom: TabBar(
          controller: _tabController,
            tabs: const [
              Tab(icon: Icon(Icons.all_inbox),text: "Toutes"),
              //Tab(icon: Icon(Icons.read_more),text: "Non Lues",)
            ]
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          AllNotification(),
          //NoReadNotification(),
        ],
      ),
    );
  }
}
