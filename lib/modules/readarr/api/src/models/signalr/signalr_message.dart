import 'package:json_annotation/json_annotation.dart';

part 'signalr_message.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class SignalRMessage {
  @JsonKey(name: 'body')
  Map<String, dynamic>? body;

  @JsonKey(name: 'name')
  String? name;

  SignalRMessage({this.body, this.name});

  factory SignalRMessage.fromJson(Map<String, dynamic> json) =>
      _$SignalRMessageFromJson(json);
  Map<String, dynamic> toJson() => _$SignalRMessageToJson(this);
}
