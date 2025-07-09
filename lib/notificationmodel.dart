class AppNotification {
  final String title;
  final String body;
  final DateTime receivedAt;
  final String uid;
  final String?itemId;


  AppNotification({
    required this.title,
    required this.body,
    required this.receivedAt,
    required this.uid,
    this.itemId,


  });
  factory AppNotification.fromMap(Map<String, dynamic> data) {
    return AppNotification(
      title: data['title'] ?? '',
      body: data['body'] ?? '',
      uid: data['requesterId'] ?? '',
      receivedAt: data['receivedAt'] != null
          ? DateTime.parse(data['receivedAt'])
          : DateTime.now(),
      itemId:data['itemId']??"",


    );
  }

}
