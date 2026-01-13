import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AssemblyScreen extends StatelessWidget {
  const AssemblyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        title: Text(
          "ASSEMBLY TRAINING",
          style: GoogleFonts.blackOpsOne(color: const Color(0xFF00FF41)),
        ),
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF00FF41)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.build_circle, size: 100, color: Colors.grey),
            const SizedBox(height: 20),
            Text(
              "ASSEMBLY MODE",
              style: GoogleFonts.blackOpsOne(fontSize: 24, color: Colors.white),
            ),
            const SizedBox(height: 10),
            Text(
              "พื้นที่สำหรับโค้ดฝึกประกอบชุดอุปกรณ์\n(ลากวางชิ้นส่วน)",
              textAlign: TextAlign.center,
              style: GoogleFonts.sarabun(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
