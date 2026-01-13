import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Import ไฟล์ย่อยทั้งหมด
import 'prc624_screen.dart'; // 1. วิทยุ
import 'prc624_details.dart'; // 2. ข้อมูล 3D
import 'assembly_screen.dart'; // 3. ฝึกประกอบ
import 'prc624_trouble.dart'; // 4. แก้ปัญหาขัดข้อง (ไฟล์ใหม่)

class Prc624MenuScreen extends StatelessWidget {
  const Prc624MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "AN/PRC-624 MENU",
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
            image: AssetImage("assets/images/prc624_real.png"),
            fit: BoxFit.cover,
            opacity: 0.1,
          ),
        ),
        child: SingleChildScrollView(
          // ป้องกันหน้าจอเกิน
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // เมนู 1
                _buildMenuButton(
                  context,
                  "1. RADIO OPERATION",
                  "ฝึกการตั้งความถี่และการใช้งาน",
                  Icons.settings_remote,
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Prc624Screen(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),

                // เมนู 2
                _buildMenuButton(
                  context,
                  "2. SPECIFICATION & 3D",
                  "ข้อมูลจำเพาะและโมเดล 3 มิติ",
                  Icons.view_in_ar,
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Prc624DetailScreen(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),

                // เมนู 3
                _buildMenuButton(
                  context,
                  "3. ASSEMBLY TRAINING",
                  "ฝึกการประกอบชุดอุปกรณ์",
                  Icons.build,
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AssemblyScreen(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),

                // ✅ เมนู 4: TROUBLESHOOTING
                _buildMenuButton(
                  context,
                  "4. TROUBLESHOOTING",
                  "การวิเคราะห์และแก้ไขข้อขัดข้อง",
                  Icons.build_circle_outlined,
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Prc624TroubleScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMenuButton(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    VoidCallback onTap,
  ) {
    return Container(
      width: 350,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.8),
        border: Border.all(color: const Color(0xFF00FF41), width: 2),
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(color: Color(0xFF00FF41), blurRadius: 5, spreadRadius: 0.5),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(15),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Icon(icon, color: const Color(0xFF00FF41), size: 40),
                const SizedBox(width: 20),
                Expanded(
                  // ใช้ Expanded กันตัวหนังสือล้น
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.blackOpsOne(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        subtitle,
                        style: GoogleFonts.sarabun(
                          fontSize: 12,
                          color: Colors.grey,
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
    );
  }
}
