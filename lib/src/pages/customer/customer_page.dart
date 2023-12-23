import 'package:credimaster/src/pages/customer/widget/client_documents_widget.dart';
import 'package:credimaster/src/pages/customer/widget/client_personal_info_widget.dart';
import 'package:credimaster/src/pages/customer/widget/client_trade_info_widget.dart';
import 'package:credimaster/src/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomerPage extends StatelessWidget {
  const CustomerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CustomerProvide>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Perfil del cliente"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              ClientPersonalInfoWidget(
                customerModel: provider.customer!,
              ),
              if (provider.customer!.negocio != "" ||
                  provider.customer!.actividadNegocio != "" ||
                  provider.customer!.direccionNegocio != '') ...[
                ClientTradeInfoWidget(
                  customerModel: provider.customer!,
                ),
              ],
              if (provider.customer!.documentos.isNotEmpty) ...[
                ClientDocumentsWidget(customer: provider.customer!)
              ]
            ],
          ),
        ),
      ),
    );
  }
}
