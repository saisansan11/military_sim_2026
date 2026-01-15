import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

class Prc710DetailScreen extends StatefulWidget {
  const Prc710DetailScreen({super.key});
  @override
  State<Prc710DetailScreen> createState() => _Prc710DetailScreenState();
}

class _Prc710DetailScreenState extends State<Prc710DetailScreen> {
  // ข้อมูลอ้างอิงจากคู่มือ PRC-710G ที่ผู้หมวดส่งให้
  final List<Map<String, String>> specs = [
    {
      "name": "AN/PRC-710 (RT-710G)",
      "file":
          "assets/models/prc624.glb", // 🛠️ ใช้ไฟล์ที่มีอยู่จริงเพื่อกันแอปเด้ง
      "desc":
          "คุณลักษณะทางเทคนิค:\n"
          "• ย่านความถี่: 30.000 - 87.975 MHz [cite: 25]\n"
          "• ช่องติดต่อ: 2,320 ช่อง (ห่างกัน 25 KHz) [cite: 26]\n"
          "• กำลังส่ง: Low (1W), Mid (2W), Hi (5W) [cite: 28, 29, 30]\n"
          "• โหมดใช้งาน: CLR, SEC และ A.J. (Hopping) [cite: 31]\n"
          "• น้ำหนักเครื่อง: ประมาณ 750 กรัม [cite: 11]",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          "PRC-710 DETAILS",
          style: GoogleFonts.blackOpsOne(color: const Color(0xFF00FF41)),
        ),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: ModelViewer(
              src: specs[0]['file']!,
              autoRotate: true,
              cameraControls: true,
              backgroundColor: Colors.transparent,
            ),
          ),
          Expanded(
            flex: 6,
            child: Container(
              padding: const EdgeInsets.all(20),
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFF1E1E1E),
                border: Border(
                  top: BorderSide(color: Color(0xFF00FF41), width: 2),
                ),
              ),
              child: SingleChildScrollView(
                child: Text(
                  specs[0]['desc']!,
                  style: GoogleFonts.sarabun(
                    color: Colors.white,
                    fontSize: 16,
                    height: 1.6,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
