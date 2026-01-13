import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

class Inspection3DScreen extends StatefulWidget {
  const Inspection3DScreen({super.key});

  @override
  State<Inspection3DScreen> createState() => _Inspection3DScreenState();
}

class _Inspection3DScreenState extends State<Inspection3DScreen> {
  // สถานะการโชว์จุด Hotspot
  bool showInternal = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xFF00FF41),
          ), // สีเขียวทหาร
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "PART INSPECTION",
          style: GoogleFonts.blackOpsOne(
            color: const Color(0xFF00FF41),
            letterSpacing: 1.5,
          ),
        ),
      ),
      body: Stack(
        children: [
          // 1. พื้นหลังตาราง Grid (สร้างบรรยากาศ Tech)
          Positioned.fill(child: CustomPaint(painter: GridPainter())),

          // 2. ตัวโชว์โมเดล 3D
          Positioned.fill(
            child: ModelViewer(
              backgroundColor: Colors.transparent,
              // *** เปลี่ยนชื่อไฟล์ตรงนี้ให้ตรงกับไฟล์ของท่าน ***
              src: 'assets/models/prc624.glb',
              alt: "A 3D model of PRC-624 Radio",
              ar: true, // รองรับ AR (ถ้ามือถือไหว)
              autoRotate: true, // ให้หมุนโชว์เองช้าๆ
              disableZoom: false, // อนุญาตให้ซูมเข้าออก
              cameraControls: true, // อนุญาตให้ใช้นิ้วหมุน
            ),
          ),

          // 3. ปุ่ม Hotspot ลอย (จำลองการคลิกดูไส้ใน)
          if (showInternal)
            const Center(
              child: Icon(
                Icons.settings_input_component,
                color: Colors.amber,
                size: 50,
              ),
            ),

          // 4. UI ควบคุมด้านล่าง
          Positioned(
            bottom: 30,
            left: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "MODE: INSPECTION",
                  style: GoogleFonts.vt323(
                    color: const Color(0xFF00FF41),
                    fontSize: 24,
                  ),
                ),
                Text(
                  "TARGET: PRC-624",
                  style: GoogleFonts.vt323(
                    color: const Color(0xFF00FF41),
                    fontSize: 24,
                  ),
                ),
              ],
            ),
          ),

          // ปุ่ม Toggle ดูภายใน
          Positioned(
            bottom: 30,
            right: 20,
            child: FloatingActionButton(
              backgroundColor: const Color(0xFF00FF41).withOpacity(0.2),
              shape: RoundedRectangleBorder(
                side: const BorderSide(color: Color(0xFF00FF41), width: 2),
                borderRadius: BorderRadius.circular(10),
              ),
              onPressed: () {
                setState(() => showInternal = !showInternal);
              },
              child: Icon(
                showInternal ? Icons.visibility_off : Icons.visibility,
                color: const Color(0xFF00FF41),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// --- Class วาดตาราง Grid สีเขียวจางๆ ---
class GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF00FF41).withOpacity(0.15)
      ..strokeWidth = 1;

    double step = 40; // ระยะห่างช่องตาราง

    // วาดเส้นตั้ง
    for (double x = 0; x <= size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    // วาดเส้นนอน
    for (double y = 0; y <= size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
