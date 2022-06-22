import 'package:equatable/equatable.dart';

class NotificationModel extends Equatable {
  final String title;
  final String body;
  final Map<String, dynamic> data;

  const NotificationModel({
    required this.title,
    required this.body,
    required this.data,
  });

  factory NotificationModel.empty() {
    return const NotificationModel(
      title: "",
      body: "",
      data: {},
    );
  }

  bool get isEmpty => title.isEmpty && body.isEmpty;

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        title: json['title'] as String,
        body: json['body'] as String,
        data: json['data'] as Map<String, dynamic>,
      );

  @override
  List<Object> get props => [
        title,
        body,
        data,
      ];
}
