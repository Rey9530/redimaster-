import 'dart:convert';

PaymentsModel paymentsModelFromJson(String str) =>
    PaymentsModel.fromJson(json.decode(str));
PaymentsLoanModel paymentsLoanModelFromJson(String str) =>
    PaymentsLoanModel.fromJson(json.decode(str));

class PaymentsModel {
  int code;
  String message;
  PaymentData data;

  PaymentsModel({
    required this.code,
    required this.message,
    required this.data,
  });

  factory PaymentsModel.fromJson(Map<String, dynamic> json) => PaymentsModel(
        code: json["code"],
        message: json["message"],
        data: PaymentData.fromJson(json["data"]),
      );
}

class PaymentsLoanModel {
  int code;
  String message;
  List<Pago> data;

  PaymentsLoanModel({
    required this.code,
    required this.message,
    required this.data,
  });

  factory PaymentsLoanModel.fromJson(Map<String, dynamic> json) =>
      PaymentsLoanModel(
        code: json["code"],
        message: json["message"],
        data: List<Pago>.from(json["data"].map((x) => Pago.fromJson(x))),
      );
}

class PaymentData {
  int paginas;
  int actual;
  List<Pago> pagos;

  PaymentData({
    required this.paginas,
    required this.actual,
    required this.pagos,
  });

  factory PaymentData.fromJson(Map<String, dynamic> json) => PaymentData(
        paginas: json["paginas"],
        actual: json["actual"],
        pagos: List<Pago>.from(json["pagos"].map((x) => Pago.fromJson(x))),
      );
}

class Pago {
  int idPrestamo;
  int idDetalle;
  String cliente;
  double monto;
  double abono;
  String cuotas;
  DateTime fechaVence;
  double total;
  int frecuencia;
  int estado;
  int refinanciado;
  String frecuenciaNombre;
  double porcentaje;
  double pagar;
  double abonado;
  double totalSaldo;
  double capital;
  double mora;
  double saldo;

  Pago({
    required this.idPrestamo,
    required this.idDetalle,
    required this.cliente,
    required this.monto,
    required this.estado,
    required this.refinanciado,
    required this.abono,
    required this.cuotas,
    required this.fechaVence,
    required this.total,
    required this.frecuencia,
    required this.frecuenciaNombre,
    required this.porcentaje,
    required this.pagar,
    required this.abonado,
    required this.totalSaldo,
    required this.capital,
    required this.mora,
    required this.saldo,
  });

  factory Pago.fromJson(Map<String, dynamic> json) => Pago(
        idPrestamo: json["id_prestamo"],
        idDetalle: json["id_detalle"],
        cliente: json["cliente"],
        monto: json["monto"]?.toDouble(),
        abono: json["abono"]?.toDouble(),
        cuotas: json["cuotas"],
        estado: json["estado"] ?? 0,
        refinanciado: json["refinanciado"] ?? 0,
        fechaVence: DateTime.parse(json["fecha_vence"]),
        total: json["total"]?.toDouble(),
        frecuencia: json["frecuencia"],
        frecuenciaNombre: json["frecuencia_nombre"],
        porcentaje: json["porcentaje"]?.toDouble(),
        pagar: json["pagar"]?.toDouble(),
        abonado: json["abonado"]?.toDouble(),
        totalSaldo: json["total_saldo"]?.toDouble(),
        capital: json["capital"]?.toDouble(),
        mora: double.parse(json["mora"].toString()),
        saldo: json["saldo"]?.toDouble(),
      );
  bool get possibleRefinancing {
    return abonado >= pagar / 2;
  }
}
