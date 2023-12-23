import 'package:credimaster/src/helper/helper.dart';
import 'package:credimaster/src/models/models.dart';
import 'package:credimaster/src/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PayamentResumeWidget extends StatelessWidget {
  const PayamentResumeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CustomerProvide>(context, listen: false);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Resumen del cobro",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const Divider(),
          FutureBuilder(
            future: provider.cargarCuotasPendientes(),
            builder: (BuildContext context,
                AsyncSnapshot<List<PaymentModel>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SizedBox();
              }
              return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data?.length ?? 0,
                itemBuilder: (BuildContext context, int index) {
                  if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  var p = snapshot.data![index];
                    return _ResumeItemWidget(
                      correlative: p.correlative,
                      mount: p.mount,
                      arrears: p.arrears,
                      partialMount: p.partialMount,
                      partialArrears: p.partialArrears,
                    );
                  }else{
                    return const SizedBox();
                  }
                },
              );
              // return Column(
              //   children: snapshot.data
              //       .map(
              //         (p) => _ResumeItemWidget(
              //           correlative: p.correlative,
              //           mount: p.mount,
              //           arrears: p.arrears,
              //           partialMount: p.partialMount,
              //           partialArrears: p.partialArrears,
              //         ),
              //       )
              //       .toList(),
              // );
            },
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Total",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Text(
                "\$${Helpers.of(context).numberFormat(double.parse(provider.montoAbonar.text))}",
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ],
          ),
          const Divider(),
        ],
      ),
    );
  }
}

class _ResumeItemWidget extends StatelessWidget {
  final String correlative;
  final double mount;
  final double arrears;
  final bool partialMount;
  final bool partialArrears;

  const _ResumeItemWidget(
      {required this.correlative,
      required this.mount,
      required this.arrears,
      required this.partialMount,
      required this.partialArrears});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                  "Cuota $correlative ${(partialMount) ? '- abono parcial' : ''}"),
              Text("\$${Helpers.of(context).numberFormat(mount)}"),
            ],
          ),
          if (arrears > 0) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const SizedBox(width: 10),
                    Text("Mora ${(partialArrears) ? '- abono parcial' : ''}"),
                  ],
                ),
                Text("\$${Helpers.of(context).numberFormat(arrears)}"),
              ],
            ),
          ]
        ],
      ),
    );
  }
}
