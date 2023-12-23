String? nameValidator(String value) {
  if (value.trim().length < 3) {
    return 'Ingrese un nombre válido';
  } else {
    return null;
  }
}

String? profesionValidator(String value) {
  if (value.trim().length < 3) {
    return 'Ingrese una profesión válida';
  } else {
    return null;
  }
}

String? birthdateValidator(String value) {
  if (value.trim() == "") {
    return 'Seleccione una fecha de nacimiento';
  } else {
    return null;
  }
}

String? addressValidator(String value) {
  if (value.trim().length < 5) {
    return 'Ingrese una dirección válida';
  } else {
    return null;
  }
}

String? duiValidator(String value) {
  if (value.trim().length < 10) {
    return 'Ingrese un dui válido';
  } else {
    return null;
  }
}

String? nitValidator(String value) {
  if (value.trim().length < 17) {
    return 'Ingrese un nit válido';
  } else {
    return null;
  }
}

String? phoneValidator(String value) {
  if (value.trim().length < 9) {
    return "Ingrese un teléfono válido";
  } else {
    return null;
  }
}

String? optionalPhoneValidator(String value) {
  if (value.trim() != "" && value.trim().length < 9) {
    return "Ingrese un teléfono válido";
  } else {
    return null;
  }
}

String? emailValidator(String value) {
  if (RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(value.trim())) {
    return null;
  } else {
    return "Ingrese un correo válido";
  }
}

String? optionalEmailValidator(String value) {
  if (value.trim() != "") {
    if (RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value.trim())) {
      return null;
    } else {
      return "Ingrese un correo válido";
    }
  } else {
    return null;
  }
}

String? passwordValidator(String value) {
  if (value.trim().length < 6) {
    return 'Ingrese una contraseña válida';
  } else {
    return null;
  }
}

String? passwordRegister(String password) {
  bool lower = RegExp(r'[a-z]').hasMatch(password);
  bool capital = RegExp(r'[A-Z]').hasMatch(password);
  bool number = RegExp(r'[0-9]').hasMatch(password);
  bool lenght = (password.trim().length >= 6);

  if (lower && capital && number && lenght) {
    return null;
  }
  {
    return "Ingrese una contraseña válida";
  }
}

String? commerceNameValidator(String value) {
  if (value.trim() != "" && value.trim().length < 3) {
    return 'Ingrese un nommbre de negocio válido';
  } else {
    return null;
  }
}

String? commerceActivityValidator(String value) {
  if (value.trim() != "" && value.trim().length < 3) {
    return 'Ingrese una actividad válida';
  } else {
    return null;
  }
}

String? commerceAddressValidator(String value) {
  if (value.trim() != "" && value.trim().length < 3) {
    return 'Ingrese una direccion válida';
  } else {
    return null;
  }
}

String? documentDescriptionValidator(String value) {
  if (value.trim() == "") {
    return 'Ingrese una descripción válida';
  } else {
    return null;
  }
}
