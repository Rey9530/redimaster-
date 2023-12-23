import 'dart:convert';

CustomerModel customerModelFromJson(String str) => CustomerModel.fromJson(json.decode(str));
 
class CustomerModel {
    int code;
    String message;
    CustomerData data;

    CustomerModel({
        required this.code,
        required this.message,
        required this.data,
    });

    factory CustomerModel.fromJson(Map<String, dynamic> json) => CustomerModel(
        code: json["code"],
        message: json["message"],
        data: CustomerData.fromJson(json["data"]),
    );
 
}

class CustomerData {
    int paginas;
    int actual;
    List<Customer> clientes;

    CustomerData({
        required this.paginas,
        required this.actual,
        required this.clientes,
    });

    factory CustomerData.fromJson(Map<String, dynamic> json) => CustomerData(
        paginas: json["paginas"],
        actual: json["actual"],
        clientes: List<Customer>.from(json["clientes"].map((x) => Customer.fromJson(x))),
    );
 
}

class Customer {
    int idCliente;
    String imagen;
    String nombre;
    String profesion;
    DateTime fechaNacimiento;
    String dui;
    String nit;
    String departamento;
    String municipio;
    String direccion;
    String telefono;
    String telefono2;
    String correo;
    String negocio;
    String actividadNegocio;
    String direccionNegocio;
    int revisado;
    int vetado;
    List<Documento> documentos;

    Customer({
        required this.idCliente,
        required this.imagen,
        required this.nombre,
        required this.profesion,
        required this.fechaNacimiento,
        required this.dui,
        required this.nit,
        required this.departamento,
        required this.municipio,
        required this.direccion,
        required this.telefono,
        required this.telefono2,
        required this.correo,
        required this.negocio,
        required this.actividadNegocio,
        required this.direccionNegocio,
        required this.revisado,
        required this.vetado,
        required this.documentos,
    });

    factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        idCliente: json["id_cliente"],
        imagen: json["imagen"],
        nombre: json["nombre"],
        profesion: json["profesion"],
        fechaNacimiento: DateTime.parse(json["fecha_nacimiento"]),
        dui: json["dui"],
        nit: json["nit"],
        departamento: json["departamento"],
        municipio: json["municipio"],
        direccion: json["direccion"],
        telefono: json["telefono"],
        telefono2: json["telefono2"],
        correo: json["correo"],
        negocio: json["negocio"],
        actividadNegocio: json["actividad_negocio"],
        direccionNegocio: json["direccion_negocio"],
        revisado: json["revisado"],
        vetado: json["vetado"],
        documentos: List<Documento>.from(json["documentos"].map((x) => Documento.fromJson(x))),
    );
 
}
 

class Documento {
    int idArchivo;
    DateTime fecha;
    String nombre;
    String descripcion;
    String foto;

    Documento({
        required this.idArchivo,
        required this.fecha,
        required this.nombre,
        required this.descripcion,
        required this.foto,
    });

    factory Documento.fromJson(Map<String, dynamic> json) => Documento(
        idArchivo: json["id_archivo"],
        fecha: DateTime.parse(json["fecha"]),
        nombre: json["nombre"],
        descripcion: json["descripcion"],
        foto: json["foto"],
    ); 
} 