import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeMenuWidget extends StatelessWidget {
  const HomeMenuWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _HomeMenuItemWidget(
              onTap: () => Navigator.pushNamed(context, '/charges'),
              menuName: "Cobros",
              color: Colors.green,
              icon: FontAwesomeIcons.handHoldingDollar,
            ),
            _HomeMenuItemWidget(
              onTap: () => Navigator.pushNamed(context, '/customers'),
              menuName: "Clientes",
              color: Colors.blue,
              icon: FontAwesomeIcons.idCard,
            ),
            _HomeMenuItemWidget(
                onTap: () => Navigator.pushNamed(context, '/report'),
                menuName: "Corte",
                color: Colors.red,
                icon: FontAwesomeIcons.wallet),
            _HomeMenuItemWidget(
              onTap: () => Navigator.pushNamed(context, "/loanAplicaction"),
              menuName: "Solicitudes",
              color: Colors.indigo,
              icon: FontAwesomeIcons.fileLines,
            ),
            _HomeMenuItemWidget(
              onTap: () => Navigator.pushNamed(context, "/calculator"),
              menuName: "Calculadora",
              color: Colors.orange,
              icon: FontAwesomeIcons.calculator,
            ),
          ],
        ),
        const SizedBox(height: 10),
        const Row(
          children: [
            SizedBox(
              width: 20,
            ),
            Text(
              "Cobros",
              style: TextStyle(fontSize: 15),
            ),
          ],
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}

class _HomeMenuItemWidget extends StatelessWidget {
  final String menuName;
  final Color color;
  final IconData icon;
  final Function onTap;
  const _HomeMenuItemWidget(
      {required this.menuName,
      required this.color,
      required this.icon,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Column(
        children: [
          Container(
            height: size.width * 0.15,
            width: size.width * 0.15,
            decoration: BoxDecoration(
                color: color, borderRadius: BorderRadius.circular(50)),
            child: Center(
                child: FaIcon(
              icon,
              color: Colors.white,
              size: 30,
            )),
          ),
          const SizedBox(height: 5),
          Text(
            menuName,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 12),
          )
        ],
      ),
    );
  }
}
