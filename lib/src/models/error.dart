import 'dart:convert';

LRError lrErrorFromJson(String str) => LRError.fromJson(json.decode(str));

String lrErrorToJson(LRError data) => json.encode(data.toJson());

class LRError {
  LRError({
    this.description,
    this.errorCode,
    this.message,
    this.isProviderError,
    this.providerErrorResponse,
  });

  String? description;
  int? errorCode;
  String? message;
  bool? isProviderError;
  String? providerErrorResponse;

  factory LRError.fromJson(Map<String, dynamic> json) => LRError(
        description: json["Description"],
        errorCode: json["ErrorCode"],
        message: json["Message"],
        isProviderError: json["IsProviderError"],
        providerErrorResponse: json["ProviderErrorResponse"],
      );

  Map<String, dynamic> toJson() => {
        "Description": description,
        "ErrorCode": errorCode,
        "Message": message,
        "IsProviderError": isProviderError,
        "ProviderErrorResponse": providerErrorResponse,
      };
}
