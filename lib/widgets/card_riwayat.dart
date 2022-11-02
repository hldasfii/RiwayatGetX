import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_riwayat/controllers/riwayat_controller.dart';
import 'package:getx_riwayat/models/riwayat_model.dart';
import 'package:jiffy/jiffy.dart';


class RiwayatCard extends StatelessWidget {
  RiwayatCard({Key? key, this.iniRiwayat,}) : super(key: key);
  History? iniRiwayat;

  @override
  Widget build(BuildContext context) {
    RiwayatController c = Get.find();
    return Container(
      padding: EdgeInsets.fromLTRB(14, 4, 14, 4),
      child: Card(
        elevation: 15,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        child: Container(
          decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(3, 3),
                    spreadRadius: 3,
                    blurRadius: 5,
                    color: Colors.grey.withOpacity(0.5),
                  ),
                ],
              ),
            width: 200,
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Container(
                    child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          '${iniRiwayat?.judulBuku}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  )),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          '${iniRiwayat?.namaPengarang}',
                          style: TextStyle(fontSize: 15),
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Tanggal Pinjam: ${Jiffy(iniRiwayat?.tanggalPinjam).yMMMEdjm}',
                          style: TextStyle(fontSize: 15),
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.ellipsis,
                          
                        ) ,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Tanggal Kembali: ${Jiffy(iniRiwayat?.tanggalKembali).yMMMEdjm}',
                          style: TextStyle(fontSize: 15),
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Icon(
                      Icons.location_on,
                      size: 20,
                      color: Colors.grey,
                    ),
                    Expanded(child: Text('${iniRiwayat?.lokasi}')),
                  ]),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                    
                  ],
                )
              ],
            )),
      ),
    );
  }
}