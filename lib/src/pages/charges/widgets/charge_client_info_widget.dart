import 'package:animate_do/animate_do.dart';
import 'package:credimaster/src/helper/helper.dart';
import 'package:credimaster/src/models/models.dart';
import 'package:credimaster/src/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class ChargerClientInfoWidget extends StatelessWidget {
  final Pago paymentModel;

  const ChargerClientInfoWidget({super.key, required this.paymentModel});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CustomerProvide>(context, listen: false);
    return GestureDetector(
      onLongPress: () => Fluttertoast.showToast(
          msg: "ID del prestamo: ${paymentModel.idPrestamo}"),
      child: Card(
        child: Container(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("INFORMACION DEL PRESTAMO"),
                  Icon(
                    FontAwesomeIcons.userLarge,
                    size: 13,
                  )
                ],
              ),
              const Divider(),
              Row(
                children: [
                  const Column(
                    children: [
                      Text(
                        "NOMBRE: ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      // Text(" ")
                    ],
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    child: Text(
                      paymentModel.cliente,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const Divider(),
              const SizedBox(height: 10),
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
                                fontSize: 13, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text(
                          "\$${Helpers.of(context).numberFormat(paymentModel.total)}",
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
                        "${paymentModel.porcentaje}%",
                        style: const TextStyle(fontSize: 13),
                      )
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  Row(
                    children: [
                      const SizedBox(
                        width: 73,
                        child: Text(
                          "ABONADO: ",
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(
                        "\$${Helpers.of(context).numberFormat(paymentModel.abonado)}",
                        style: const TextStyle(fontSize: 13),
                      )
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 5),
              const Row(
                children: [
                  // Container(
                  //   width: MediaQuery.of(context).size.width * 0.45,
                  //   child: Row(
                  //     children: [
                  //       Container(
                  //         width: 70,
                  //         child: Text(
                  //           "SALDO: ",
                  //           style: TextStyle(
                  //               fontSize: 13, fontWeight: FontWeight.bold),
                  //         ),
                  //       ),
                  //       Text(
                  //         "\$${Helpers.of(context).numberFormat(paymentModel.totalBalance)}",
                  //         style: TextStyle(fontSize: 13),
                  //       )
                  //     ],
                  //   ),
                  // ),
                  // Container(
                  //   child: Row(
                  //     children: [
                  //       Container(
                  //         width: 73,
                  //         child: Text(
                  //           "CAPITAL:",
                  //           style: TextStyle(
                  //               fontSize: 13, fontWeight: FontWeight.bold),
                  //         ),
                  //       ),
                  //       Text(
                  //         "\$${Helpers.of(context).numberFormat(paymentModel.capital)}",
                  //         style: TextStyle(fontSize: 13),
                  //       )
                  //     ],
                  //   ),
                  // ),
                ],
              ),
              const SizedBox(height: 5),
              FutureBuilder(
                future: provider.getLoanDetail(),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.done) {
                    return ZoomIn(
                      child: Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.45,
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 70,
                                  child: Text(
                                    "MORA: ",
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Text(
                                  "\$${Helpers.of(context).numberFormat(1.2)}",
                                  style: const TextStyle(fontSize: 13),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return Container();
                },
              ),
              // BlocBuilder<LoanDetailBloc, LoanDetailState>(
              //   builder: (BuildContext context, LoanDetailState state) {
              //     if (!state.loading) {
              //       return ZoomIn(
              //         child: Row(
              //           children: [
              //             Container(
              //               width: MediaQuery.of(context).size.width * 0.45,
              //               child: Row(
              //                 children: [
              //                   Container(
              //                     width: 70,
              //                     child: Text(
              //                       "MORA: ",
              //                       style: TextStyle(
              //                           fontSize: 13,
              //                           fontWeight: FontWeight.bold),
              //                     ),
              //                   ),
              //                   Text(
              //                     "\$${Helpers.of(context).numberFormat(state.arrears)}",
              //                     style: TextStyle(fontSize: 13),
              //                   )
              //                 ],
              //               ),
              //             ),
              //           ],
              //         ),
              //       );
              //     }

              //     return Container();
              //   },
              // ),
              const Divider(),
              const SizedBox(height: 10),
              if (paymentModel.possibleRefinancing) ...[
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        // style: ElevatedButton.styleFrom(
                        //   primary: Theme.of(context).appBarTheme.color,
                        // ),
                        onPressed: () async {
                          await Navigator.pushNamed(
                            context,
                            '/newApplication/${paymentModel.idPrestamo}',
                          );
                        },
                        child: const Text('REFINANCIAR PRESTAMO'),
                      ),
                    )
                  ],
                )
              ] else ...[
                const Center(child: Text("EL PRESTAMO NO SE PUEDE REFINANCIAR"))
              ]
            ],
          ),
        ),
      ),
    );
  }
}
