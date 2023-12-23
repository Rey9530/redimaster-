import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:credimaster/src/helper/math_helpers.dart';
import 'package:credimaster/src/models/models.dart';
import 'package:credimaster/src/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:package_info_plus/package_info_plus.dart';

class CustomerProvide extends ChangeNotifier {
// Create storage
  final storage = const FlutterSecureStorage();
  final conexion = ConexionesProvider();

  // final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController montoAbonar = TextEditingController();
  final TextEditingController pagarCon = TextEditingController(text: "0");
  final TextEditingController cambio = TextEditingController(text: "0");
  // final TextEditingController passwordController = TextEditingController();
  bool loading = false;
  loadingF(val) {
    loading = val;
    notifyListeners();
  }

  CustomerProvide() {
    getNextPayments();
  }
  searchCustomers(query) async {
    var resp = await conexion.get_("customers/1/25/$query");
    List<Customer> body = [];
    if (resp.statusCode == 200) {
      body = customerModelFromJson(resp.body).data.clientes;
    }
    // loadingF(false);
    return body;
  }

  int currentPageC = 1;
  int registersC = 10;
  List<Customer> customers = [];
  getCustomers([page, load]) async {
    if (loading) return;
    if (page != null && page > 0) {
      currentPageC = page;
      customers = [];
    }
    if (load!=null && load) loadingF(true);
    var resp = await conexion.get_("customers/$currentPageC/$registersC"); 
    if (resp.statusCode == 200) {
      currentPageC ++;
      customers = [
        ...customers,
        ...customerModelFromJson(resp.body).data.clientes
      ];
    }
    if (load!=null && load) loadingF(false);
    return customers;
  }

  searchpayments(query) async {
    var resp = await conexion.get_("payments/all/1/25/$query");
    List<Pago> body = [];
    if (resp.statusCode == 200) {
      body = paymentsModelFromJson(resp.body).data.pagos;
    }
    return body;
  }

  PaymentsModel? payments;
  List<Pago> listPayments = [];
  Pago? payment;
  Customer? customer;
  int customerId = 0;

  int currentPerPage = 10;
  int currentPage = 1;
  getNextPaymentsFirst([type = 'today', page]) async {
    listPayments = [];
    await getNextPayments(type, 1, false);
  }

  getNextPayments([type = 'today', page, load = true]) async {
    if (loading) return;
    if (page != null && page > 0) {
      currentPage = page;
    }

    if (load) loadingF(true);
    var resp =
        await conexion.get_("payments/$type/$currentPage/$currentPerPage");
    if (resp.statusCode == 200) {
      payments = paymentsModelFromJson(resp.body);
      listPayments = [
        ...listPayments,
        ...paymentsModelFromJson(resp.body).data.pagos
      ];
      currentPage++;
    }
    if (load) loadingF(false);
  }

  Future<List<Pago>>? getLoans() async {
    var resp = await conexion.get_("customers/loans/$customerId");
    if (resp.statusCode == 200) {
      return paymentsLoanModelFromJson(resp.body).data;
    }
    return [];
  }

  List<DetallePrestamo>? listado;
  Future<List<DetallePrestamo>>? getLoanDetail() async {
    var resp = await conexion.get_("loan/detail/${payment?.idPrestamo}");
    if (resp.statusCode == 200) {
      listado = prestamosDetailsModelFromJson(resp.body).data;
      return listado!;
    }
    return [];
  }

  processPayment() async {
    Object data = {
      "loanId": payment!.idPrestamo,
      "payments": [
        ...paymentsPending.map(
          (e) => {
            "appVersion": e.appVersion,
            "arrears": e.arrears,
            "arrearsTotal": e.arrearsTotal,
            "correlative": e.correlative,
            "hashCode": e.hashCode,
            "mount": e.mount,
            "paidOut": e.paidOut,
            "partialArrears": e.partialArrears,
            "partialMount": e.partialMount,
            "paymentId": e.paymentId
          },
        )
      ],
    };
    var resp = await conexion.post_(
      "loan/process_payment",
      jsonEncode(data),
      {},
      {
        "Content-Type": "application/json",
      },
    );
    if (resp.statusCode == 200) {}
    return [];
  }

  calculateValorCambio() {
    try {
      cambio.text =
          (double.parse(pagarCon.text) - double.parse(montoAbonar.text))
              .toString();
    } catch (e) {
      cambio.text = "0";
    }
    notifyListeners();
  }

  List<PaymentModel> paymentsPending = [];
  Future<List<PaymentModel>> cargarCuotasPendientes() async {
    paymentsPending = [];

    var mount = MathHelpers().roundDouble(double.parse(montoAbonar.text), 2);
    pagarCon.text = montoAbonar.text;
    cambio.text = "0";
    // Monto total a pagar
    double total = 0.00;
    // double payWith =
    //     MathHelpers().roundDouble(double.parse(montoAbonar.text), 2);

    BuiltList<DetallePrestamo> pendingDues = listado == null
        ? BuiltList()
        : listado!.where((d) => d.pagado == 0).toBuiltList();

    for (var d in pendingDues) {
      PaymentModel temp;
      double balanceTotal =
          MathHelpers().roundDouble((d.monto + d.mora) - d.abono, 2);
      double balanceMount = MathHelpers().roundDouble(d.monto - d.abono, 2);
      if (mount - balanceTotal >= 0) {
        // * Calculamos el pago de una cuota completa inclyendo mora

        if (d.abono < d.monto) {
          temp = PaymentModel(
            paymentId: d.idDetalle,
            paidOut: 1,
            correlative: d.correlativo,
            mount: MathHelpers().roundDouble(d.monto - d.abono, 2),
            partialMount: false,
            arrears: d.mora,
            arrearsTotal: d.mora,
            partialArrears: false,
            appVersion: "0.9.9",
          );
        } else {
          temp = PaymentModel(
            paymentId: d.idDetalle,
            paidOut: 1,
            correlative: d.correlativo,
            arrears: MathHelpers().roundDouble(balanceTotal, 2),
            arrearsTotal: d.mora,
            partialMount: false,
            mount: 0.00,
            partialArrears: false,
            appVersion: "0.9.9",
          );
        }

        // Agregamos el pago a la lista
        paymentsPending.add(temp);

        // Descontamos al abono el monto del pago realizado
        mount = MathHelpers().roundDouble(mount - balanceTotal, 2);
        // Sumamos el abono al total
        total = MathHelpers().roundDouble(total + balanceTotal, 2);
      } else if (mount > 0) {
        // * Calculamos el pago de un abono parcial

        if (balanceMount <= 0) {
          // * Calculamos abono parcial a mora con monto pagado

          temp = PaymentModel(
            paymentId: d.idDetalle,
            paidOut: 0,
            correlative: d.correlativo,
            arrears: MathHelpers().roundDouble(mount, 2),
            arrearsTotal: d.mora,
            partialMount: false,
            mount: 0.00,
            partialArrears: true,
            appVersion: "0.9.9",
          );

          total = MathHelpers().roundDouble(mount, 2);
        } else if (mount > balanceMount) {
          // * Calculamos abono parcial a mora
          double arrears = mount - balanceMount;

          temp = PaymentModel(
            paymentId: d.idDetalle,
            paidOut: 0,
            correlative: d.correlativo,
            arrears: MathHelpers().roundDouble(arrears, 2),
            arrearsTotal: d.mora,
            partialMount: false,
            mount: balanceMount,
            partialArrears: true,
            appVersion: "0.9.9",
          );

          total = MathHelpers().roundDouble(total + balanceMount + arrears, 2);
        } else {
          // * Calculamos abono parcial a monto

          temp = PaymentModel(
            paymentId: d.idDetalle,
            paidOut: 0,
            correlative: d.correlativo,
            arrears: 0.00,
            arrearsTotal: d.mora,
            partialMount: true,
            mount: MathHelpers().roundDouble(mount, 2),
            partialArrears: false,
            appVersion: "0.9.9",
          );

          total = MathHelpers().roundDouble(total + mount, 2);
        }

        // Si el abono parcial es de la mora

        paymentsPending.add(temp);

        mount = 0.0;
      }
    }
    return paymentsPending;
  }
}
