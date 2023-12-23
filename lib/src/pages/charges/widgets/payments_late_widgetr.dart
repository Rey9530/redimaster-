// ignore_for_file: must_be_immutable

import 'package:credimaster/src/pages/home/widgets/home_payament_widget.dart';
import 'package:credimaster/src/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaymentLaterWidget extends StatelessWidget {
  PaymentLaterWidget({
    super.key,
    required this.type,
  });
  String type;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CustomerProvide>(context, listen: false);
    return FutureBuilder(
      future: provider.getNextPaymentsFirst(type, 1),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return BodyPaymentsLater(
            type: type,
          );
        }
        return const SizedBox();
      },
    );
  }
}

class BodyPaymentsLater extends StatefulWidget {
  BodyPaymentsLater({
    super.key,
    required this.type,
  });
  String type;
  @override
  State<BodyPaymentsLater> createState() => _BodyPaymentsLaterState();
}

class _BodyPaymentsLaterState extends State<BodyPaymentsLater> {
  ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    _controller.addListener(_onScroll);
  }

  _onScroll() async {
    var maxScroll = _controller.position.maxScrollExtent - 100;
    var scroll = _controller.position.pixels; 
    if (scroll > maxScroll) {
      final provider = Provider.of<CustomerProvide>(context, listen: false);
      if (!provider.loading) {
        await provider.getNextPayments(widget.type);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CustomerProvide>(context);
    return RefreshIndicator(
      onRefresh: () async {
        await provider.getNextPayments(widget.type);
        await Future.delayed(const Duration(seconds: 2));
      },
      child: SingleChildScrollView(
        controller: _controller,
        child: Column(
          children: [
            for (var p in provider.listPayments)
              HomePaymentWidget( 
                  onTap: () {
                    provider.payment = p;
                    Navigator.pushNamed(
                      context,
                      '/charge',
                    );
                  },
                customer: p.cliente,
                balance: p.totalSaldo,
                mount: p.monto,
                arrears: double.parse(p.mora.toString()),
              ),
            if (provider.loading)
              const Center(child: CircularProgressIndicator()),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
