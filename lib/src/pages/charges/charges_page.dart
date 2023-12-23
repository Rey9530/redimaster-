import 'package:credimaster/src/delegate/payments_search_deletgate.dart';
import 'package:credimaster/src/pages/charges/widgets/payments_late_widgetr.dart'; 
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ChargesPage extends StatefulWidget {
  const ChargesPage({super.key});

  @override
  State<ChargesPage> createState() => _ChargesPageState();
}

class _ChargesPageState extends State<ChargesPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: SearchPaymentsDelegate(),
                );
              },
            )
          ],
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Icon(FontAwesomeIcons.calendarDay),
                text: "En mora",
              ),
              Tab(icon: Icon(FontAwesomeIcons.calendarDay), text: "Hoy"),
              Tab(icon: Icon(FontAwesomeIcons.calendarDay), text: "Todos"),
            ],
          ),
          title: const Text('Cobros'),
        ),
        body:   TabBarView(
          children: [
            PaymentLaterWidget(type: 'late',),
            PaymentLaterWidget(type: 'today',), 
            PaymentLaterWidget(type: 'all',), 
          ],
        ),
      ),
    );
  }
}
