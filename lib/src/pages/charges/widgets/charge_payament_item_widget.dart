import 'package:credimaster/src/helper/helper.dart';
import 'package:credimaster/src/helper/math_helpers.dart';
import 'package:credimaster/src/widgets/simple_dialog.dart';
import 'package:flutter/material.dart' hide SimpleDialog;
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ChargerPayamentItemWidget extends StatefulWidget {
  final String correlative;
  final String dateExpires;
  final double mount;
  final double paymentMount;
  final double arrears;
  final bool paidOut;
  final dynamic loanDetailDetailModel;

  const ChargerPayamentItemWidget({
    super.key,
    required this.correlative,
    required this.dateExpires,
    required this.mount,
    required this.paymentMount,
    required this.arrears,
    required this.paidOut,
    required this.loanDetailDetailModel,
  });

  @override
  _ChargerPayamentItemWidgetState createState() =>
      _ChargerPayamentItemWidgetState();
}

class _ChargerPayamentItemWidgetState extends State<ChargerPayamentItemWidget> {
  late double balance;
  late double paymentMount;

  @override
  void initState() {
    // Calculamos abono y el saldo
    if (widget.paidOut) {
      paymentMount =
          MathHelpers().roundDouble(widget.arrears + widget.mount, 2);
      balance = 0.0;
    } else {
      paymentMount = MathHelpers().roundDouble(widget.paymentMount, 2);
      balance = MathHelpers().roundDouble(
          (widget.mount + widget.arrears) - widget.paymentMount, 2);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () => _showDetail(context, widget.loanDetailDetailModel),
      child: Card(
        child: Container(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Cuota: ${widget.correlative}"),
                  Row(
                    children: [
                      Text(
                          "Fecha vence: ${Helpers.of(context).dateFormat(widget.dateExpires)}"),
                      const SizedBox(width: 5),
                      const Icon(
                        FontAwesomeIcons.fileInvoiceDollar,
                        size: 13,
                      ),
                      if (widget.loanDetailDetailModel.isNotEmpty) ...[
                        const SizedBox(width: 5),
                        const Icon(
                          FontAwesomeIcons.receipt,
                          size: 13,
                        ),
                      ]
                    ],
                  )
                ],
              ),
              const Divider(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const SizedBox(
                              width: 55,
                              child: Text(
                                "Monto:",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Text(
                                "\$${Helpers.of(context).numberFormat(widget.mount)}")
                          ],
                        ),
                        Row(
                          children: [
                            const SizedBox(
                              width: 55,
                              child: Text(
                                "Mora:",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Text(
                                "\$${Helpers.of(context).numberFormat(widget.arrears)}")
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const SizedBox(
                                width: 55,
                                child: Text(
                                  "Abono:",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )),
                            Text(
                                "\$${Helpers.of(context).numberFormat(paymentMount)}")
                          ],
                        ),
                        Row(
                          children: [
                            const SizedBox(
                              width: 55,
                              child: Text(
                                "Saldo:",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Text(
                                "\$${Helpers.of(context).numberFormat(balance)}")
                          ],
                        ),
                      ],
                    ),
                  ),
                  if (widget.paidOut) ...[
                    Container(
                      padding: const EdgeInsets.all(8),
                      child: const Icon(
                        FontAwesomeIcons.solidCircleCheck,
                        color: Colors.green,
                      ),
                    )
                  ] else if (widget.arrears != 0) ...[
                    Container(
                      padding: const EdgeInsets.all(8),
                      child: const Icon(
                        FontAwesomeIcons.circleExclamation,
                        color: Colors.orange,
                      ),
                    )
                    // Container(
                    //   width: 60,
                    //   child: Column(
                    //     crossAxisAlignment: CrossAxisAlignment.end,
                    //     children: [
                    //       Text(
                    //         "Pagar",
                    //         style: TextStyle(fontWeight: FontWeight.bold),
                    //       ),
                    //       Switch(
                    //         value: false,
                    //         onChanged: (value) {},
                    //         activeTrackColor: Colors.lightGreenAccent,
                    //         activeColor: Colors.green,
                    //       ),
                    //     ],
                    //   ),
                    // )
                  ] else ...[
                    Container(
                        padding: EdgeInsets.all(8),
                        child: Icon(
                          FontAwesomeIcons.plusCircle,
                          color: Colors.blue,
                        ))
                  ]
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  _showDetail(BuildContext context, dynamic detail) {
    HapticFeedback.lightImpact();
    if (detail.isEmpty) {
      Fluttertoast.showToast(msg: "No hay pagos parciales");
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: "Abonos parciales",
            child: Column(
              children: detail
                  .map(
                    (d) => ListTile(
                      leading: const Icon(FontAwesomeIcons.dollarSign),
                      title: Text(d['date']),
                      subtitle: Text(d['time']),
                      trailing: Text("\$${d['value']}"),
                    ),
                  )
                  .toList(),
            ),
          );
        },
      );
    }
  }
}
