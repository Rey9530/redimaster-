import 'dart:convert';

PrestamosDetailsModel prestamosDetailsModelFromJson(String str) => PrestamosDetailsModel.fromJson(json.decode(str));
 
class PrestamosDetailsModel {
    int code;
    String message;
    List<DetallePrestamo> data;

    PrestamosDetailsModel({
        required this.code,
        required this.message,
        required this.data,
    });

    factory PrestamosDetailsModel.fromJson(Map<String, dynamic> json) => PrestamosDetailsModel(
        code: json["code"],
        message: json["message"],
        data: List<DetallePrestamo>.from(json["data"].map((x) => DetallePrestamo.fromJson(x))),
    ); 
}

class DetallePrestamo {
    int idDetalle;
    String correlativo;
    double monto;
    double abono;
    int frecuencia;
    double total;
    String fechaVence;
    dynamic fechaPago;
    double pagado;
    double mora;
    List<dynamic> detalle;

    DetallePrestamo({
        required this.idDetalle,
        required this.correlativo,
        required this.monto,
        required this.abono,
        required this.frecuencia,
        required this.total,
        required this.fechaVence,
        required this.fechaPago,
        required this.pagado,
        required this.mora,
        required this.detalle,
    });

    factory DetallePrestamo.fromJson(Map<String, dynamic> json) => DetallePrestamo(
        idDetalle: json["id_detalle"],
        correlativo: json["correlativo"],
        monto: json["monto"]?.toDouble(),
        abono: json["abono"]?.toDouble(),
        frecuencia: json["frecuencia"],
        total: json["total"]?.toDouble(),
        fechaVence: json["fecha_vence"],
        fechaPago: json["fecha_pago"],
        pagado: json["pagado"]?.toDouble(),
        mora: json["mora"]?.toDouble(),
        detalle: List<dynamic>.from(json["detalle"].map((x) => x)),
    ); 
}
 