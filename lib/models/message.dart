class Message {
  final DateTime dateTime;

  Message(this.dateTime);

  factory Message.fromJson(Map<String, dynamic> data) =>
      Message(DateTime.parse(data["dateTime"]));
}
