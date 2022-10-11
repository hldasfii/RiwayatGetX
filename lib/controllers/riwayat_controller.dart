import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import '../models/riwayat_model.dart';


class RiwayatController extends GetxController {
  var listRiwayat = <History>[].obs;
  var isLoading = false.obs;

  Future<void> getRiwayat() async {
    try {
      isLoading(true);
      http.Response response = await http.get(Uri.tryParse('https://demo-service.kemenkeu.go.id/perpustakaan/Sirkulasi/GetAll?PageSize=10&Page=$page&keyword=$keyword',
      headers: {
        'Content-Type' : 'application/json',
        'Accept' : 'application/json',
        'Authorization' : 'Bearer eyJhbGciOiJSUzI1NiIsImtpZCI6IjQyNDc0QTY4NDNBM0VBNTc2MTcyNDE2MTIxMEQ2OTlBMEZFNDQ2Q0EiLCJ0eXAiOiJhdCtqd3QiLCJ4NXQiOiJRa2RLYUVPajZsZGhja0ZoSVExcG1nX2tSc28ifQ.eyJuYmYiOjE2NjMwNjIwNjgsImV4cCI6MTY2MzA4MDA2OCwiaXNzIjoiaHR0cHM6Ly9kZW1vLWFjY291bnQua2VtZW5rZXUuZ28uaWQiLCJhdWQiOlsiZnJvbnRlbmQubmFkaW5lIiwiYWdlbmRhLmVrZW1lbmtldSIsInJhcGF0LmVrZW1lbmtldSIsImtlaGFkaXJhbi5la2VtZW5rZXUiLCJvcmdhbmlzYXNpLmhyaXMiLCJwcm9maWwuaHJpcyIsImphYmF0YW4uaHJpcyIsInBhbmdrYXQuaHJpcyIsImRpa2xhdC5ocmlzIiwia2VsdWFyZ2EuaHJpcyIsInBlbmRpZGlrYW4uaHJpcyIsImVrZW1lbmtldSIsImtvbGFib3Jhc2kuZWtlbWVua2V1IiwicGVnYXdhaS5la2VtZW5rZXUiXSwiY2xpZW50X2lkIjoiZWtlbWVua2V1LW9hLWRldiIsIkVuYWJsZU1GQSI6ImZhbHNlIiwic3ViIjoiMmI3YTNiZGMtMGVmZi00YWIyLWI2YjQtZjYwMTM1ZGRlOTk4IiwiYXV0aF90aW1lIjoxNjYzMDU5NzkwLCJpZHAiOiJsb2NhbCIsIm5hbWUiOiJFcml0YSBZdWxpYXN0dXRpIiwiaWQiOiIxMTUyNzkiLCJhZGRyZXNzIjoiQXB0LiBHYWRpbmcgTmlhcyBSZXNpZGVuY2UgVG93ZXIgQ2hyeXNhbnQgTm8uIEMvMTcvSkQgS2VsYXBhIEdhZGluZyBKYWthcnRhIFV0YXJhIiwicGhvbmVfbnVtYmVyIjoiMDgxMjI3MDc3NDc3IiwibmlwIjoiMTk4NTA3MTMyMDEwMTIyMDAxIiwiamFiYXRhbiI6IlBlbGFrc2FuYSIsImplbmlzX2phYmF0YW4iOiJGdW5nc2lvbmFsIFVtdW0gUE5TIiwia29kZV9vcmdhbmlzYXNpIjoiMzUwMzEwMTgwMiIsIm9yZ2FuaXNhc2kiOiJTdWJiaWRhbmcgUGVyYW5jYW5nYW4gZGFuIFBlbmdlbWJhbmdhbiBBcGxpa2FzaSBJLCBCaWRhbmcgQXBsaWthc2ksIFB1c2F0IFNpc3RlbSBJbmZvcm1hc2kgZGFuIFRla25vbG9naSBLZXVhbmdhbiwgU2VrcmV0YXJpYXQgSmVuZGVyYWwiLCJrb2RlX3NhdGtlciI6IjY3MjkwNiIsInNhdGtlciI6IlB1c2F0IFNpc3RlbSBJbmZvcm1hc2kgZGFuIFRla25vbG9naSBLZXVhbmdhbiIsImdyYXZhdGFyIjoiaHR0cHM6Ly9hY2NvdW50LmtlbWVua2V1LmdvLmlkL21hbmFnZS9VcGxvYWRzL1RodW1ibmFpbHMvMTk4NTA3MTMyMDEwMTIyMDAxLmpwZyIsInByZWZlcnJlZF91c2VybmFtZSI6IjE5ODUwNzEzMjAxMDEyMjAwMSIsImVtYWlsIjoiZXJpdGEueUBrZW1lbmtldS5nby5pZCIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJqdGkiOiJyQ0c2VlJYb0F3eUp0NnRoa2hfWUZRIiwic2NvcGUiOlsib3BlbmlkIiwicHJvZmlsZSIsImZyb250ZW5kLm5hZGluZSIsImFnZW5kYS5la2VtZW5rZXUiLCJyYXBhdC5la2VtZW5rZXUiLCJrZWhhZGlyYW4uZWtlbWVua2V1Iiwib3JnYW5pc2FzaS5ocmlzIiwicHJvZmlsLmhyaXMiLCJqYWJhdGFuLmhyaXMiLCJwYW5na2F0LmhyaXMiLCJkaWtsYXQuaHJpcyIsImtlbHVhcmdhLmhyaXMiLCJwZW5kaWRpa2FuLmhyaXMiLCJla2VtZW5rZXUiLCJrb2xhYm9yYXNpLmVrZW1lbmtldSIsInBlZ2F3YWkuZWtlbWVua2V1Il0sImFtciI6WyJwd2QiXX0.r7c_kqjvYeEaoFpMDNXl4y9rzQ27drxlwc8Qs3lXapMNSC0juClxfC50d2svueLluvr5DjgbOBbTHGa53BSgsk-WyP6pBFH-4hrpJ-sqHC7T0a5_a36yX8q57un6K6_t2mVLZ-xte5kkGzOrU9rRCRH1ld4_XjpoQ2l740yaj9zUnON33u92_xyz2LGx5hkZxbi4AYr6fNuAgspVewH9qw8bmi7f7BFDimdjiIYj4ESyXhdQHLkYZ7klHYwR4V84w2OmQ0-F5hgDxvyPK71-2kttNIud-9bj5TEPEZSH1HEipwXhozaaffmbW3Bh6aXV_fFO-Dbk-qVEr10GzsJshzesRreNOKPdnoF3kT68X8JEraKR0x9mNDfIMZm63mQDs0XTFj1Kuo_uG-mO1e1n8S-d4hRAcGzcM8Hu2PVWC1qMxIpI9uSQRXsmvxKC21wUIC3-K-ME3pKFC4K44-K4A8gYKn76i9YgIRlM_fK69STO_Iz4I7cRsvTZpg_ak58wKTZCp5m4dgH7uyd7c32JsrUiiNd00mIEjRJyvngbqznidmtJpscxtTnq1Nz-1EYpJUfYxjZciEHsjGEOFrUmeE_79aLAgz67S9Mh7OwatMxnog0x8yQg57SxCauGCPhFRits57KkX-qtSN7DzN6WxaeoHcanCCpGJY-3Ul10LBk',
      }
      )!);
      print('konek api');

      if (response.statusCode == 200) {
        Map result = jsonDecode(response.body);
        print('data riwayat');

        List<dynamic> listDyn = result[''];

        List<History> listRiwayat = [];
        listDyn.forEach((element) {
          listRiwayat.add(History.fromJson(element));
        });
        this.listRiwayat.value = listRiwayat;
        this.listRiwayat.refresh();
        print('sampai sini');
        print('terbaca');
      } else {}
    } finally{
      isLoading(false);
    }
  }
}
