import 'dart:convert';

PaymentModel payModelFromJson(String str) => PaymentModel.fromJson(json.decode(str));
  

class PaymentModel {
  int paymentId;
  int paidOut;
  String correlative;
  double mount;
  bool partialMount;
  double arrears;
  double arrearsTotal;
  bool partialArrears;
  String appVersion;

    PaymentModel({
     this.paymentId=0,
     required this.paidOut,
     required this.correlative,
     required this.mount,
     required this.partialMount,
     required this.arrears,
     required this.arrearsTotal,
     required this.partialArrears,
     required this.appVersion,
    });

    factory PaymentModel.fromJson(Map<String, dynamic> json) => PaymentModel( 
      paymentId:json['paymentId'],
      paidOut:json['paidOut'],
      correlative:json['correlative'],
      mount:json['mount'],
      partialMount:json['partialMount'],
      arrears:json['arrears'],
      arrearsTotal:json['arrearsTotal'],
      partialArrears:json['partialArrears'],
      appVersion:json['appVersion'],
    );
 

    Map<String, dynamic> toJson() => { 
      "paymentId":paymentId,
      "paidOut":paidOut,
      "correlative":correlative,
      "mount":mount,
      "partialMount":partialMount,
      "arrears":arrears,
      "arrearsTotal":arrearsTotal,
      "partialArrears":partialArrears,
      "appVersion":appVersion,
    };
}
