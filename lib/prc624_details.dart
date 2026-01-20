import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:google_fonts/google_fonts.dart';

class Prc624DetailScreen extends StatefulWidget {
  const Prc624DetailScreen({super.key});

  @override
  State<Prc624DetailScreen> createState() => _Prc624DetailScreenState();
}

class _Prc624DetailScreenState extends State<Prc624DetailScreen> {
  // ✅ 3D Model Path (ถูกต้อง)
  final String _gh3DBase =
      "https://saisansan11.github.io/military_sim_2026/assets/assets/models/";

  final List<Map<String, dynamic>> parts = [
    {'id': 'FULL', 'name': 'AN/PRC-624 (FULL SYSTEM)', 'file': 'prc624.glb'},
    {'id': 'RT-624', 'name': 'Receiver-Transmitter', 'file': 'body.glb'},
    {
      'id': 'ANTENNA',
      'name': 'Antenna System',
      'file': 'antenna_whip.glb',
    }, // รวมเสาและฐาน
    {'id': 'BATTERY', 'name': 'Battery Pack (BA-624)', 'file': 'battery.glb'},
  ];

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    String currentModelUrl = "$_gh3DBase${parts[selectedIndex]['file']}";

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          "SPECIFICATIONS & 3D",
          style: GoogleFonts.blackOpsOne(color: const Color(0xFF00FF41)),
        ),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Color(0xFF00FF41)),
      ),
      body: Column(
        children: [
          // --- ส่วนแสดงผล 3D (60% ของหน้าจอ) ---
          Expanded(
            flex: 6,
            child: Container(
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[800]!),
                borderRadius: BorderRadius.circular(12),
                color: Colors.black,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF00FF41).withOpacity(0.1),
                    blurRadius: 10,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Stack(
                  children: [
                    ModelViewer(
                      key: ValueKey(currentModelUrl),
                      src: currentModelUrl,
                      alt: "3D Model",
                      ar: true,
                      autoRotate: true,
                      cameraControls: true,
                      backgroundColor: Colors.transparent,
                      loading: Loading.eager,
                    ),
                    // ป้ายชื่อชิ้นส่วนมุมขวาบน
                    Positioned(
                      top: 10,
                      right: 10,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.7),
                          border: Border.all(color: const Color(0xFF00FF41)),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          parts[selectedIndex]['name'],
                          style: GoogleFonts.blackOpsOne(
                            color: const Color(0xFF00FF41),
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // --- ส่วนข้อมูล (40% ของหน้าจอ) ---
          Expanded(
            flex: 4,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Color(0xFF1E1E1E),
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black54,
                    blurRadius: 10,
                    offset: Offset(0, -5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // หัวข้อ
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "TECHNICAL DATA",
                        style: GoogleFonts.blackOpsOne(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      Icon(Icons.data_usage, color: const Color(0xFF00FF41)),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // กล่องข้อความสเปค (Scrollable)
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey[800]!),
                      ),
                      child: SingleChildScrollView(
                        child: Text(
                          _getFullSpecText(parts[selectedIndex]['id']),
                          style: GoogleFonts.sarabun(
                            color: const Color(0xFF00FF41),
                            fontSize: 14,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),

                  // ปุ่มเลือกชิ้นส่วน
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: parts.asMap().entries.map((entry) {
                        int idx = entry.key;
                        return Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: ChoiceChip(
                            label: Text(
                              entry.value['id'],
                              style: GoogleFonts.blackOpsOne(),
                            ),
                            selected: idx == selectedIndex,
                            selectedColor: const Color(0xFF00FF41),
                            backgroundColor: const Color(0xFF333333),
                            labelStyle: TextStyle(
                              color: idx == selectedIndex
                                  ? Colors.black
                                  : Colors.white,
                            ),
                            onSelected: (val) {
                              if (val) setState(() => selectedIndex = idx);
                            },
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ข้อมูลสเปคแบบเต็ม (ตามภาพที่ผู้หมวดเคยส่งมา)
  String _getFullSpecText(String id) {
    switch (id) {
      case 'FULL':
        return """• ประเภท: วิทยุรับ-ส่ง มือถือ ย่าน VHF/FM
• ย่านความถี่: 30.000 - 87.975 MHz
• จำนวนช่อง: 2,320 ช่อง (ระยะห่าง 25 kHz)
• กำลังส่ง: High (2 วัตต์) / Low (1 วัตต์)
• ระยะหวังผล: 3-5 กม. (ขึ้นอยู่กับภูมิประเทศ)
• น้ำหนัก: ประมาณ 960 กรัม (รวมแบตเตอรี่)
• อุณหภูมิใช้งาน: -20°C ถึง +60°C""";
      case 'RT-624':
        return """• รุ่น: Receiver-Transmitter RT-624
• ระบบป้องกัน: กันน้ำลึก 1 เมตร (30 นาที)
• จอแสดงผล: LCD พร้อมไฟ Backlight (สีเขียว)
• การควบคุม: ปุ่มกดหน้าเครื่อง 4 ปุ่ม
• การเชื่อมต่อ: ขั้วต่อเสาอากาศแบบ TNC, ขั้วต่อ Audio 6-pin""";
      case 'ANTENNA':
        return """• ประเภท: เสาอากาศยาง (Flexible Whip)
• ความยาว: ประมาณ 1.2 เมตร
• ย่านความถี่: Broadband 30-88 MHz
• ขั้วต่อ: TNC Type (เกลียว)
• Matching Unit: ฐานเสาแบบมีวงจรแมทชิ่งในตัว""";
      case 'BATTERY':
        return """• รุ่น: BA-624 (แบตเตอรี่แพ็ค)
• ชนิด: Nickel-Cadmium (Ni-Cd) หรือ Li-ion
• แรงดันไฟ: 7.4 VDC
• ความจุ: ใช้งานต่อเนื่องได้นานกว่า 10 ชั่วโมง (อัตราส่วน 1:1:8)
• การชาร์จ: รองรับแท่นชาร์จเร็ว""";
      default:
        return "N/A";
    }
  }
}
