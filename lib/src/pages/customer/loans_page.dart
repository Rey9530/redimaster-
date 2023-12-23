import 'package:credimaster/src/models/models.dart';
import 'package:credimaster/src/pages/customer/widget/loan_widget.dart';
import 'package:credimaster/src/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoadPage extends StatelessWidget {
  const LoadPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CustomerProvide>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text("PRESTAMOS"),
      ),
      body: FutureBuilder(
        future: provider.getLoans(),
        builder: (BuildContext context, AsyncSnapshot<List<Pago>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!snapshot.hasData) {
              return const Center(child: Text("No hay prestamos disponibles"));
          }
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: snapshot.data!.map((l) => LoanWidget(loan: l)).toList(),
                ),
              ),
            );
        },
      ),
    );
  }
}
