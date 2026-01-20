import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Import หน้าจอต่างๆ
import 'prc710_screen.dart'; // 1. หน้าจำลอง
import 'prc710_details.dart'; // 2. หน้าสเปค 3D

class Prc710MenuScreen extends StatelessWidget {
  const Prc710MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          "AN/PRC-710 MENU",
          style: GoogleFonts.blackOpsOne(color: const Color(0xFF00FF41)),
        ),
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF00FF41)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/military_bg.png"),
            fit: BoxFit.cover,
            opacity: 0.15,
          ),
        ),
        child: SingleChildScrollView(
          // ✅ ปรับ Padding ให้สมดุล
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // --- ปุ่มที่ 1: RADIO OPERATION ---
                _buildNeonButton(
                  context,
                  "1. RADIO OPERATION",
                  "ฝึกการตั้งความถี่และการใช้งาน",
                  Icons.settings_remote,
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Prc710Screen(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),

                // --- ปุ่มที่ 2: SPECIFICATION & 3D ---
                _buildNeonButton(
                  context,
                  "2. SPECIFICATION & 3D",
                  "ข้อมูลจำเพาะและโมเดล 3 มิติ",
                  Icons.view_in_ar,
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Prc710DetailScreen(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),

                // --- ปุ่มที่ 3: ASSEMBLY TRAINING ---
                _buildNeonButton(
                  context,
                  "3. ASSEMBLY TRAINING",
                  "ฝึกการประกอบชุดอุปกรณ์",
                  Icons.build,
                  () {
                    _showComingSoon(context, "กำลังพัฒนาระบบฝึกประกอบ PRC-710");
                  },
                ),
                const SizedBox(height: 20),

                // --- ปุ่มที่ 4: TROUBLESHOOTING ---
                _buildNeonButton(
                  context,
                  "4. TROUBLESHOOTING",
                  "การวิเคราะห์และแก้ไขข้อขัดข้อง",
                  Icons.build_circle_outlined,
                  () {
                    _showComingSoon(context, "กำลังพัฒนาระบบแก้ปัญหา PRC-710");
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // --- Widget สร้างปุ่มนีออน (ขนาดเท่า 624 เป๊ะ) ---
  Widget _buildNeonButton(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    VoidCallback onTap,
  ) {
    return Center(
      // ✅ ใช้ Center เพื่อจัดให้ปุ่มอยู่กลางเสมอ
      child: Container(
        width: 350, // ✅ Fix ความกว้างเท่ากับ 624 (ไม่ใช้ double.infinity)
        height: 100, // ✅ Fix ความสูงเท่ากับ 624
        decoration: BoxDecoration(
          color: const Color(0xFF001500),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: const Color(0xFF00FF41), width: 2),
          boxShadow: const [
            BoxShadow(
              color: Color(0xFF00FF41),
              blurRadius: 10,
              spreadRadius: 0.5,
              offset: Offset(0, 0),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(15),
            splashColor: const Color(0xFF00FF41).withOpacity(0.3),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Icon(icon, color: const Color(0xFF00FF41), size: 40),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: GoogleFonts.blackOpsOne(
                            fontSize: 18, // ปรับขนาด Font ให้พอดีกรอบ
                            color: Colors.white,
                            shadows: [
                              const Shadow(
                                blurRadius: 5,
                                color: Color(0xFF00FF41),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          subtitle,
                          style: GoogleFonts.sarabun(
                            fontSize: 12,
                            color: Colors.grey[400],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Dialog แจ้งเตือน
  void _showComingSoon(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(color: Color(0xFF00FF41)),
        ),
        title: Text(
          "SYSTEM STATUS",
          style: GoogleFonts.blackOpsOne(color: Colors.white),
        ),
        content: Text(
          message,
          style: GoogleFonts.sarabun(color: const Color(0xFF00FF41)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("ACKNOWLEDGE"),
          ),
        ],
      ),
    );
  }
}
