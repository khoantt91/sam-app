import 'package:json_annotation/json_annotation.dart';

part 'network_reponse.g.dart';

@JsonSerializable()
class NetworkResponse {
  bool result;
  String code;
  String message;

  @JsonKey(ignore: true)
  Map<String, dynamic> data;

  @JsonKey(ignore: true)
  List<Map<String, dynamic>> dataArr;

  NetworkResponse(this.result, this.code, this.message);

  factory NetworkResponse.fromJson(Map<String, dynamic> json) => _$NetworkResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NetworkResponseToJson(this);
}
