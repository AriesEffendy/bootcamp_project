import 'package:bootcamp_project/view/main/Latihan_soal/home_page.dart';
import 'package:bootcamp_project/view/main/Latihan_soal/paket_soal_page.dart';
import 'package:flutter/material.dart';

class MapelPage extends StatefulWidget {
  const MapelPage({super.key});
  static String route = "mapel_page";

  @override
  State<MapelPage> createState() => _MapelPageState();
}

class _MapelPageState extends State<MapelPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pilih Mata Pelajaran"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
        child: ListView.builder(itemBuilder: (context, index) {
          return GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(PaketSoalPage.route);
              },
              child: MapelWidget());
        }),
      ),
    );
  }
}
