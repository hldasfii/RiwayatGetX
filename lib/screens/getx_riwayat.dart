import 'package:getx_riwayat/controllers/riwayat_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_riwayat/models/riwayat_model.dart';

import '../widgets/card_riwayat.dart';

class GetXRiwayat extends StatelessWidget {
  const GetXRiwayat({Key? key}) : super(key: key);

 @override
  Widget build(BuildContext context) {
    RiwayatController c = Get.put(RiwayatController());

    // c.getKatalog;
    // c.getPage;

    return Scaffold(
        appBar: AppBar(
          title: Obx(() => Text("Getx beranda ${c.listRiwayat.value.length}")),
          actions: [
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                // BerandaController.getListBukuTerbaru();
                c.fetch(c.page, '');
              },
            )
          ],
        ),
        body: Container(
          child: Obx(() {
            if (c.isLoading.value) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            if (c.listRiwayat.value.isNotEmpty) {
              return Container(
                child: ScrollConfiguration(
                    behavior: ScrollConfiguration.of(context)
                        .copyWith(scrollbars: false),
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.all(15),
                          height: 50,
                          child: TextField(
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.search),
                                hintText: 'Judul Buku / Abstrak',
                                hintStyle: TextStyle(fontSize: 15),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide:
                                        BorderSide(color: Colors.white))),
                            controller: c.InputController,
                            onSubmitted: (text) {
                              c.listRiwayat.clear();
                              c.page = 1;
                              c.keyword = text;
                              c.fetch(c.page, c.keyword);

                              print('search oke');
                            },
                          ),
                        ),
                        Expanded(
                            child: Container(
                          child: ScrollConfiguration(
                            behavior: ScrollConfiguration.of(context)
                                .copyWith(scrollbars: false),
                            child: Obx(() => ListView.builder(
                                controller: c.scrollcontroller.value,
                                shrinkWrap: true,
                                padding: EdgeInsets.only(left: 10, right: 10),
                                itemBuilder: (context, int index) {
                                  return RiwayatCard(
                                    iniRiwayat: c.listRiwayat.value[index],
                                  );
                                },
                                itemCount: c.listRiwayat.value.length)),
                          ),
                        ))
                      ],
                    )),
              );
            }

            return Container(
              child: Center(
                child: Text('Data gakebaca'),
              ),
            );
          }),
        ));
  }
}