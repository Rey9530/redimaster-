import 'package:credimaster/src/helper/helper.dart';
import 'package:credimaster/src/pages/charges/widgets/payament_resume_widget.dart';
import 'package:credimaster/src/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class ProcessPaymentPage extends StatefulWidget {
  const ProcessPaymentPage({super.key});

  @override
  State<ProcessPaymentPage> createState() => _ProcessPaymentPageState();
}

class _ProcessPaymentPageState extends State<ProcessPaymentPage> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CustomerProvide>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Total a cobrar"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Theme.of(context).appBarTheme.backgroundColor),
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Column(
                    children: [
                      Text(
                        "\$${Helpers.of(context).numberFormat(double.parse(provider.montoAbonar.text))}",
                        style:
                            const TextStyle(color: Colors.white, fontSize: 50),
                      )
                    ],
                  ),
                ),
              ),
            ),
            const PayamentResumeWidget(),
            const PagaConWifget(),
            const BtnPagar()
          ],
        ),
      ),
    );
  }
}

class BtnPagar extends StatelessWidget {
  const BtnPagar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CustomerProvide>(context);
    return Container(
      width: double.infinity,
      // margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        // vertical: 15,
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).primaryColor,
          textStyle: const TextStyle(color: Colors.white), 
        ), 
        onPressed: double.parse(provider.cambio.text) >= 0
            ? () async {
              await provider.processPayment();
                // BlocProvider.of<PaymentBloc>(context)
                //     .add(ProcessPayment(loanId: widget.loanId));
                // Navigator.pushNamedAndRemoveUntil(
                //     context, '/loading', (route) => false);
              }
            : null,
        child: const Text("PROCESAR PAGO"),
      ),
    );
  }
}

class PagaConWifget extends StatelessWidget {
  const PagaConWifget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CustomerProvide>(context);
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              TextField(
                onChanged: (value) {
                  provider.calculateValorCambio();
                },
                controller: provider.pagarCon,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: const FaIcon(FontAwesomeIcons.xmark),
                    onPressed: () {
                      // provider.cambio.clear();
                      provider.calculateValorCambio();
                    },
                  ),
                  icon: Icon(
                    FontAwesomeIcons.dollarSign,
                    color: Theme.of(context).primaryColor,
                  ),
                  labelText: "Paga con",
                  focusColor: Theme.of(context).primaryColor,
                  fillColor: Theme.of(context).primaryColor,
                  hoverColor: Theme.of(context).primaryColor,
                  suffixIconColor: Theme.of(context).primaryColor,
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  labelStyle: TextStyle(color: Theme.of(context).primaryColor),
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r"^[0-9.]+$"))
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Text(
              "Cambio: ",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            Text(
              "\$${Helpers.of(context).numberFormat(double.parse(provider.cambio.text))}",
              style: const TextStyle(fontSize: 15),
            ),
            const SizedBox(width: 15)
          ],
        )
      ],
    );
  }
}
