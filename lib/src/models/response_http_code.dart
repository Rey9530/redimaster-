class CodeResponseHttp {
  CodeResponseHttp({
    required this.statusCode,
    required this.body,
  });

  dynamic body;
  int statusCode;

  factory CodeResponseHttp.fromJson(Map<String, dynamic> json) =>
      CodeResponseHttp(
        statusCode: json["statusCode"],
        body: json["body"],
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "body": body,
      };
}
