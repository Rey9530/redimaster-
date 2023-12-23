import 'package:credimaster/src/providers/customers_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class PayDialogWidget extends StatefulWidget {
  final int loanId;

  const PayDialogWidget({
    super.key,
    required this.loanId,
  });
  @override
  State<PayDialogWidget> createState() => _PayDialogWidgetState();
}

class _PayDialogWidgetState extends State<PayDialogWidget> {
  final TextEditingController payment = TextEditingController();
  bool validQuantity = false;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CustomerProvide>(context, listen: false);
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Wrap(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              width: double.infinity,
              child: const Text(
                "Ingrese el monto a abonar",
                textAlign: TextAlign.center,
              ),
            ),
            TextField(
              controller: payment,
              onChanged: _validateQuantity,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                icon: Icon(
                  FontAwesomeIcons.dollarSign,
                  color: Theme.of(context).primaryColor,
                ),
                focusColor: Theme.of(context).primaryColor,
                fillColor: Theme.of(context).primaryColor,
                hoverColor: Theme.of(context).primaryColor,
                suffixIconColor: Theme.of(context).primaryColor,
              ),
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r"^[0-9.]+$"))
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      "CANCELAR",
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                  ),
                  TextButton(
                    onPressed: (validQuantity)
                        ? () {
                            provider.montoAbonar.text = payment.text;
                            Navigator.pop(context);
                            Navigator.pushNamed(
                              context,
                              '/process_payament',
                            );
                          }
                        : null,
                    child: Text(
                      "CONTINUAR",
                      style: TextStyle(
                        color: (validQuantity)
                            ? Theme.of(context).primaryColor
                            : Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _validateQuantity(String value) {
    setState(() {});
    if (RegExp(r"^[0-9]+([.][0-9]{1,2})?$").hasMatch(value)) {
      double quantity = double.parse(value);
      if (quantity > 0) {
        validQuantity = true;
      } else {
        validQuantity = false;
      }
    } else {
      validQuantity = false;
    }
  }
}
