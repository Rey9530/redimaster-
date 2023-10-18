import 'package:flutter/material.dart';

class RoundedButtonWidget extends StatelessWidget {
  final String text;
  final Function()? onPressed;
  final bool disabled;

  const RoundedButtonWidget({
    super.key,
    this.text = "GUARDAR",
    this.onPressed,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(100)),
          color: disabled
              ? Theme.of(context).primaryColor.withOpacity(0.5)
              : Theme.of(context).primaryColor),
      child: TextButton(
        onPressed: disabled ? null : onPressed,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
