class GlobalResponse {
  GlobalResponse({
    this.status,
    this.code,
    this.message,
  });

  String? status;
  int? code;
  List<String>? message;

  factory GlobalResponse.fromJson(Map<String, dynamic> json) => GlobalResponse(
        status: json["status"] == null ? null : json["status"],
        code: json["code"] == null ? null : json["code"],
        message: json["message"] == null
            ? null
            : List<String>.from(json["message"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "code": code == null ? null : code,
        "message":
            message == null ? null : List<dynamic>.from(message!.map((x) => x)),
      };
}

