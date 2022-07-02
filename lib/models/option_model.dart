import 'package:equatable/equatable.dart';

class OptionModel extends Equatable {
  final String key;
  final dynamic value;

  const OptionModel({
    required this.key,
    required this.value,
  });

  factory OptionModel.fromJson(Map<String, dynamic> json) {
    return OptionModel(
      key: json['key'] as String,
      value: json['value'] as dynamic,
    );
  }

  bool get isEmpty => key.isEmpty;

  factory OptionModel.empty() {
    return const OptionModel(
      key: '',
      value: false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'key': key,
      'value': value,
    };
  }

  @override
  List<Object> get props => [
        key,
        value,
      ];
}
