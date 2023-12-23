import 'package:credimaster/src/pages/pages.dart';
import 'package:credimaster/src/providers/providers.dart';
import 'package:flutter/material.dart';
// import 'package:fup/src/helpers/authentication_biometric.dart';
// import 'package:fup/src/pages/pages.dart';
// import 'package:fup/src/providers/providers.dart';
import 'package:provider/provider.dart';

class CheckAuthScreen extends StatelessWidget {
  static const routeName = 'checking';
  const CheckAuthScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AuthProvide>(context, listen: false);
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: provider.reloadtoken(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasData &&
                snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data == "200") {
                Future.microtask(
                  () {
                    Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (_, __, ___) => const HomePage(),
                        transitionDuration: const Duration(seconds: 0),
                      ),
                    );
                  },
                );
              // } else if (snapshot.data == "update") {
              //   Future.microtask(
              //     () {
              //       Navigator.pushReplacement(
              //         context,
              //         PageRouteBuilder(
              //           pageBuilder: (_, __, ___) => const UpdatePage(),
              //           transitionDuration: const Duration(seconds: 0),
              //         ),
              //       );
              //     },
              //   );
              // } else if (snapshot.data == "biometric") {
              //   Future.microtask(
              //     () {
              //       Navigator.pushReplacement(
              //         context,
              //         PageRouteBuilder(
              //           pageBuilder: (_, __, ___) =>
              //               const VerifyBiometricsWidget(),
              //           transitionDuration: const Duration(seconds: 0),
              //         ),
              //       );
              //     },
              //   );
              } else {
                Future.microtask(
                  () {
                    Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (_, __, ___) => const LoginPage(),
                        transitionDuration: const Duration(seconds: 0),
                      ),
                    );
                  },
                );
              }
            }
            return Container();
          },
        ),
      ),
    );
  }
}

// class VerifyBiometricsWidget extends StatelessWidget {
//   const VerifyBiometricsWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: FutureBuilder(
//         future: authenticateWithBiometrics(),
//         builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.data == true) {
//             Future.microtask(
//               () {
//                 Navigator.pushReplacement(
//                   context,
//                   PageRouteBuilder(
//                     pageBuilder: (_, __, ___) => const HomeMenuPage(),
//                     transitionDuration: const Duration(seconds: 0),
//                   ),
//                 );
//               },
//             );
//           } else {
//             Future.microtask(
//               () {
//                 Navigator.pushReplacement(
//                   context,
//                   PageRouteBuilder(
//                     pageBuilder: (_, __, ___) => const LoginPage(),
//                     transitionDuration: const Duration(seconds: 0),
//                   ),
//                 );
//               },
//             );
//           }
//           return Container();
//         },
//       ),
//     );
//   }
// }
