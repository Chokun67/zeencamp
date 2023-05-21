import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zeencamp/application/storeService/storeservice.dart';
import 'package:zeencamp/domain/detailshopdm.dart';
import 'package:zeencamp/domain/pvd_data.dart';

class test extends StatefulWidget {
  const test({Key? key, required this.idshop, required this.nameshop})
      : super(key: key);
  final String idshop;
  final String nameshop;
  @override
  _testState createState() => _testState();
}

class _testState extends State<test> {
  late Future<Customer> _customerFuture;
  var idshop;
  var nameshop;
  var token;
  @override
  void initState() {
    idshop = widget.idshop;
    nameshop = widget.nameshop;
    token = context.read<AppData>().token;
    super.initState();
    _customerFuture = StoresService().fetchStoreData(token, idshop);
    print(_customerFuture);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your App'),
      ),
      body: FutureBuilder<Customer>(
        future: _customerFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final customer = snapshot.data!;
            return Column(
              children: [
                Image.network(customer.storePicture),
                Expanded(
                  child: buildMenuList(customer.menuStores),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Widget buildMenuList(List<Store> menuStores) {
    return ListView.builder(
      itemCount: menuStores.length,
      itemBuilder: (context, index) {
        final store = menuStores[index];
        return ListTile(
          leading: Image.network(store.pictures),
          title: Text(store.nameMenu),
        );
      },
    );
  }
}
