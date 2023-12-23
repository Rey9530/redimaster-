import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeUserWidget extends StatelessWidget {
  final String userName;
  const HomeUserWidget({
    super.key,
    required this.userName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).appBarTheme.backgroundColor,
      width: double.infinity,
      // height: 100,
      child: Column(
        children: [
          const SizedBox(height: 20),
          Row(
            children: [
              const SizedBox(width: 20),
              Expanded(
                child: Text(
                  userName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
              const FaIcon(
                FontAwesomeIcons.dollarSign,
                color: Colors.white,
              ),
              const SizedBox(width: 40),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
