import 'package:json_annotation/json_annotation.dart';
import 'package:lunasea/modules/readarr.dart';

part 'resource_change_message.g.dart';

@JsonSerializable(
    explicitToJson: true, includeIfNull: false, genericArgumentFactories: true)
class ResourceChangeMessage<T> {
  @JsonKey(name: 'resource')
  T? resource;

  @JsonKey(
      name: 'action',
      fromJson: ReadarrUtilities.modelActionFromJson,
      toJson: ReadarrUtilities.modelActionToJson)
  ModelAction? action;

  ResourceChangeMessage({this.resource, this.action});

  factory ResourceChangeMessage.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$ResourceChangeMessageFromJson(json, fromJsonT);
  Map<String, dynamic> toJson(Object Function(T value) toJsonT) =>
      _$ResourceChangeMessageToJson(this, toJsonT);
}
