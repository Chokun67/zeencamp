import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zeencamp/application/storeService/storeservice.dart';
import 'package:zeencamp/domain/detailshopdm.dart';

import '../domain/pvd_data.dart';

class Shopdetail extends StatelessWidget {
  const Shopdetail({Key? key, required this.idshop, required this.nameshop})
      : super(key: key);

  final String idshop;
  final String nameshop;

  @override
  Widget build(BuildContext context) {
    final heightsize = MediaQuery.of(context).size.height;
    final widthsize = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<Customer>(
          future: StoresService().fetchStoreData(context.read<AppData>().token, idshop),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('เกิดข้อผิดพลาด: ${snapshot.error}'),
              );
            } else {
              final customerData = snapshot.data!;

              return Stack(
                children: [
                  Container(
                    width: widthsize,
                    height: heightsize,
                    decoration: const BoxDecoration(color: Colors.greenAccent),
                  ),
                  Container(
                    width: widthsize,
                    height: heightsize * 0.45,
                    decoration: const BoxDecoration(color: Colors.amber),
                    child: Image.network(
                      'http://10.32.69.1:5000/api/v1/image/${customerData.storePicture}',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: heightsize * 0.28,
                    child: Container(
                      width: widthsize,
                      height: heightsize,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(90)),
                        color: Color(0xFF4A4A4A),
                      ),
                      child: Column(
                        children: [
                          positionShop(widthsize, heightsize, nameshop, idshop),
                          detailMenu(widthsize, heightsize, context, customerData.menuStores),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: widthsize * 0.077,
                    left: widthsize * 0.077,
                    child: InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Image.asset('images/back.png'),
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Widget positionShop(double widthsize, double heightsize, String nameshop, String idshop) {
    return Container(
      margin: EdgeInsets.only(top: widthsize * 0.1, left: widthsize * 0.1),
      height: heightsize * 0.085,
      width: widthsize * 0.8,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Color(0xFFFFD600),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              SizedBox(
                height: heightsize * 0.02,
              ),
              SizedBox(
                width: widthsize * 0.12,
                child: Container(
                  height: widthsize * 0.06,
                  decoration: const BoxDecoration(
                    color: Color(0xFF4A4A4A),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            width: widthsize * 0.48,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "ร้าน $nameshop",
                  style: TextStyle(
                    fontSize: heightsize * 0.03,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "id $idshop",
                  style: TextStyle(
                    fontSize: heightsize * 0.02,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              SizedBox(
                height: heightsize * 0.05,
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.location_pin),
                  iconSize: widthsize * 0.08,
                ),
              ),
              Text(
                "Location",
                style: TextStyle(
                  fontSize: heightsize * 0.018,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget detailMenu(double widthsize, double heightsize, BuildContext context, List<Store>? menuStores) {
    return Container(
      margin: EdgeInsets.only(top: heightsize * 0.02),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        color: const Color(0xFFFFD600),
        border: Border.all(color: const Color(0xFFAD6800), width: 5),
      ),
      height: heightsize * 0.5,
      width: widthsize * 0.8,
      child: SingleChildScrollView(
        child: Column(
          children: List.generate(menuStores?.length ?? 0, (index) {
            final menuStore = menuStores?[index];
            return Container(
              margin: EdgeInsets.only(bottom: heightsize * 0.01),
              color: Colors.amber,
              height: heightsize * 0.12,
              child: Row(
                children: [
                  detailPicture(widthsize, heightsize, menuStore?.pictures),
                  SizedBox(
                    width: widthsize * 0.05,
                  ),
                  detailPrice(
                    widthsize,
                    heightsize,
                    menuStore?.nameMenu,
                    menuStore?.price,
                    menuStore?.receive,
                    menuStore?.exchange,
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget detailPicture(double widthsize, double heightsize, String? pictures) {
    return Container(
      width: widthsize * 0.3,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        border: Border.all(color: const Color(0xFF000000), width: 4),
      ),
      child: Image.network(
        'http://10.32.69.1:5000/api/v1/image/$pictures',
        fit: BoxFit.cover,
        // ปรับขนาดภาพให้พอดีกับขนาด Container
      ),
    );
  }

  Widget detailPrice(
    double widthsize,
    double heightsize,
    String? name,
    int? price,
    int? receive,
    int? exchange,
  ) {
    return Container(
      padding: EdgeInsets.all(widthsize * 0.02),
      height: heightsize * 0.2,
      width: widthsize * 0.34,
      decoration: BoxDecoration(
        color: const Color(0xFFFFF09F),
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        border: Border.all(color: const Color(0xFF000000), width: 2),
      ),
      child: Text(
        "$name\nราคา $price บาท\nซื้อแล้วได้รับ $receive P\nใช้ $exchange เพื่อรับฟรี",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: heightsize * 0.02,
        ),
      ),
    );
  }
}
