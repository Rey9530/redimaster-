import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:credimaster/src/models/models.dart';
import 'package:credimaster/src/pages/home/widgets/home_payament_widget.dart';
import 'package:credimaster/src/providers/providers.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class SearchPaymentsDelegate extends SearchDelegate {
  SearchPaymentsDelegate()
      : super(
            searchFieldLabel: "Buscar cliente",
            searchFieldStyle: const TextStyle(color: Colors.white));

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
      inputDecorationTheme: const InputDecorationTheme(
        hintStyle: TextStyle(color: Colors.white),
        labelStyle: TextStyle(color: Colors.white),
        border: InputBorder.none,
      ),
      primaryIconTheme: theme.primaryIconTheme,
      primaryTextTheme: theme.primaryTextTheme,
    );
  }

  StreamController<bool> isLoadingStream = StreamController.broadcast();
  @override
  List<Widget> buildActions(BuildContext context) {
    // Son las acciones de nuestro appbar
    return [
      StreamBuilder(
        initialData: false,
        stream: isLoadingStream.stream,
        builder: (context, snapshot) {
          if (snapshot.data ?? false) {
            return SpinPerfect(
              duration: const Duration(seconds: 20),
              spins: 10,
              infinite: true,
              child: IconButton(
                  onPressed: () => query = '',
                  icon: const Icon(Icons.refresh_rounded)),
            );
          }

          return FadeIn(
            animate: query.isNotEmpty,
            child: IconButton(
                onPressed: () => query = '', icon: const Icon(Icons.clear)),
          );
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Son los inconos que aparesen a la izquierda
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Crea los resultados que vamos a mostrar
    return Container();
  }

  Widget buildResultsAndSuggestions() {
    return StreamBuilder(
      initialData: const [],
      stream: debouncedCustomer.stream,
      builder: (context, snapshot) {
        final customer = snapshot.data ?? [];
        final provider = Provider.of<CustomerProvide>(context, listen: false);
        return ListView(
          children: customer.map((p) {
            return Column(
              children: [
                HomePaymentWidget(
                  customer: p.cliente,
                  balance: p.totalSaldo,
                  mount: p.monto,
                  arrears: double.parse(p.mora.toString()),
                  onTap: () {
                    provider.payment = p;
                    Navigator.pushNamed(
                      context,
                      '/charge',
                    );
                  },
                ),
                const Divider(),
              ],
            );
          }).toList(),
        );
      },
    );
  }

  void clearStreams() {
    debouncedCustomer.close();
  }

  Timer? _debounceTimer;
  StreamController<List<Pago>> debouncedCustomer = StreamController.broadcast();

  @override
  Widget buildSuggestions(BuildContext context) {
    isLoadingStream.add(true);
    final provider = Provider.of<CustomerProvide>(context, listen: false);
    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();
    List<Pago> customers = [];
    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      if (query.isEmpty) {
        customers = [];
        isLoadingStream.add(false);
        return;
      }
      String newQuery = query.replaceAll(' ', '_');
      customers = await provider.searchpayments(newQuery);
      debouncedCustomer.add(customers);
      isLoadingStream.add(false);
    });
    // Son las sujerencias que aparecen cuando la persona escribe
    // if (customers.isEmpty) {
    //   return Container();
    // }

    return buildResultsAndSuggestions();
  }
}
