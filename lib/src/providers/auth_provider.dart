import 'dart:convert';

import 'package:credimaster/src/models/models.dart';
import 'package:credimaster/src/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:package_info_plus/package_info_plus.dart';

class AuthProvide extends ChangeNotifier {
// Create storage
  final storage = const FlutterSecureStorage();
  final conexion = ConexionesProvider();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController userController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool loading = false;
  loadingF(val) {
    loading = val;
    notifyListeners();
  }

  logIn() async {
    var body = {
      "user": userController.text,
      "password": passwordController.text,
      "token": passwordController.text,
    };
    loadingF(true);
    var resp = await conexion.post_("login", body);
    loadingF(false);
    if (resp.statusCode == 200) {
      await storage.deleteAll();
      final response = usersModelFromJson(resp.body);
      // await storage.write(key: 'user_s', value: userController.text);
      // await storage.write(key: 'password_s', value: passwordController.text);
      userController.text = '';
      passwordController.text = '';
      await saveStorage(response);
      return resp.statusCode.toString();
      // return response.data;
    } else {
      var msj = jsonDecode(resp.body);
      var codec = "Error de credenciales";
      if (msj != null && msj['message'] != null && msj['message'].length > 0) {
        codec = msj['message'];
      }
      return codec;
    }
  }

  logInByBiometrics() async {
    var body = {
      "email": await storage.read(key: 'user_s') ?? 'false',
      "password": await storage.read(key: 'password_s') ?? 'false',
    };
    loadingF(true);
    var resp = await conexion.post_("login", jsonEncode(body));
    loadingF(false);
    if (resp.statusCode == 200) {
      // final response = userModelFromJson(resp.body);
      final response = jsonDecode(resp.body);
      // await saveStorage(response);
      return response['data'];
    } else {
      return "419";
    }
  }

  loadStatusBiometric() async {
    var biometric = await storage.read(key: 'biometric') ?? 'false';
    return biometric;
  }

  loadStatusBiometricAndCredentials() async {
    var biometric = await storage.read(key: 'biometric') ?? 'false';
    var user = await storage.read(key: 'user_s') ?? 'false';
    var password = await storage.read(key: 'password_s') ?? 'false';
    return biometric == 'false' || user == 'false' || password == 'false'
        ? 'false'
        : 'true';
  }

  logout() async {
    await storage.delete(key: 'token');
    return "200";
  }

  Future reloadtoken() async {
    var token = await storage.read(key: 'token') ?? 'false';
    if (token == 'false') {
      return "419";
    }
    final jsonData =
        await conexion.get_('verify', {}, {'Authorization': 'Bearer $token'});
    if (jsonData.statusCode == 200) {
      final response = usersModelFromJson(jsonData.body);
      // final response = jsonDecode(jsonData.body);
      var returns = jsonData.statusCode.toString();
      var biometric = await storage.read(key: 'biometric');
      if (biometric == 'true') {
        returns = 'biometric';
      }
      await saveStorage(response);
      return returns;
    } else {
      return "419";
    }
  }

  saveBiometricData() async {
    await storage.write(key: 'biometric', value: 'true');
  }

  deleteBiometricData() async {
    await storage.delete(key: 'biometric');
  }

  UserModel? userModel;
  saveStorage(UsersModel response) async {
    userModel = response.data;
    await storage.write(key: 'name', value: response.data.name);
    await storage.write(key: 'id_user', value: response.data.idUser.toString());
    await storage.write(key: 'roll', value: response.data.roll.toString());
    await storage.write(key: 'user', value: response.data.user);

    if (response.data.token.length > 4) {
      await storage.write(key: 'token', value: response.data.token);
    }
    return response.data.name;
  }

  // updatePassword(valor) async {
  //   var body = {
  //     "password": valor,
  //   };
  //   loadingF(true);
  //   var resp = await conexion.post_("auth/password", jsonEncode(body));
  //   loadingF(false);
  //   return resp;
  // }

  // resetPassword(valor) async {
  //   var body = {
  //     "email": valor,
  //   };
  //   loadingF(true);
  //   var resp = await conexion.post_("auth/reset_password", jsonEncode(body));
  //   loadingF(false);
  //   return resp;
  // }
}
