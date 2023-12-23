import 'package:credimaster/src/delegate/custom_search_deletgate.dart';
import 'package:credimaster/src/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class CustomersPage extends StatelessWidget {
  const CustomersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CustomerProvide>(context, listen: false);
    return FutureBuilder(
      future: provider.getCustomers(1),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return const BodyCustomersWidget();
        }
        return const SizedBox();
      },
    );
  }
}

class BodyCustomersWidget extends StatefulWidget {
  const BodyCustomersWidget({
    super.key,
  });

  @override
  State<BodyCustomersWidget> createState() => _BodyCustomersWidgetState();
}

class _BodyCustomersWidgetState extends State<BodyCustomersWidget> {
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
        await provider.getCustomers(null, true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CustomerProvide>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Clientes"),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => showSearch(
              context: context,
              delegate: SearchCustomersDelegate(),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, "/add/customer"),
        child: const Icon(FontAwesomeIcons.userPlus, color: Colors.white),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await provider.getCustomers(1, true);
          await Future.delayed(const Duration(seconds: 2));
        },
        child: ListView(
          controller: _controller,
          children: [
            for (var item in provider.customers)
              Column(
                children: [
                  ListTile(
                    onTap: () {
                      provider.customer = item;
                      Navigator.pushNamed(
                        context,
                        '/customer',
                      );
                    },
                    leading: Hero(
                      tag: item.idCliente,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(360),
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(360),
                          ), //TODO: DESCOMENTAR ESTOOO
                          // child: CachedNetworkImage(
                          //   fit: BoxFit.cover,
                          //   imageUrl: item.imagen,
                          //   errorWidget: (context, url, error) => const Center(
                          //     child: FaIcon(
                          //       FontAwesomeIcons.userLarge,
                          //       color: Colors.white,
                          //     ),
                          //   ),
                          // ),
                        ),
                      ),
                    ),
                    title: Text(item.nombre),
                    subtitle: Text(item.direccion),
                  ),
                  const Divider(),
                ],
              ),
            if (provider.loading)
              const Center(child: CircularProgressIndicator()),
            const SizedBox(height: 10),
          ],

          //  provider.customers.map((item) {
          //   return ;
          // }).toList(),
        ),
      ),
    );
  }
}
