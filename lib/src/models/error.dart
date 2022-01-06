import 'dart:convert';

LRError lrErrorFromJson(String str) => LRError.fromJson(json.decode(str));

String lrErrorToJson(LRError data) => json.encode(data.toJson());

class Error {
  Error({
    this.fieldName,
    this.errorMessage,
  });

  String? fieldName;
  String? errorMessage;

  factory Error.fromJson(Map<String, dynamic> json) => Error(
        fieldName: json["FieldName"],
        errorMessage: json["ErrorMessage"],
      );

  Map<String, dynamic> toJson() => {
        "FieldName": fieldName,
        "ErrorMessage": errorMessage,
      };
}

class LRError {
  LRError({
    this.description,
    this.errorCode,
    this.message,
    this.isProviderError,
    this.providerErrorResponse,
    //this.errors,
  });

  String? description;
  int? errorCode;
  String? message;
  bool? isProviderError;
  String? providerErrorResponse;
  //List<Error>? errors;

  factory LRError.fromJson(Map<String, dynamic> json) => LRError(
        description: json["Description"],
        errorCode: json["ErrorCode"],
        message: json["Message"],
        isProviderError: json["IsProviderError"],
        providerErrorResponse: json["ProviderErrorResponse"],
        //errors: List<Error>.from(json["Errors"].map((x) => Error.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Description": description,
        "ErrorCode": errorCode,
        "Message": message,
        "IsProviderError": isProviderError,
        "ProviderErrorResponse": providerErrorResponse,
      //  "Errors": List<Error>.from(errors!.map((x) => x.toJson())),
      };
}
