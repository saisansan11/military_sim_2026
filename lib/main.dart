import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'prc624_screen.dart';

void main() {
  runApp(const MilitaryApp());
}

class MilitaryApp extends StatelessWidget {
  const MilitaryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EW Training Simulator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color(0xFF00FF41), // สีเขียว Terminal
        scaffoldBackgroundColor: const Color(0xFF111111), // สีดำด้าน
        useMaterial3: true,
      ),
      home: const MainMenuScreen(),
    );
  }
}

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EW TRAINING SUITE'),
        centerTitle: true,
        backgroundColor: Colors.black,
        titleTextStyle: GoogleFonts.blackOpsOne(
          fontSize: 24,
          color: const Color(0xFF00FF41),
          letterSpacing: 2.0,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.radar, size: 100, color: Color(0xFF00FF41)),
            const SizedBox(height: 40),
            Text(
              'SELECT EQUIPMENT',
              style: GoogleFonts.orbitron(
                fontSize: 18,
                color: Colors.white70,
                letterSpacing: 1.5,
              ),
            ),
            const SizedBox(height: 20),
            // ปุ่มเลือกวิทยุ PRC-624
            _buildTacticalButton(
              context,
              label: "PRC-624",
              subtitle: "VHF/FM Handheld Radio",
              icon: Icons.radio,
              onPressed: () {
                // เดี๋ยวเราจะมาทำหน้าจำลองวิทยุกันต่อในขั้นหน้าครับ
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Prc624Screen()),
                );
              },
            ),
            const SizedBox(height: 15),
            // ปุ่มวิทยุรุ่นอื่น (ปิดไว้ก่อน)
            _buildTacticalButton(
              context,
              label: "PRC-77",
              subtitle: "LOCKED",
              icon: Icons.lock_outline,
              isLocked: true,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  // ฟังก์ชันสร้างปุ่มกดสไตล์ทหาร
  Widget _buildTacticalButton(
    BuildContext context, {
    required String label,
    required String subtitle,
    required IconData icon,
    required VoidCallback onPressed,
    bool isLocked = false,
  }) {
    return Container(
      width: 300,
      decoration: BoxDecoration(
        border: Border.all(
          color: isLocked ? Colors.grey : const Color(0xFF00FF41),
        ),
        borderRadius: BorderRadius.circular(8),
        color: isLocked ? Colors.white10 : Colors.black,
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: isLocked ? Colors.grey : const Color(0xFF00FF41),
          size: 30,
        ),
        title: Text(
          label,
          style: GoogleFonts.orbitron(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: isLocked ? Colors.grey : Colors.white,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(color: isLocked ? Colors.white24 : Colors.white54),
        ),
        onTap: onPressed,
      ),
    );
  }
}
