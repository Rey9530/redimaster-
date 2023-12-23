import 'package:credimaster/src/models/models.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ClientTradeInfoWidget extends StatelessWidget {
  final Customer customerModel;
  const ClientTradeInfoWidget({super.key, required this.customerModel});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(15),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Infomación del negocio",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                FaIcon(
                  FontAwesomeIcons.store,
                  size: 15,
                )
              ],
            ),
            const Divider(),
            if (customerModel.negocio != "") ...[
              Text("NOMBRE DEL NEGOCIO: ${customerModel.negocio}"),
              const SizedBox(height: 10),
            ],
            if (customerModel.actividadNegocio != "") ...[
              Text("ACTIVIDAD DEL NEGOCIO: ${customerModel.actividadNegocio}"),
              const SizedBox(height: 10),
            ],
            if (customerModel.direccionNegocio != "") ...[
              Text("DIRECCION DEL NEGOCIO: ${customerModel.direccionNegocio}"),
              const SizedBox(height: 10),
            ]
          ],
        ),
      ),
    );
  }
}
