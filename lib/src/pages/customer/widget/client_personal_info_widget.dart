// import 'package:cached_network_image/cached_network_image.dart';
import 'package:credimaster/src/models/models.dart';
import 'package:credimaster/src/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class ClientPersonalInfoWidget extends StatelessWidget {
  final Customer customerModel;

  const ClientPersonalInfoWidget({
    super.key,
    required this.customerModel,
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CustomerProvide>(context, listen: false);
    return Card(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Hero(
                tag: customerModel.idCliente,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(360),
                  child: Container(
                    width: 125,
                    height: 125,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(360),
                    ),
                    child: FaIcon(
                      FontAwesomeIcons.userLarge,
                      color: Colors.white,
                    ),
                    //TODO: revisar estos
                    // CachedNetworkImage(
                    //   fit: BoxFit.cover,
                    //   imageUrl: customerModel.imagen,
                    //   errorWidget: (context, url, error) => const Center(
                    //     child: FaIcon(
                    //       FontAwesomeIcons.userLarge,
                    //       color: Colors.white,
                    //     ),
                    //   ),
                    // ),
                  ),
                ),
              ),
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Theme.of(context).primaryColor,
                      ),
                    ),
                    onPressed: () {
                      provider.customerId = customerModel.idCliente;
                      Navigator.pushNamed(context, '/loans');
                    },
                    child: const Text(
                      "HISTORIAL DE PRESTAMOS",
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Infomación personal",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                FaIcon(
                  FontAwesomeIcons.userLarge,
                  size: 15,
                )
              ],
            ),
            const Divider(),
            Text("NOMBRE: ${customerModel.nombre}"),
            const SizedBox(height: 10),
            Text("PROFESION U OFICIO: ${customerModel.profesion}"),
            const SizedBox(height: 10),
            Text("FECHA DE NACIMIENTO: ${customerModel.fechaNacimiento}"),
            const SizedBox(height: 10),
            Text("DUI: ${customerModel.dui}"),
            const SizedBox(height: 10),
            Text("NIT: ${customerModel.nit}"),
            const SizedBox(height: 20),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Dirección",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                FaIcon(
                  FontAwesomeIcons.diamondTurnRight,
                  size: 15,
                )
              ],
            ),
            const Divider(),
            Text("DEPARTAMENTO: ${customerModel.departamento}"),
            const SizedBox(height: 10),
            Text("MUNICIPIO: ${customerModel.municipio}"),
            const SizedBox(height: 10),
            Text("DIRECCION: COL. ${customerModel.direccion}"),
            const SizedBox(height: 15),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Contacto", style: TextStyle(fontWeight: FontWeight.bold)),
                FaIcon(
                  FontAwesomeIcons.phone,
                  size: 15,
                )
              ],
            ),
            const SizedBox(height: 10),
            Text("TELEFONO 1: ${customerModel.telefono}"),
            const SizedBox(height: 10),
            Text("TELEFONO 2: ${customerModel.telefono2}"),
            const SizedBox(height: 10),
            Text("CORREO: ${customerModel.correo}"),
          ],
        ),
      ),
    );
  }
}
