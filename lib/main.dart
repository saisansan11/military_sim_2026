import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'prc624_menu.dart'; // Import เมนูย่อยที่เราทำไว้

void main() {
  runApp(const MilitarySimApp());
}

class MilitarySimApp extends StatelessWidget {
  const MilitarySimApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Military Sim',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.black,
        scaffoldBackgroundColor: const Color(0xFF121212),
        useMaterial3: true,
      ),
      home: const ToolListScreen(),
    );
  }
}

class ToolListScreen extends StatelessWidget {
  const ToolListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "MILITARY TRAINING",
          style: GoogleFonts.blackOpsOne(color: const Color(0xFF00FF41)),
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // การ์ดรายการเครื่องมือ PRC-624
          _buildToolCard(
            context,
            title: "AN/PRC-624",
            subtitle: "Handheld VHF/FM Radio",
            imagePath: 'assets/images/prc624_real.png',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Prc624MenuScreen(),
                ),
              );
            },
          ),

          const SizedBox(height: 16),

          // ตัวอย่างเครื่องมืออื่น (ล็อคไว้)
          _buildToolCard(
            context,
            title: "AN/PRC-77 (Coming Soon)",
            subtitle: "Manpack Radio",
            isLocked: true,
            onTap: () {},
          ),
        ],
      ),
    );
  }

  // ฟังก์ชันสร้างการ์ด (แก้ไขใส่ Expanded ให้แล้ว)
  Widget _buildToolCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    String? imagePath,
    required VoidCallback onTap,
    bool isLocked = false,
  }) {
    return Card(
      color: Colors.grey[900],
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: isLocked ? Colors.grey : const Color(0xFF00FF41),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              // ส่วนไอคอน/รูปภาพด้านซ้าย
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: isLocked ? Colors.grey : const Color(0xFF00FF41),
                  ),
                ),
                child: isLocked
                    ? const Icon(Icons.lock, color: Colors.grey)
                    : (imagePath != null
                          ? Padding(
                              padding: const EdgeInsets.all(1),
                              child: Image.asset(
                                imagePath,
                                fit: BoxFit.contain,
                              ),
                            )
                          : const Icon(Icons.radio, color: Color(0xFF00FF41))),
              ),
              const SizedBox(width: 16),

              // ✅ ส่วนข้อความ (ใส่ Expanded เพื่อป้องกันข้อความทะลุจอ)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.blackOpsOne(
                        fontSize: 18,
                        color: isLocked ? Colors.grey : Colors.white,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: GoogleFonts.sarabun(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 8),

              // ลูกศรขวาสุด
              Icon(
                Icons.arrow_forward_ios,
                color: isLocked ? Colors.grey : const Color(0xFF00FF41),
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
