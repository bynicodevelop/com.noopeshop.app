import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String uid;

  const UserModel({
    required this.uid,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'] as String,
    );
  }

  factory UserModel.empty() {
    return const UserModel(
      uid: '',
    );
  }

  bool get isEmpty => uid.isEmpty;

  @override
  List<Object?> get props => [
        uid,
      ];
}
