import 'package:flutter/material.dart';
import 'package:zeencamp/application/storeService/storeservice.dart';
import 'package:zeencamp/background.dart';
import '../../domain/dmstore/allstore.dart';
import '../../securestorage.dart';
import 'shopdetail.dart';

class SearchShop extends StatefulWidget {
  const SearchShop({
    Key? key,
    required this.category,
  }) : super(key: key);
  final int category;

  @override
  State<SearchShop> createState() => _SearchShopState();
}

class _SearchShopState extends State<SearchShop> {
  List<Allstore> stores = [];
  List<Allstore> filteredList = [];
  var token = "";
  @override
  initState() {
    super.initState();
    fetchData();
    // token = context.read<AppData>().token;
    // List<Allstore> stores = await getStores(token);
  }

  void fetchData() async {
    int category = widget.category;
    token = await SecureStorage().read("token") as String;
    // List<Allstore> fetchedStores = await StoresService().getStores(token);
    late List<Allstore> fetchedStores;
    if (category > 0) {
      fetchedStores = await StoresService().getmenucategory(token, category);
    } else {
      fetchedStores = await StoresService().getStores(token);
    }
    setState(() {
      stores = fetchedStores;
    });
  }

  void filterData(String query) {
    setState(() {
      filteredList = stores
          .where(
              (store) => store.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  final _ctrlSearch = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    final heightsize = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.vertical;
    final widthsize = MediaQuery.of(context).size.width;
    
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            width: widthsize,
            height: heightsize,
            color: const Color(0xFF4A4A4A),
            child: Stack(
              children: [
                Column(
                  children: [
                    MyStyle().buildBackground(
                        widthsize, heightsize, context, "ร้านค้า"),
                    fieldSearchType(widthsize, heightsize),
                    Container(
                        color: const Color(0xFF4A4A4A),
                        width: widthsize,
                        height:
                            heightsize - heightsize * 0.284 - heightsize * 0.15,
                        child: shopName(widthsize, heightsize, context)),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget fieldSearchType(widthsize, heightsize) => Container(
        margin:
            EdgeInsets.only(top: heightsize * 0.06, bottom: heightsize * 0.06),
        width: widthsize * 0.8,
        height: heightsize * 0.06,
        child: TextField(
          onChanged: (value) => filterData(value),
          controller: _ctrlSearch,
          decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Color(0xFFAD6800), width: 1),
                  borderRadius: BorderRadius.circular(10)),
              fillColor: const Color(0xFFFFFFFF),
              filled: true,
              hintText: "search"),
        ),
      );

  Widget shopName(widthsize, heightsize, context) => SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              itemCount: _ctrlSearch.text.isEmpty
                  ? stores.length
                  : filteredList.length,
              padding: EdgeInsets.all(widthsize * 0.04),
              physics: const ScrollPhysics(parent: null),
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                List<Allstore> displayList = _ctrlSearch.text.isEmpty
      ? stores
      : filteredList;
                return InkWell(
                  onTap: () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Shopdetail(
                                  idshop: displayList[index].id,
                                  nameshop: displayList[index].name,
                                )))
                  },
                  child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        color: Color(0xFFFFFFFF),
                      ),
                      margin: EdgeInsets.only(bottom: widthsize * 0.025),
                      padding: EdgeInsets.all(widthsize * 0.04),
                      // width: widthsize * 0.87,
                      height: heightsize * 0.13,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "ร้าน ${displayList[index].name}",
                            style: TextStyle(
                                color: const Color(0xFFEB3F3F),
                                fontSize: heightsize * 0.032,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "id ${displayList[index].id}",
                            style: TextStyle(
                                color: const Color(0xFFEB3F3F),
                                fontSize: heightsize * 0.022,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      )),
                );
              },
            ),
          ],
        ),
      );
}
