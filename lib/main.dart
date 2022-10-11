import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:getx_riwayat/routes/app_pages.dart';

void main() {
  runApp(GetMaterialApp(
    title: "Aplication",
    initialRoute:AppPages.INITIAL,
    getPages: AppPages.routes,
    debugShowCheckedModeBanner: false,
  ));
}

