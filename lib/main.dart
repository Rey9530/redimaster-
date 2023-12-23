import 'package:credimaster/src/pages/pages.dart';
import 'package:credimaster/src/providers/providers.dart';
import 'package:credimaster/src/theme/styles/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvide()),
        ChangeNotifierProvider(create: (_) => PreferenceStorageProvide()),
        ChangeNotifierProvider(create: (_) => CustomerProvide()),
      ],
      child: const MaterialWidget(),
    );
  }
}

class MaterialWidget extends StatelessWidget {
  const MaterialWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final provider =
        Provider.of<PreferenceStorageProvide>(context, listen: false);
    return FutureBuilder(
      future: provider.getTheme(),
      builder: (BuildContext context, AsyncSnapshot<ThemeMode> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        return const MaterialW();
      },
    );
  }
}

class MaterialW extends StatelessWidget {
  const MaterialW({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PreferenceStorageProvide>(context);
    return MaterialApp(
      title: 'CrediMaster',
      themeMode: provider.theme,
      theme: themesData[provider.theme],
      debugShowCheckedModeBanner: false,
      initialRoute: 'checking',
      // home: const LoginPage(),
      routes: {
        'checking': (_) => const CheckAuthScreen(),
        '/profile': (_) => const ProfilePage(),
        '/customer': (_) => const CustomerPage(),
        '/customers': (_) => const CustomersPage(),
        '/add/customer': (_) => const AddCustomerPage(),
        '/loans': (_) => const LoadPage(),
        '/charge': (_) => const ChargeInfoPage(),
        '/process_payament': (_) => const ProcessPaymentPage(),
        '/charges': (_) => const ChargesPage(),
      },
    );
  }
}
