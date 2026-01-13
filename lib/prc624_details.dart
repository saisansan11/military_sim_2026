import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

class Prc624DetailScreen extends StatefulWidget {
  const Prc624DetailScreen({super.key});

  @override
  State<Prc624DetailScreen> createState() => _Prc624DetailScreenState();
}

class _Prc624DetailScreenState extends State<Prc624DetailScreen> {
  // --- ระบบบันทึกสถานะการตรวจสอบ (Pass/Fail) ---
  final Map<String, bool?> inspectionStatus = {
    "full": null,
    "body": null,
    "antenna_base": null,
    "antenna_whip": null,
    "battery": null,
  };

  final List<Map<String, String>> parts = [
    {
      "id": "full",
      "name": "AN/PRC-624 (FULL)",
      "file": "assets/models/prc624.glb",
      "desc":
          "ข้อมูลทางเทคนิค (Technical Specifications):\n"
          "• ประเภท: วิทยุรับ-ส่ง มือถือ ย่าน VHF/FM\n"
          "• ย่านความถี่: 30.000 - 87.975 MHz\n"
          "• จำนวนช่อง: 2,320 ช่อง (ระยะห่าง 25 kHz)\n"
          "• กำลังส่ง: High (2 วัตต์) / Low (1 วัตต์)\n"
          "• ระยะหวังผล: 3-5 กม. (ขึ้นอยู่กับภูมิประเทศ)\n"
          "• น้ำหนัก: ประมาณ 960 กรัม (รวมแบตเตอรี่)",
    },
    {
      "id": "body",
      "name": "TRANSCEIVER RT-624",
      "file": "assets/models/body.glb",
      "desc":
          "ตัวเครื่องรับ-ส่ง (Receiver-Transmitter):\n"
          "• หน้าจอ: LCD แสดงความถี่ 5 หลัก พร้อมไฟ Night Light\n"
          "• ปุ่มควบคุม: VOL/OFF (เปิด-ปิด), CHANNEL (เลือกช่อง)\n"
          "• ระบบพิเศษ: มีระบบ Whisper (กระซิบ) และ Lock Keypad\n"
          "• ขั้วต่อ Audio: แบบ 5-pin (U-229/U) สำหรับ H-250",
    },
    {
      "id": "antenna_base",
      "name": "ANTENNA BASE",
      "file": "assets/models/antenna_base.glb",
      "desc":
          "ฐานเสาอากาศ (Matching Unit):\n"
          "• หน้าที่: แมตช์สัญญาณระหว่างเครื่องกับเสาอากาศ\n"
          "• ขั้วต่อ: แบบ TNC เกลียวหมุน\n"
          "• การตรวจสอบ: เช็คเกลียวและเข็มแกนกลาง (Pin) ว่าหักหรืองอหรือไม่",
    },
    {
      "id": "antenna_whip",
      "name": "ANTENNA WHIP",
      "file": "assets/models/antenna_whip.glb",
      "desc":
          "ตัวเสาอากาศ (Whip Element):\n"
          "• ประเภท: เสาอากาศแบบอ่อน (Tape/Blade Antenna)\n"
          "• ความยาว: ประมาณ 1 เมตร (เมื่อกางสุด)\n"
          "• วัสดุ: เหล็กสปริงหุ้มฉนวน พับเก็บได้\n"
          "• ข้อควรระวัง: ตรวจสอบรอยปริแตกของฉนวนหุ้ม",
    },
    {
      "id": "battery",
      "name": "BATTERY PACK (BA-624)",
      "file": "assets/models/battery.glb",
      "desc":
          "แบตเตอรี่ (Power Source):\n"
          "• รุ่น: BA-624 (Ni-Cd หรือ Li-ion)\n"
          "• แรงดันไฟ: 14.4 VDC (Nominal)\n"
          "• ระยะเวลาใช้งาน: 10-12 ชั่วโมง\n"
          "• การดูแลรักษา: ตรวจสอบขั้วสัมผัสทองเหลือง ต้องสะอาดไม่มีสนิมเขียว",
    },
  ];

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final currentPart = parts[selectedIndex];
    final currentStatus = inspectionStatus[currentPart['id']];

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        title: Text(
          "PART INSPECTION",
          style: GoogleFonts.blackOpsOne(color: const Color(0xFF00FF41)),
        ),
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF00FF41)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // --- 3D View & Status HUD ---
          Expanded(
            flex: 5,
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.center,
                  radius: 1.0,
                  colors: [Color(0xFF2A2A2A), Color(0xFF000000)],
                  stops: [0.0, 1.0],
                ),
              ),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: CustomPaint(painter: SciFiGridPainter()),
                  ),
                  ModelViewer(
                    key: ValueKey(currentPart['file']),
                    backgroundColor: Colors.transparent,
                    src: currentPart['file'] ?? '',
                    alt: "3D Model",
                    cameraControls: true,
                    autoRotate: false,
                    disableZoom: false,
                    minFieldOfView: '5deg',
                    maxFieldOfView: '110deg',
                  ),

                  // แถบสถานะการตรวจมุมซ้ายบน
                  Positioned(
                    top: 20,
                    left: 20,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.7),
                        border: Border.all(
                          color: currentStatus == true
                              ? Colors.green
                              : (currentStatus == false
                                    ? Colors.red
                                    : Colors.grey),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            currentStatus == true
                                ? Icons.check_circle
                                : (currentStatus == false
                                      ? Icons.error
                                      : Icons.help_outline),
                            color: currentStatus == true
                                ? Colors.green
                                : (currentStatus == false
                                      ? Colors.red
                                      : Colors.grey),
                            size: 18,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            currentStatus == true
                                ? "STATUS: PASSED"
                                : (currentStatus == false
                                      ? "STATUS: FAILED"
                                      : "STATUS: PENDING"),
                            style: GoogleFonts.blackOpsOne(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Positioned(
                    top: 20,
                    right: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "INSPECTING:",
                          style: GoogleFonts.sarabun(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          currentPart['name']!,
                          style: GoogleFonts.blackOpsOne(
                            color: const Color(0xFF00FF41),
                            fontSize: 22,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // --- Technical Specs & Pass/Fail Buttons ---
          Expanded(
            flex: 5,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Color(0xFF1E1E1E),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                border: Border(
                  top: BorderSide(color: Color(0xFF00FF41), width: 2),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "SPECIFICATIONS",
                    style: GoogleFonts.blackOpsOne(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.white10),
                      ),
                      child: SingleChildScrollView(
                        child: Text(
                          currentPart['desc']!,
                          style: GoogleFonts.sarabun(
                            color: const Color(0xFF00FF41),
                            fontSize: 15,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),

                  // ปุ่มตัดสินใจ PASS / FAIL
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () => setState(
                            () => inspectionStatus[currentPart['id']!] = false,
                          ),
                          icon: const Icon(Icons.close, color: Colors.white),
                          label: const Text("FAIL"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red[900],
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () => setState(
                            () => inspectionStatus[currentPart['id']!] = true,
                          ),
                          icon: const Icon(Icons.check, color: Colors.white),
                          label: const Text("PASS"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green[900],
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 15),

                  // เมนูเลือกชิ้นส่วน
                  SizedBox(
                    height: 45,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: parts.length,
                      itemBuilder: (context, index) {
                        bool isSelected = index == selectedIndex;
                        bool? status = inspectionStatus[parts[index]['id']];
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: InkWell(
                            onTap: () => setState(() => selectedIndex = index),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? const Color(0xFF00FF41)
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(
                                  color: status == true
                                      ? Colors.green
                                      : (status == false
                                            ? Colors.red
                                            : Colors.grey),
                                  width: isSelected ? 2 : 1,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  parts[index]['name']!.split(" ").last,
                                  style: GoogleFonts.blackOpsOne(
                                    color: isSelected
                                        ? Colors.black
                                        : Colors.white70,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
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
}

class SciFiGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF00FF41).withOpacity(0.1)
      ..style = PaintingStyle.stroke;
    for (double x = 0; x <= size.width; x += 40) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y <= size.height; y += 40) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter old) => false;
}
