import 'package:credimaster/src/delegate/custom_search_deletgate.dart';
import 'package:credimaster/src/pages/charges/widgets/payments_late_widgetr.dart';
import 'package:credimaster/src/pages/home/widgets/appscafoold_widget.dart';
import 'package:credimaster/src/pages/home/widgets/home_menu_widget.dart'; 
import 'package:credimaster/src/pages/home/widgets/home_search_widget.dart';
import 'package:credimaster/src/pages/home/widgets/home_user_widget.dart';
import 'package:credimaster/src/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AuthProvide>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text("CrediMaster"),
        actions: [
          if (
              // provider.userModel!.idUser < 0 &&
              provider.userModel!.roll == 1) ...[
            IconButton(
              icon: CircleAvatar(
                backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
                child: const FaIcon(
                  Icons.dashboard,
                  size: 16,
                  color: Colors.white,
                ),
              ),
              onPressed: () => Navigator.pushNamed(context, '/admin'),
            ),
          ],
          IconButton(
            icon: CircleAvatar(
              backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
              child: const FaIcon(
                FontAwesomeIcons.userLarge,
                size: 16,
                color: Colors.white,
              ),
            ),
            onPressed: () => Navigator.pushNamed(context, '/profile'),
          )
        ],
      ),
      body:const BodyHomeWidget(),
    );
  }
}

class BodyHomeWidget extends StatelessWidget {
  const BodyHomeWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // final provider = Provider.of<CustomerProvide>(context, listen: false);
    final userPro = Provider.of<AuthProvide>(context, listen: false);
    return AppScaffold(
      title: '',
      slivers: [
        SliverStickyHeader(
          header: Container(),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, i) => HomeUserWidget(
                userName: userPro.userModel?.name ?? "Nombre de usuario",
              ),
              childCount: 1,
            ),
          ),
        ),
        SliverStickyHeader(
          header: Container(
            color: Theme.of(context).appBarTheme.backgroundColor,
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  HomeSearchWidget(
                    onTap: () => showSearch(
                      context: context,
                      delegate: SearchCustomersDelegate(),
                    ),
                  ),
                  const HomeMenuWidget()
                ],
              ),
            ),
          ),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, i) => PaymentLaterWidget(
                type: 'today',
              ),
              childCount: 1,
            ),
          ),
        )
      ],
    );
  }
}
