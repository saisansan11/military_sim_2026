import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:audioplayers/audioplayers.dart';

class Prc624Screen extends StatefulWidget {
  const Prc624Screen({super.key});

  @override
  State<Prc624Screen> createState() => _Prc624ScreenState();
}

class _Prc624ScreenState extends State<Prc624Screen> {
  // --- ระบบเสียง (Audio System) ---
  final AudioPlayer _staticPlayer = AudioPlayer();
  final AudioPlayer _effectPlayer = AudioPlayer();

  // ลิงก์เสียง (ใส่ไว้แต่ยังไม่ให้เล่น เพื่อกัน Error)
  final String soundStatic =
      "https://codeskulptor-demos.commondatastorage.googleapis.com/GalaxyInvaders/alien_hum.wav";
  final String soundBeep =
      "https://codeskulptor-demos.commondatastorage.googleapis.com/GalaxyInvaders/pause.wav";
  final String soundSwitch =
      "https://codeskulptor-demos.commondatastorage.googleapis.com/GalaxyInvaders/bonus.wav";

  String frequency = "45.500";
  String inputBuffer = "";
  bool isPowerOn = false;
  bool isTransmitting = false;

  @override
  void dispose() {
    _staticPlayer.dispose();
    _effectPlayer.dispose();
    super.dispose();
  }

  // --- ฟังก์ชันเล่นเสียง (แบบปิดเสียงชั่วคราว) ---
  // แก้ไข: สั่งให้ return ทันที เพื่อไม่ให้เกิด Error เรื่อง CORS
  Future<void> _safePlay(
    AudioPlayer player,
    String url, {
    bool loop = false,
  }) async {
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        title: const Text("PRC-624 SIMULATOR"),
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF00FF41)),
          onPressed: () {
            _staticPlayer.stop();
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildPTTButton(),
              const SizedBox(width: 10),
              Container(
                width: 300,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF556B2F), Color(0xFF3B4426)],
                  ),
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.8),
                      blurRadius: 20,
                      offset: const Offset(10, 10),
                    ),
                  ],
                  border: Border.all(color: const Color(0xFF2F3820), width: 3),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildVolumeKnob(),
                        Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(0xFF222222),
                            border: Border.all(color: Colors.black54),
                            gradient: const RadialGradient(
                              colors: [Color(0xFF333333), Color(0xFF111111)],
                            ),
                          ),
                          child: const Icon(
                            Icons.volume_up,
                            color: Colors.white12,
                            size: 35,
                          ),
                        ),
                        _buildDummyKnob("CHAN"),
                      ],
                    ),
                    const SizedBox(height: 25),
                    _buildLCDScreen(),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: GridView.count(
                        crossAxisCount: 3,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        childAspectRatio: 1.3,
                        children: [
                          _buildRubberButton("1"),
                          _buildRubberButton("2"),
                          _buildRubberButton("3"),
                          _buildRubberButton("4"),
                          _buildRubberButton("5"),
                          _buildRubberButton("6"),
                          _buildRubberButton("7"),
                          _buildRubberButton("8"),
                          _buildRubberButton("9"),
                          _buildRubberButton("CLR", color: Colors.red[900]),
                          _buildRubberButton("0"),
                          _buildRubberButton("ENT", color: Colors.green[900]),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- LOGIC ---

  void _togglePower() async {
    setState(() {
      isPowerOn = !isPowerOn;
    });

    if (isPowerOn) {
      await _safePlay(_effectPlayer, soundSwitch);
      await Future.delayed(const Duration(milliseconds: 300));
      _safePlay(_staticPlayer, soundStatic, loop: true);
    } else {
      _staticPlayer.stop();
      _safePlay(_effectPlayer, soundSwitch);
      setState(() {
        isTransmitting = false;
        inputBuffer = "";
      });
    }
  }

  void _onPTTPress() {
    if (!isPowerOn) return;
    setState(() => isTransmitting = true);
    _staticPlayer.pause();
  }

  void _onPTTRelease() async {
    if (!isPowerOn) return;
    setState(() => isTransmitting = false);

    await _safePlay(_effectPlayer, soundBeep);
    await Future.delayed(const Duration(milliseconds: 500));

    if (isPowerOn) {
      _staticPlayer.resume();
    }
  }

  // === WIDGETS ===
  Widget _buildPTTButton() {
    return GestureDetector(
      onTapDown: (_) => _onPTTPress(),
      onTapUp: (_) => _onPTTRelease(),
      onTapCancel: () => _onPTTRelease(),
      child: Container(
        width: 50,
        height: 120,
        margin: const EdgeInsets.only(top: 100),
        decoration: BoxDecoration(
          color: isTransmitting ? Colors.red[800] : const Color(0xFF1a1a1a),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10),
            bottomLeft: Radius.circular(10),
          ),
          border: Border.all(color: Colors.black54),
          boxShadow: const [
            BoxShadow(color: Colors.black, offset: Offset(2, 2), blurRadius: 5),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "P\nT\nT",
              style: GoogleFonts.blackOpsOne(
                color: Colors.white54,
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVolumeKnob() {
    return GestureDetector(
      onTap: _togglePower,
      child: Column(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFF111111),
              border: Border.all(
                color: isPowerOn
                    ? const Color(0xFF00FF41)
                    : const Color(0xFF444444),
                width: 2,
              ),
              gradient: const RadialGradient(
                colors: [Color(0xFF333333), Color(0xFF000000)],
              ),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Transform.rotate(
                  angle: isPowerOn ? 0.8 : -0.8,
                  child: Container(
                    width: 5,
                    height: 20,
                    color: Colors.white,
                    margin: const EdgeInsets.only(bottom: 20),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 5),
          Text(
            isPowerOn ? "ON" : "OFF",
            style: TextStyle(
              color: isPowerOn ? const Color(0xFF00FF41) : Colors.grey,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLCDScreen() {
    if (!isPowerOn) {
      return Container(
        height: 80,
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xFF1a1a1a),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.black),
        ),
      );
    }
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      decoration: BoxDecoration(
        color: isTransmitting
            ? const Color(0xFFffeb3b)
            : const Color(0xFF8F9779),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.black, width: 2),
        boxShadow: const [
          BoxShadow(color: Colors.black45, blurRadius: 4, offset: Offset(2, 2)),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                isTransmitting ? "TX" : "RX",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isTransmitting ? Colors.red : Colors.black54,
                ),
              ),
              const Text(
                "MHZ",
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Text(
            inputBuffer.isNotEmpty ? inputBuffer : frequency,
            style: GoogleFonts.vt323(
              fontSize: 48,
              color: Colors.black87,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRubberButton(String label, {Color? color}) {
    return GestureDetector(
      onTap: () {
        if (!isPowerOn) return;
        if (label == "CLR")
          setState(() => inputBuffer = "");
        else if (label == "ENT") {
          if (inputBuffer.isEmpty) return;
          double? val = double.tryParse(inputBuffer);
          if (val != null && val >= 30.00 && val <= 88.00) {
            setState(() {
              frequency = inputBuffer;
              inputBuffer = "";
            });
            _safePlay(_effectPlayer, soundSwitch);
          } else {
            setState(() => inputBuffer = "");
          }
        } else {
          if (inputBuffer.length < 6) {
            setState(() {
              inputBuffer += label;
              if (inputBuffer.length == 2 && !inputBuffer.contains('.'))
                inputBuffer += ".";
            });
          }
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: color ?? const Color(0xFF222222),
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
              color: Colors.black54,
              offset: Offset(0, 4),
              blurRadius: 4,
            ),
          ],
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              color?.withOpacity(0.8) ?? const Color(0xFF333333),
              color ?? const Color(0xFF111111),
            ],
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: isPowerOn ? Colors.white : Colors.white24,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDummyKnob(String label) => Column(
    children: [
      Container(
        width: 50,
        height: 50,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xFF111111),
          gradient: RadialGradient(
            colors: [Color(0xFF333333), Color(0xFF000000)],
          ),
        ),
        child: const Center(
          child: Icon(Icons.settings, color: Colors.white24, size: 20),
        ),
      ),
      const SizedBox(height: 5),
      Text(label, style: const TextStyle(color: Colors.grey, fontSize: 10)),
    ],
  );
}
