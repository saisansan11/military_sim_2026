import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Import หน้าเมนูของทั้ง 2 รุ่น
import 'prc624_menu.dart';
import 'prc710_menu.dart'; // ✅ นำเข้าเมนู 710 (ถูกต้อง)

void main() => runApp(const MilitarySimApp());

class MilitarySimApp extends StatelessWidget {
  const MilitarySimApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const MainSelectorScreen(),
    );
  }
}

class MainSelectorScreen extends StatelessWidget {
  const MainSelectorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          "MILITARY TRAINING",
          style: GoogleFonts.blackOpsOne(color: const Color(0xFF00FF41)),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // 1. ปุ่ม AN/PRC-624
            _buildRadioBtn(context, "AN/PRC-624", "Handheld VHF/FM Radio", () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Prc624MenuScreen(),
                ),
              );
            }),
            const SizedBox(height: 16),

            // 2. ปุ่ม AN/PRC-710 (✅ แก้ไขแล้ว: ไปหน้าเมนูรวมก่อน)
            _buildRadioBtn(context, "AN/PRC-710", "Tactical Digital Radio", () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  // ❌ ของเก่า: const Prc710DetailScreen() <-- ผิด
                  // ✅ ของใหม่: ไปหน้าเมนูที่มี 4 ปุ่ม
                  builder: (context) => const Prc710MenuScreen(),
                ),
              );
            }),
            const SizedBox(height: 16),

            // 3. ปุ่ม PRC-77 (ล็อคไว้)
            _buildRadioBtn(
              context,
              "AN/PRC-77 (Coming Soon)",
              "Manpack Radio",
              null,
              isLocked: true,
            ),
          ],
        ),
      ),
    );
  }

  // Widget สร้างปุ่มกด
  Widget _buildRadioBtn(
    BuildContext context,
    String title,
    String sub,
    VoidCallback? onTap, {
    bool isLocked = false,
  }) {
    return InkWell(
      onTap: isLocked ? null : onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A1A),
          border: Border.all(
            color: isLocked ? Colors.grey : const Color(0xFF00FF41),
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Icon(
              isLocked ? Icons.lock : Icons.radio,
              color: isLocked ? Colors.grey : const Color(0xFF00FF41),
              size: 30,
            ),
            const SizedBox(width: 20),
            Column(
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
                  sub,
                  style: GoogleFonts.sarabun(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
            const Spacer(),
            if (!isLocked)
              const Icon(
                Icons.arrow_forward_ios,
                color: Color(0xFF00FF41),
                size: 16,
              ),
          ],
        ),
      ),
    );
  }
}
