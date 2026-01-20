import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Prc710Screen extends StatefulWidget {
  const Prc710Screen({super.key});

  @override
  State<Prc710Screen> createState() => _Prc710ScreenState();
}

class _Prc710ScreenState extends State<Prc710Screen> {
  // สถานะเครื่อง
  String frequency = "045.000"; // ความถี่ปัจจุบัน
  String tempInput = ""; // ตัวเลขที่กำลังพิมพ์
  bool isEditing = false; // กำลังพิมพ์อยู่ไหม?
  double volume = 50; // ระดับเสียง
  bool isPttPressed = false; // สถานะปุ่ม PTT
  bool isLightOn = true; // ไฟหน้าจอ

  // ฟังก์ชั่นกดปุ่มตัวเลข
  void _onKeyPress(String value) {
    setState(() {
      if (!isEditing) {
        isEditing = true;
        tempInput = value;
      } else {
        if (tempInput.length < 6) {
          // จำกัด 6 หลัก (XXX.XXX)
          tempInput += value;
        }
      }
    });
  }

  // ฟังก์ชั่นตกลง (ENT)
  void _onEnter() {
    setState(() {
      if (isEditing && tempInput.isNotEmpty) {
        // จัดรูปแบบให้สวยงาม (เติมจุดทศนิยม)
        if (tempInput.length > 3) {
          frequency = "${tempInput.substring(0, 3)}.${tempInput.substring(3)}";
        } else {
          frequency = tempInput.padRight(7, '0'); // กรณีพิมพ์ไม่ครบ
        }
        tempInput = "";
        isEditing = false;
      }
    });
  }

  // ฟังก์ชั่นลบ/ยกเลิก (CLR)
  void _onClear() {
    setState(() {
      tempInput = "";
      isEditing = false;
    });
  }

  // ฟังก์ชั่น PTT
  void _togglePtt(bool pressed) {
    setState(() {
      isPttPressed = pressed;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1a1a1a), // สีตัวถังเครื่อง
      appBar: AppBar(
        title: Text(
          "PRC-710 OPERATION",
          style: GoogleFonts.blackOpsOne(color: const Color(0xFF00FF41)),
        ),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Color(0xFF00FF41)),
      ),
      body: Column(
        children: [
          // --- ส่วนบน: หน้าจอ LCD และ ปุ่มควบคุม ---
          Expanded(
            flex: 4,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF2d2d2d), // สีพลาสติกแข็ง
                border: Border(
                  bottom: BorderSide(color: Colors.grey[800]!, width: 5),
                ),
              ),
              child: Column(
                children: [
                  // 1. หน้าจอ LCD
                  Container(
                    width: double.infinity,
                    height: 120,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: isLightOn
                          ? const Color(0xFF003300)
                          : const Color(0xFF111111), // สีจอเขียวทหาร
                      border: Border.all(color: Colors.grey[700]!, width: 4),
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: isLightOn
                          ? [
                              const BoxShadow(
                                color: Color(0xFF00FF41),
                                blurRadius: 5,
                                spreadRadius: -5,
                              ),
                            ]
                          : [],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // แถบสถานะบนจอ
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Icon(
                              Icons.battery_full,
                              color: Colors.black,
                              size: 16,
                            ),
                            Text(
                              "CH: 01",
                              style: GoogleFonts.shareTechMono(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Icon(
                              isPttPressed
                                  ? Icons.wifi_tethering
                                  : Icons.wifi_off,
                              color: isPttPressed ? Colors.red : Colors.black,
                              size: 16,
                            ),
                          ],
                        ),
                        const Spacer(),
                        // ตัวเลขความถี่ (พระเอกของงาน)
                        Center(
                          child: Text(
                            isEditing ? tempInput.padRight(6, '_') : frequency,
                            style: GoogleFonts.shareTechMono(
                              fontSize: 40,
                              color: const Color(
                                0xFF00FF41,
                              ).withOpacity(0.9), // ตัวเลขสีเขียวเรืองแสง
                              fontWeight: FontWeight.bold,
                              shadows: [
                                const Shadow(
                                  blurRadius: 10,
                                  color: Color(0xFF00FF41),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Spacer(),
                        // แถบ Volume
                        Row(
                          children: [
                            const Text(
                              "VOL: ",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 10,
                              ),
                            ),
                            Expanded(
                              child: LinearProgressIndicator(
                                value: volume / 100,
                                backgroundColor: Colors.black26,
                                color: Colors.black,
                                minHeight: 4,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // 2. ปุ่มควบคุมหมุน (Volume / Channel)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildKnobControl(
                        "VOLUME",
                        volume,
                        (val) => setState(() => volume = val),
                      ),
                      // ปุ่ม PTT จำลอง
                      GestureDetector(
                        onTapDown: (_) => _togglePtt(true),
                        onTapUp: (_) => _togglePtt(false),
                        onTapCancel: () => _togglePtt(false),
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: isPttPressed
                                ? Colors.red[900]
                                : const Color(0xFF333333),
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.black, width: 3),
                            boxShadow: [
                              BoxShadow(
                                color: isPttPressed ? Colors.red : Colors.black,
                                blurRadius: 10,
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              "PTT",
                              style: GoogleFonts.blackOpsOne(
                                color: isPttPressed
                                    ? Colors.white
                                    : Colors.grey,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                      // ปุ่มเปิดไฟ
                      Column(
                        children: [
                          IconButton(
                            onPressed: () =>
                                setState(() => isLightOn = !isLightOn),
                            icon: Icon(
                              Icons.light_mode,
                              color: isLightOn ? Colors.yellow : Colors.grey,
                            ),
                            iconSize: 30,
                          ),
                          const Text(
                            "LIGHT",
                            style: TextStyle(color: Colors.grey, fontSize: 10),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // --- ส่วนล่าง: แป้นตัวเลข (Keypad) ---
          Expanded(
            flex: 5,
            child: Container(
              color: const Color(0xFF111111),
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                    "KEYPAD ENTRY",
                    style: GoogleFonts.blackOpsOne(
                      color: Colors.grey[800],
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 3,
                      childAspectRatio: 1.5,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      children: [
                        _buildKey("1", "FREQ"),
                        _buildKey("2", "MODE"),
                        _buildKey("3", "SQL"),
                        _buildKey("4", "LITE"),
                        _buildKey("5", "ZERO"),
                        _buildKey("6", "CMS"),
                        _buildKey("7", "OPT"),
                        _buildKey("8", "PGM"),
                        _buildKey("9", "TST"),
                        _buildKey("CLR", "", isAction: true),
                        _buildKey("0", ""),
                        _buildKey("ENT", "", isAction: true),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget สร้างปุ่มตัวเลข (หน้าตาเหมือนปุ่มยาง)
  Widget _buildKey(String label, String subLabel, {bool isAction = false}) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          if (label == "CLR")
            _onClear();
          else if (label == "ENT")
            _onEnter();
          else
            _onKeyPress(label);
        },
        borderRadius: BorderRadius.circular(10),
        child: Container(
          decoration: BoxDecoration(
            color: isAction ? Colors.grey[800] : const Color(0xFF222222),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.black, width: 2),
            boxShadow: const [
              BoxShadow(
                color: Colors.black,
                offset: Offset(0, 4),
                blurRadius: 2,
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label,
                style: GoogleFonts.blackOpsOne(
                  color: isAction ? Colors.orange : Colors.white,
                  fontSize: 24,
                ),
              ),
              if (subLabel.isNotEmpty)
                Text(
                  subLabel,
                  style: GoogleFonts.sarabun(
                    color: const Color(0xFF00FF41),
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget สร้างปุ่มหมุน (Simulation)
  Widget _buildKnobControl(
    String label,
    double currentVal,
    Function(double) onChanged,
  ) {
    return Column(
      children: [
        Text(
          label,
          style: GoogleFonts.blackOpsOne(color: Colors.grey, fontSize: 10),
        ),
        SizedBox(
          height: 80,
          child: RotatedBox(
            quarterTurns: 3,
            child: Slider(
              value: currentVal,
              min: 0,
              max: 100,
              activeColor: const Color(0xFF00FF41),
              inactiveColor: Colors.grey[800],
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}
