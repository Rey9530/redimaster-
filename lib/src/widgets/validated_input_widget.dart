import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum InputFormatType {
  length3,
  length8,
  email,
  password4,
  password6,
  password6Register,
  password8,
}

class ValidatedInput extends StatefulWidget {
  const ValidatedInput({
    super.key,
    required this.label,
    this.icon,
    this.validator,
    this.onSaved,
    this.initialValue,
    this.suffixIcon = Icons.arrow_drop_down,
    this.suffixFunction,
    this.controller,
    this.formatType,
    this.obscureText = false,
    this.keyboardType,
    this.inputFormatter,
    this.onChange,
    this.showSufixIcon,
    this.readOnly = false,
    this.onTap,
  });

  final String label;
  final String? initialValue;
  final IconData? icon;
  final IconData suffixIcon;
  final Function? validator;
  final Function? onSaved;
  final Function? suffixFunction;
  final TextEditingController? controller;
  final InputFormatType? formatType;
  final bool obscureText;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatter;
  final Function(String value)? onChange;
  final bool? showSufixIcon;
  final bool readOnly;
  final Function? onTap;

  @override
  State<ValidatedInput> createState() => _ValidatedInputState();
}

class _ValidatedInputState extends State<ValidatedInput> {
  bool showSufixIcon = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        readOnly: widget.readOnly,
        onTap: () {
          if (widget.onTap != null) {
            widget.onTap!();
          }
        },
        inputFormatters: widget.inputFormatter,
        keyboardType: widget.keyboardType,
        obscureText: widget.obscureText,
        onChanged: (widget.onChange) ?? inputType,
        controller: widget.controller,
        initialValue:
            (widget.initialValue != null) ? widget.initialValue : null,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          suffixIcon: (widget.showSufixIcon != null &&
                  widget.showSufixIcon != null &&
                  widget.showSufixIcon == true)
              ? const Icon(Icons.check_circle_outline)
              : (!showSufixIcon)
                  ? (widget.suffixFunction != null)
                      ? IconButton(
                          icon: Icon(widget.suffixIcon),
                          onPressed: () {
                            if (widget.suffixFunction != null) {
                              widget.suffixFunction!();
                            }
                          },
                        )
                      : null
                  : const Icon(Icons.check_circle_outline),
          icon: (widget.icon != null) ? Icon(widget.icon) : null,
          labelText: widget.label,
          // border: OutlineInputBorder(
          //     borderSide: BorderSide(width: 1, style: BorderStyle.solid)),
        ),
        onSaved: (valor) {
          if (widget.onSaved != null) {
            widget.onSaved!(valor);
          }
        },
        validator: (valor) {
          if (widget.validator != null) {
            return widget.validator!(valor);
          }
          return null;
        },
      ),
    );
  }

  void inputType(value) {
    setState(() {
      switch (widget.formatType) {
        case InputFormatType.length3:
          showSufixIcon = lenght3Format(value);
          break;
        case InputFormatType.length8:
          showSufixIcon = lenght8Format(value);
          break;
        case InputFormatType.email:
          showSufixIcon = emailFormat(value);
          break;
        case InputFormatType.password4:
          showSufixIcon = password4Format(value);
          break;
        case InputFormatType.password6:
          showSufixIcon = password6Format(value);
          break;
        case InputFormatType.password6Register:
          showSufixIcon = password6RegisterFormat(value);
          break;
        case InputFormatType.password8:
          showSufixIcon = password8Format(value);
          break;
        case null:
      }
    });
  }

  bool lenght3Format(String value) {
    if (value.length >= 3) {
      return true;
    } else {
      return false;
    }
  }

  bool lenght8Format(String value) {
    if (value.length >= 8) {
      return true;
    } else {
      return false;
    }
  }

  bool emailFormat(String value) {
    final bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value.trim());
    return emailValid;
  }

  bool password4Format(String value) {
    if (value.length >= 4) {
      return true;
    } else {
      return false;
    }
  }

  bool password6Format(String value) {
    if (value.length >= 6) {
      return true;
    } else {
      return false;
    }
  }

  bool password6RegisterFormat(String value) {
    bool lower = RegExp(r'[a-z]').hasMatch(value);
    bool capital = RegExp(r'[A-Z]').hasMatch(value);
    bool number = RegExp(r'[0-9]').hasMatch(value);
    bool lenght = (value.trim().length >= 6);
    if (lower && capital && number && lenght) {
      return true;
    } else {
      return false;
    }
  }

  bool password8Format(String value) {
    if (value.length >= 8) {
      return true;
    } else {
      return false;
    }
  }
}

class PasswordIndication extends StatefulWidget {
  const PasswordIndication({super.key, required this.password});

  final String password;

  @override
  State<PasswordIndication> createState() => _PasswordIndicationState();
}

class _PasswordIndicationState extends State<PasswordIndication> {
  bool capital = false;
  bool lower = false;
  bool number = false;
  bool lenght = false;

  void match(String password) {
    // Verificamos que contenga al menos una minuscula
    lower = RegExp(r'[a-z]').hasMatch(password);
    capital = RegExp(r'[A-Z]').hasMatch(password);
    number = RegExp(r'[0-9]').hasMatch(password);
    lenght = (password.trim().length >= 6);
  }

  @override
  Widget build(BuildContext context) {
    match(widget.password);
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 45),
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
      child: Column(
        children: [
          PassworIndicatorItem(
            condition: capital,
            text: "Al menos una mayuscula",
          ),
          PassworIndicatorItem(
            condition: lower,
            text: "Al menos una minuscula",
          ),
          PassworIndicatorItem(
            condition: number,
            text: "Al menos un número",
          ),
          PassworIndicatorItem(
            condition: lenght,
            text: "Al menos 6 carácteres",
          ),
        ],
      ),
    );
  }
}

class PassworIndicatorItem extends StatelessWidget {
  const PassworIndicatorItem({
    super.key,
    required this.condition,
    this.text,
  });

  final bool condition;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          if (condition) ...[
            ZoomIn(
              child: const Icon(
                FontAwesomeIcons.circleCheck,
                color: Colors.green,
                size: 15,
              ),
            )
          ] else ...[
            const Icon(
              FontAwesomeIcons.circle,
              color: Colors.grey,
              size: 15,
            )
          ],
          const SizedBox(
            width: 10
          ),
          if (condition) ...[
            FadeIn(
              child: Text(
                text != null ? text! : '',
                style: const TextStyle(
                  color: Colors.green,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
            )
          ] else ...[
            Text(
                text != null ? text! : '',
              style: const TextStyle(color: Colors.grey),
            )
          ]
        ],
      ),
    );
  }
}
