import 'package:built_collection/built_collection.dart';
import 'package:credimaster/src/models/models.dart';
import 'package:credimaster/src/widgets/image_view_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ClientDocumentsWidget extends StatelessWidget {
  const ClientDocumentsWidget({
    super.key,
    required this.customer,
  });

  final Customer customer;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Documentos",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  FaIcon(
                    FontAwesomeIcons.fileLines,
                    size: 15,
                  )
                ],
              ),
            ),
            const Divider(),
            SizedBox(
              width: double.infinity,
              child: ImageView(
                documents: BuiltList<Documento>([...customer.documentos]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
