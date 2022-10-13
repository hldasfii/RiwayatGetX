import 'package:get/get.dart';
import 'package:getx_riwayat/screens/getx_riwayat.dart';
part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => GetXRiwayat(),
    ),
  ];
}