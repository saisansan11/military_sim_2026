import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'prc710_details.dart'; // ไฟล์รายละเอียดตัวใหม่

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
            // ปุ่มเลือก PRC-624 (รันได้ปกติ)
            _buildRadioBtn(context, "AN/PRC-624", "Handheld VHF/FM Radio", () {
              // Navigator ไปหน้าเมนู 624 เดิม
            }),
            const SizedBox(height: 16),

            // ✅ ปุ่มเลือก PRC-710 (เพิ่มใหม่แบบ Safe Mode)
            _buildRadioBtn(context, "AN/PRC-710", "Tactical Digital Radio", () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Prc710DetailScreen(),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildRadioBtn(
    BuildContext context,
    String title,
    String sub,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A1A),
          border: Border.all(color: const Color(0xFF00FF41)),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            const Icon(Icons.radio, color: Color(0xFF00FF41), size: 30),
            const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: GoogleFonts.blackOpsOne(fontSize: 18)),
                Text(
                  sub,
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
