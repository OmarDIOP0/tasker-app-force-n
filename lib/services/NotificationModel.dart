class NotificationModel{
  int? id;
  late String title;
  late String body;
  late DateTime scheduledTime;
  late int userId;

  NotificationModel({
    this.id,required this.title,required this.body,required this.scheduledTime,required this.userId
});

  Map<String,dynamic> toMap(){
    return {
      'id':id,
      'title':title,
      'body':body,
      'scheduledTime':scheduledTime.toIso8601String(),
    };
  }
  factory NotificationModel.fromMap(Map<String,dynamic> map){
    return NotificationModel(
        id:map['id'],
        title:map['title'],
        body: map['body'],
        scheduledTime: DateTime.parse(map['scheduledTime']),
        userId: map['userId']
    );
  }
}
