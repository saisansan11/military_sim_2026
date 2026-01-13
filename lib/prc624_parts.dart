import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Prc624PartsScreen extends StatefulWidget {
  const Prc624PartsScreen({super.key});

  @override
  State<Prc624PartsScreen> createState() => _Prc624PartsScreenState();
}

class _Prc624PartsScreenState extends State<Prc624PartsScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF050505),
      appBar: AppBar(
        title: Text(
          "PART INSPECTION",
          style: GoogleFonts.blackOpsOne(color: const Color(0xFF00FF41)),
        ),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Color(0xFF00FF41)),
      ),
      body: Stack(
        children: [
          Positioned.fill(child: CustomPaint(painter: GridPainter())),
          Center(
            child: SizedBox(
              width: 300,
              height: 500,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    top: 0,
                    left: 40,
                    child: _buildPartTarget(
                      label: "ANTENNA",
                      desc: "เสาอากาศยางแบบสั้น (Short Rubber) ย่าน VHF",
                      child: Container(
                        width: 8,
                        height: 150,
                        color: Colors.grey[800],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 140,
                    child: _buildPartTarget(
                      label: "TRANSCEIVER",
                      desc:
                          "เครื่องรับ-ส่งวิทยุ PRC-624\nความถี่ 30-88 MHz\nกำลังส่ง 2 วัตต์",
                      child: Container(
                        width: 200,
                        height: 300,
                        decoration: BoxDecoration(
                          color: const Color(0xFF2d3436),
                          border: Border.all(
                            color: const Color(0xFF00FF41),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.hub,
                                size: 80,
                                color: Colors.white10,
                              ),
                              Text(
                                "INTERNAL\nCIRCUIT",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.vt323(
                                  color: Colors.white24,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 120,
                    left: 60,
                    child: _buildPartTarget(
                      label: "VOL/OFF",
                      desc: "สวิตช์เปิด-ปิด และปรับความดังเสียง",
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                          color: Colors.black,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: _buildPartTarget(
                      label: "BATTERY",
                      desc:
                          "แบตเตอรี่แพ็คชนิด Li-ion\nแรงดัน 12V ใช้งานต่อเนื่อง 10 ชม.",
                      child: Container(
                        width: 180,
                        height: 60,
                        decoration: BoxDecoration(
                          color: const Color(0xFF111111),
                          border: Border.all(
                            color: Colors.redAccent.withOpacity(0.5),
                          ),
                          borderRadius: const BorderRadius.vertical(
                            bottom: Radius.circular(20),
                          ),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.battery_charging_full,
                            color: Colors.white24,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            child: Text(
              "MODE: INSPECTION\nTARGET: PRC-624",
              style: GoogleFonts.vt323(
                color: const Color(0xFF00FF41),
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPartTarget({
    required String label,
    required String desc,
    required Widget child,
  }) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            backgroundColor: Colors.black.withOpacity(0.9),
            shape: RoundedRectangleBorder(
              side: const BorderSide(color: Color(0xFF00FF41), width: 2),
            ),
            title: Row(
              children: [
                const Icon(Icons.analytics, color: Color(0xFF00FF41)),
                const SizedBox(width: 10),
                Text(
                  label,
                  style: GoogleFonts.blackOpsOne(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Divider(color: Color(0xFF00FF41)),
                Text(
                  desc,
                  style: GoogleFonts.sarabun(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 20),
                // แก้ไขชื่อไอคอนตรงนี้ครับ จาก Icons.3d_rotation เป็น Icons.view_in_ar
                Center(
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white24),
                    ),
                    child: const Icon(
                      Icons.view_in_ar,
                      size: 50,
                      color: Color(0xFF00FF41),
                    ),
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: Text(
                  "CLOSE DATA",
                  style: GoogleFonts.vt323(
                    color: const Color(0xFF00FF41),
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        );
      },
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          child,
          Positioned(
            child: FadeTransition(
              opacity: _controller,
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFF00FF41), width: 2),
                  color: const Color(0xFF00FF41).withOpacity(0.2),
                ),
                child: const Center(
                  child: Icon(Icons.add, size: 20, color: Color(0xFF00FF41)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF00FF41).withOpacity(0.1)
      ..style = PaintingStyle.stroke;
    for (double x = 0; x < size.width; x += 40) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += 40) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
