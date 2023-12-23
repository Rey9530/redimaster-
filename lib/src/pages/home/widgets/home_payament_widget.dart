import 'package:credimaster/src/helper/helper.dart'; 
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePaymentWidget extends StatelessWidget {
  final String customer;
  final double mount;
  final double balance;
  final double arrears;
  final Function onTap;

  const HomePaymentWidget({
    super.key,
    required this.customer,
    required this.mount,
    required this.balance,
    required this.arrears,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        onTap();
      },
      leading: CircleAvatar(
        backgroundColor: Theme.of(context).primaryColor,
        child: const FaIcon(
          FontAwesomeIcons.handHoldingDollar,
          color: Colors.white,
        ),
      ),
      title: Text(customer),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Text(
                "Monto: ",
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
              ),
              Text(
                "\$${Helpers.of(context).numberFormat(mount)}",
                style: const TextStyle(fontSize: 13),
              )
            ],
          ),
          Row(
            children: [
              const Text(
                "Saldo: ",
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
              ),
              Text(
                "\$${Helpers.of(context).numberFormat(balance)}",
                style: const TextStyle(fontSize: 13),
              )
            ],
          ),
          Row(
            children: [
              const Text(
                "Mora: ",
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
              ),
              Text(
                "\$${Helpers.of(context).numberFormat(arrears)}",
                style: const TextStyle(fontSize: 13),
              )
            ],
          ),
        ],
      ),
    );
  }
}
