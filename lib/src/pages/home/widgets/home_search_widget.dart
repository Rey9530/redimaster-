import 'package:flutter/material.dart';

class HomeSearchWidget extends StatelessWidget {
  const HomeSearchWidget({
    super.key,
    required this.onTap,
  });

  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        child: TextField(
          enabled: false,
          decoration: InputDecoration(
            suffixIcon: const Icon(Icons.search),
            disabledBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Colors.grey.withOpacity(0.1), width: 0.0),
                borderRadius: BorderRadius.circular(50)),
            filled: true,
            fillColor: Colors.grey.withOpacity(0.1),
            contentPadding: const EdgeInsets.symmetric(horizontal: 25),
            labelText: 'Buscar cliente',
          ),
        ),
      ),
    );
  }
}
