import 'package:credimaster/src/helper/helper.dart';
import 'package:credimaster/src/models/models.dart';
import 'package:credimaster/src/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class LoanWidget extends StatelessWidget {
  final Pago loan;
  const LoanWidget({super.key, required this.loan});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CustomerProvide>(context, listen: false);
    return GestureDetector(
      onTap: (loan.estado == 1)
          ? () {
              provider.payment = loan;
              //charge/loan/${loan.idPrestamo}
              Navigator.pushNamed(context, '/charge');
            }
          : () => Fluttertoast.showToast(msg: "PRESTAMO FINALIZADO"),
      child: Card(
        child: Container(
          padding: const EdgeInsets.all(15),
          width: double.infinity,
          child: Column(
            children: [
              Row(
                children: [
                  _status(),
                  Expanded(child: Container()),
                  Text("${loan.idPrestamo} "),
                  const Icon(
                    FontAwesomeIcons.fileInvoiceDollar,
                    size: 13,
                  )
                ],
              ),
              const Divider(),
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.45,
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 70,
                          child: Text(
                            "MONTO: ",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text(
                          "\$${Helpers.of(context).numberFormat(loan.total)}",
                          style: const TextStyle(fontSize: 13),
                        )
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 73,
                        child: Text(
                          "FRECUEN.: ",
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(
                        "${loan.frecuencia}",
                        style: const TextStyle(fontSize: 13),
                      )
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.45,
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 70,
                          child: Text(
                            "CUOTAS: ",
                            style: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text(
                          loan.cuotas,
                          style: const TextStyle(fontSize: 13),
                        )
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 73,
                        child: Text(
                          "INTERES: ",
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(
                        "${loan.porcentaje}%",
                        style: const TextStyle(fontSize: 13),
                      )
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.45,
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 70,
                          child: Text(
                            "V. FINAL: ",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text(
                          "\$${Helpers.of(context).numberFormat(loan.pagar)}",
                          style: const TextStyle(fontSize: 13),
                        )
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 73,
                        child: Text(
                          "CUOTA.: ",
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(
                        "\$${Helpers.of(context).numberFormat(loan.monto)}",
                        style: const TextStyle(fontSize: 13),
                      )
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.45,
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 70,
                          child: Text(
                            "ABONO: ",
                            style: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text(
                          "\$${Helpers.of(context).numberFormat(loan.abonado)}",
                          style: const TextStyle(fontSize: 13),
                        )
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 73,
                        child: Text(
                          "SALDO: ",
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(
                        "\$${Helpers.of(context).numberFormat(loan.totalSaldo)}",
                        style: const TextStyle(fontSize: 13),
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Text _status() {
    if (loan.refinanciado == 1) {
      return Text(
        "REFINANCIADO",
        style:
            TextStyle(fontWeight: FontWeight.bold, color: Colors.yellow[900]),
      );
    } else if (loan.estado == 2) {
      return Text(
        "FINALIZADO",
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue[900]),
      );
    } else if (loan.estado == 1) {
      return Text(
        "ACTIVO",
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green[900]),
      );
    } else if (loan.estado == 0) {
      return Text(
        "PENDIENTE DE APROBACION",
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[900]),
      );
    }

    return Text(
      "DESCONOCIDO",
      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[900]),
    );
  }
}
