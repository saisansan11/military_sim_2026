import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Prc624Screen extends StatefulWidget {
  const Prc624Screen({super.key});

  @override
  State<Prc624Screen> createState() => _Prc624ScreenState();
}

class _Prc624ScreenState extends State<Prc624Screen> {
  String frequency = "45.500"; // ความถี่เริ่มต้น
  String inputBuffer = ""; // ตัวเลขที่กำลังกด

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1a1a1a), // สีเทาดำลายพราง
      appBar: AppBar(
        title: const Text("PRC-624 SIMULATION"),
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF00FF41)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: Container(
          width: 350,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFF2d3436), // สีตัวเครื่องวิทยุ
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                blurRadius: 15,
                offset: const Offset(5, 5),
              ),
            ],
            border: Border.all(color: Colors.black, width: 2),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // --- ส่วนหัว (เสาอากาศ + ปุ่มหมุน) ---
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildKnob("VOL"), // ปุ่ม Volume
                  Container(
                    width: 20,
                    height: 60,
                    color: Colors.black,
                  ), // ฐานเสาอากาศ
                  _buildKnob("CH"), // ปุ่ม Channel
                ],
              ),
              const SizedBox(height: 20),

              // --- หน้าจอ LCD ---
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 10,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF9CA388), // สีเขียวขี้ม้าแบบจอ LCD ทหาร
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.black, width: 2),
                  boxShadow: const [
                    BoxShadow(
                      inset: true,
                      color: Colors.black12,
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      "FREQ (MHz)",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      inputBuffer.isNotEmpty
                          ? inputBuffer
                          : frequency, // แสดงตัวเลขที่กด
                      style: GoogleFonts.digital7(
                        // ใช้ฟอนต์ Digital-7
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // --- แป้นคีย์บอร์ด (Keypad) ---
              _buildKeypad(),

              const SizedBox(height: 10),
              const Text(
                "HANDHELD VHF/FM RADIO",
                style: TextStyle(color: Colors.white24, fontSize: 10),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ฟังก์ชันสร้างปุ่มกดตัวเลข
  Widget _buildKeypad() {
    return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      childAspectRatio: 1.5,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      padding: const EdgeInsets.all(10),
      children: [
        _buildKeyBtn("1", sub: ""),
        _buildKeyBtn("2", sub: ""),
        _buildKeyBtn("3", sub: ""),
        _buildKeyBtn("4", sub: ""),
        _buildKeyBtn("5", sub: ""),
        _buildKeyBtn("6", sub: ""),
        _buildKeyBtn("7", sub: ""),
        _buildKeyBtn("8", sub: ""),
        _buildKeyBtn("9", sub: ""),
        _buildKeyBtn("CLR", color: Colors.redAccent, onTap: _clearFreq),
        _buildKeyBtn("0", sub: ""),
        _buildKeyBtn("ENT", color: Colors.green, onTap: _enterFreq),
      ],
    );
  }

  Widget _buildKeyBtn(
    String label, {
    String? sub,
    Color? color,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap ?? () => _onNumPress(label),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.white24),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.grey[800]!, Colors.black],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: TextStyle(
                color: color ?? Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (sub != null && sub.isNotEmpty)
              Text(
                sub,
                style: const TextStyle(color: Colors.grey, fontSize: 10),
              ),
          ],
        ),
      ),
    );
  }

  // ฟังก์ชันวาดปุ่มหมุน (Knob)
  Widget _buildKnob(String label) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.black,
            gradient: RadialGradient(colors: [Colors.grey, Colors.black]),
          ),
          child: const Center(
            child: Icon(Icons.remove, color: Colors.white, size: 15),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          label,
          style: const TextStyle(color: Colors.white54, fontSize: 10),
        ),
      ],
    );
  }

  // --- Logic การทำงานของปุ่ม ---
  void _onNumPress(String num) {
    if (inputBuffer.length < 6) {
      setState(() {
        inputBuffer += num;
        // ใส่จุดทศนิยมอัตโนมัติ (เช่นกด 45500 -> 45.500)
        if (inputBuffer.length == 2 && !inputBuffer.contains('.')) {
          inputBuffer += ".";
        }
      });
    }
  }

  void _clearFreq() {
    setState(() {
      inputBuffer = "";
    });
  }

  void _enterFreq() {
    setState(() {
      if (inputBuffer.isNotEmpty) {
        frequency = inputBuffer;
        inputBuffer = "";
      }
    });
    // จำลองเสียงติ๊ด (อนาคต)
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Frequency SET!")));
  }
}
