import 'package:animate_do/animate_do.dart';
import 'package:credimaster/src/models/models.dart';
import 'package:credimaster/src/pages/charges/widgets/charge_client_info_widget.dart';
import 'package:credimaster/src/pages/charges/widgets/charge_payament_item_widget.dart';  
import 'package:credimaster/src/pages/customer/widget/pay_dialog_widget.dart';
import 'package:credimaster/src/pages/customer/widget/proceed_to_payment_button_widget.dart';
import 'package:credimaster/src/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChargeInfoPage extends StatelessWidget {
  const ChargeInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CustomerProvide>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detalle del prestamo"),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  ChargerClientInfoWidget(
                    paymentModel: provider.payment!,
                  ),
                  FutureBuilder(
                    future: provider.getLoanDetail(),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<DetallePrestamo>> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Column(
                          children: [
                            SizedBox(height: 100),
                            CircularProgressIndicator(),
                          ],
                        );
                      }
                      // return SizedBox();
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data?.length ?? 0,
                        itemBuilder: (BuildContext context, int index) {
                          var c = snapshot.data?[index];
                          return FadeInUp(
                            child: ChargerPayamentItemWidget(
                              arrears: c?.mora ?? 0.0,
                              correlative: c?.correlativo ?? "N/A",
                              dateExpires: c?.fechaVence ?? "",
                              mount: c?.monto ?? 0.0,
                              paidOut: (c?.pagado == 1),
                              paymentMount: c?.abono ?? 0.0,
                              loanDetailDetailModel: c?.detalle ?? [],
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          ProceedToPaymentButtonWidget(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return PayDialogWidget(
                    loanId: provider.payment?.idPrestamo ?? 0,
                  );
                },
              );
            },
          )
        ],
      ),
    );
  }
}
