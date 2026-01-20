import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:google_fonts/google_fonts.dart';

class Prc624PartsScreen extends StatefulWidget {
  const Prc624PartsScreen({super.key});

  @override
  State<Prc624PartsScreen> createState() => _Prc624PartsScreenState();
}

class _Prc624PartsScreenState extends State<Prc624PartsScreen> {
  // ✅ 1. ฐานข้อมูล (ใช้ลิ้งก์เต็มๆ เท่านั้น)
  final String _gh3DBase =
      "https://saisansan11.github.io/military_sim_2026/assets/assets/models/";

  // ✅ 2. รายชื่อไฟล์ (ใส่แค่ชื่อไฟล์พอ ไม่ต้องมี assets/ นำหน้า)
  final List<Map<String, dynamic>> parts = [
    {'id': 'FULL', 'name': 'AN/PRC-624 (FULL)', 'file': 'prc624.glb'},
    {'id': 'RT-624', 'name': 'Receiver-Transmitter', 'file': 'body.glb'},
    {'id': 'BASE', 'name': 'Antenna Base', 'file': 'antenna_base.glb'},
    {'id': 'WHIP', 'name': 'Antenna Whip', 'file': 'antenna_whip.glb'},
    {'id': 'BATT', 'name': 'Battery (BA-624)', 'file': 'battery.glb'},
  ];

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    // ✅ 3. สร้าง URL โดยเอาฐานข้อมูล + ชื่อไฟล์
    String currentModelUrl = "$_gh3DBase${parts[selectedIndex]['file']}";

    // Debug: ปริ้นดูว่า URL ที่ได้คืออะไร
    debugPrint("LOADING 3D URL: $currentModelUrl");

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          "PART INSPECTION",
          style: GoogleFonts.blackOpsOne(color: const Color(0xFF00FF41)),
        ),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Color(0xFF00FF41)),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[800]!),
                borderRadius: BorderRadius.circular(12),
                color: Colors.black,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: ModelViewer(
                  key: ValueKey(
                    currentModelUrl,
                  ), // บังคับโหลดใหม่เมื่อเปลี่ยนไฟล์
                  src: currentModelUrl, // ใส่ URL เต็ม
                  alt: "3D Model",
                  ar: true,
                  autoRotate: true,
                  cameraControls: true,
                  backgroundColor: Colors.transparent,
                ),
              ),
            ),
          ),
          // ส่วนปุ่มกดด้านล่าง
          Expanded(
            flex: 1,
            child: Container(
              color: const Color(0xFF1E1E1E),
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.all(10),
                children: parts.asMap().entries.map((entry) {
                  int idx = entry.key;
                  bool isSel = idx == selectedIndex;
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ChoiceChip(
                      label: Text(
                        entry.value['id'],
                        style: GoogleFonts.blackOpsOne(),
                      ),
                      selected: isSel,
                      selectedColor: const Color(0xFF00FF41),
                      onSelected: (val) {
                        if (val) setState(() => selectedIndex = idx);
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
