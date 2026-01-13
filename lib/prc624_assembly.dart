import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Prc624AssemblyScreen extends StatefulWidget {
  const Prc624AssemblyScreen({super.key});

  @override
  State<Prc624AssemblyScreen> createState() => _Prc624AssemblyScreenState();
}

class _Prc624AssemblyScreenState extends State<Prc624AssemblyScreen> {
  bool isAntennaInstalled = false;
  bool isBatteryInstalled = false;
  bool isHandsetInstalled = false;

  bool get isComplete =>
      isAntennaInstalled && isBatteryInstalled && isHandsetInstalled;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212), // พื้นหลังดำด้าน
      appBar: AppBar(
        title: Text(
          "ASSEMBLY TRAINING",
          style: GoogleFonts.blackOpsOne(color: Colors.amber),
        ),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.amber),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _resetMission,
            tooltip: "Reset",
          ),
        ],
      ),
      body: Column(
        children: [
          // --- พื้นที่ประกอบ (Workstation) ---
          Expanded(
            flex: 3,
            child: Container(
              width: double.infinity,
              // พื้นหลังลายโลหะ
              decoration: BoxDecoration(
                color: const Color(0xFF222222),
                gradient: RadialGradient(
                  center: Alignment.center,
                  radius: 0.8,
                  colors: [Colors.grey[800]!, Colors.black],
                ),
              ),
              child: Center(
                child: SizedBox(
                  width: 350,
                  height: 600,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // 1. ตัวเครื่องหลัก (Main Body)
                      _buildMainBodyBase(),

                      // 2. เป้าเสาอากาศ
                      Positioned(
                        top: 45,
                        child: _buildDropZone(
                          targetId: "antenna",
                          isInstalled: isAntennaInstalled,
                          installedWidget: _buildAntennaPart(isDragging: false),
                          ghostWidget: _buildConnectorSlot(
                            30,
                            30,
                          ), // เป้าเป็นรู connector
                          onDropped: () =>
                              setState(() => isAntennaInstalled = true),
                        ),
                      ),

                      // 3. เป้าแบตเตอรี่
                      Positioned(
                        bottom: 85,
                        child: _buildDropZone(
                          targetId: "battery",
                          isInstalled: isBatteryInstalled,
                          installedWidget: _buildBatteryPart(isDragging: false),
                          ghostWidget:
                              _buildEmptyBatterySlot(), // เป้าเป็นช่องโบ๋ๆ
                          onDropped: () =>
                              setState(() => isBatteryInstalled = true),
                        ),
                      ),

                      // 4. เป้าปากพูด
                      Positioned(
                        right: 25,
                        top: 180,
                        child: _buildDropZone(
                          targetId: "handset",
                          isInstalled: isHandsetInstalled,
                          installedWidget: _buildHandsetPart(isDragging: false),
                          ghostWidget: _buildConnectorSlot(
                            40,
                            40,
                            icon: Icons.mic_external_on,
                          ), // รูเสียบไมค์
                          onDropped: () =>
                              setState(() => isHandsetInstalled = true),
                        ),
                      ),

                      // Mission Complete Banner
                      if (isComplete) _buildCompleteBanner(),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // --- กล่องเก็บอะไหล่ (Parts Bin) ---
          Expanded(
            flex: 1,
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFF0F0F0F),
                border: Border(
                  top: BorderSide(color: Colors.white12, width: 2),
                ),
              ),
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "EQUIPMENT TRAY",
                    style: GoogleFonts.orbitron(
                      color: Colors.amber.withOpacity(0.7),
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Wrap(
                    spacing: 30,
                    alignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      if (!isAntennaInstalled)
                        _buildDraggablePart(
                          "antenna",
                          _buildAntennaPart(isDragging: true),
                        ),
                      if (!isBatteryInstalled)
                        _buildDraggablePart(
                          "battery",
                          _buildBatteryPart(isDragging: true),
                        ),
                      if (!isHandsetInstalled)
                        _buildDraggablePart(
                          "handset",
                          _buildHandsetPart(isDragging: true),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // =========================================
  // ส่วนสร้างกราฟิก 3D (Skeuomorphic Widgets)
  // =========================================

  Widget _buildMainBodyBase() {
    return Container(
      width: 200,
      height: 320,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF4a5240), Color(0xFF2F3820)],
        ),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.black54, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.7),
            blurRadius: 20,
            offset: const Offset(10, 15),
          ),
          BoxShadow(
            color: Colors.white.withOpacity(0.1),
            blurRadius: 2,
            offset: const Offset(-2, -2),
          ),
        ],
      ),
      child: Center(
        child: Opacity(
          opacity: 0.3,
          child: Text(
            "PRC-624",
            style: GoogleFonts.blackOpsOne(
              color: Colors.black,
              fontSize: 30,
              shadows: [
                const Shadow(color: Colors.white24, offset: Offset(1, 1)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAntennaPart({required bool isDragging}) {
    return Column(
      children: [
        Container(
          width: 18,
          height: 160,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF222222), Color(0xFF555555), Color(0xFF222222)],
              stops: [0.1, 0.5, 0.9],
            ),
            borderRadius: BorderRadius.circular(9),
            boxShadow: isDragging
                ? [
                    const BoxShadow(
                      color: Colors.black54,
                      blurRadius: 10,
                      offset: Offset(5, 5),
                    ),
                  ]
                : null,
          ),
        ),
        Container(
          width: 25,
          height: 15,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Colors.grey, Colors.white, Colors.grey],
            ),
            borderRadius: BorderRadius.circular(2),
            border: Border.all(color: Colors.black54),
          ),
        ),
      ],
    );
  }

  Widget _buildBatteryPart({required bool isDragging}) {
    return Container(
      width: 180,
      height: 70,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF333333), Color(0xFF1a1a1a)],
        ),
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(20),
          top: Radius.circular(5),
        ),
        border: Border.all(color: Colors.black),
        boxShadow: isDragging
            ? [
                const BoxShadow(
                  color: Colors.black87,
                  blurRadius: 15,
                  offset: Offset(8, 8),
                ),
              ]
            : [
                const BoxShadow(
                  color: Colors.black87,
                  blurRadius: 5,
                  offset: Offset(2, 2),
                ),
              ],
      ),
      child: Stack(
        children: [
          const Center(
            child: Icon(
              Icons.battery_charging_full,
              color: Colors.white12,
              size: 50,
            ),
          ),
          const Positioned(
            top: 5,
            left: 10,
            child: Text(
              "Li-ion 12V",
              style: TextStyle(color: Colors.white24, fontSize: 10),
            ),
          ),
          Positioned(
            top: 0,
            right: 20,
            child: Row(
              children: [
                Container(width: 10, height: 5, color: Colors.amber),
                const SizedBox(width: 5),
                Container(width: 10, height: 5, color: Colors.amber),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHandsetPart({required bool isDragging}) {
    return Container(
      width: 60,
      height: 130,
      decoration: BoxDecoration(
        color: const Color(0xFF2d3436),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.black87, width: 2),
        boxShadow: [
          if (isDragging)
            const BoxShadow(
              color: Colors.black54,
              blurRadius: 12,
              offset: Offset(6, 6),
            ),
          // แก้ไข: เอา inset ออก ใช้ border แทน
          const BoxShadow(
            color: Colors.black45,
            blurRadius: 1,
            offset: Offset(1, 1),
          ),
        ],
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF3d4446), Color(0xFF2d3436)],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [Colors.black87, Colors.grey[800]!],
              ),
              border: Border.all(color: Colors.black),
            ),
            child: const Icon(Icons.hearing, color: Colors.white24),
          ),
          Container(
            width: 30,
            height: 15,
            decoration: BoxDecoration(
              color: Colors.red[900],
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: Colors.red[700]!),
            ),
          ),
          Container(
            width: 35,
            height: 35,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [Colors.black87, Colors.grey[800]!],
              ),
              border: Border.all(color: Colors.black),
            ),
            child: const Icon(Icons.mic, color: Colors.white24, size: 18),
          ),
        ],
      ),
    );
  }

  // เป้าที่เป็นรูเสียบ (Connector Slot)
  Widget _buildConnectorSlot(
    double w,
    double h, {
    IconData icon = Icons.add_circle_outline,
  }) {
    return Container(
      width: w,
      height: h,
      decoration: BoxDecoration(
        color: Colors.black, // พื้นดำ
        shape: BoxShape.circle,
        // ขอบขาวจางๆ จำลองแสงตกกระทบขอบหลุม
        border: Border.all(color: Colors.white12, width: 2),
      ),
      child: Center(
        child: Icon(icon, color: Colors.amber.withOpacity(0.5), size: 20),
      ),
    );
  }

  // เป้าที่เป็นช่องใส่แบต (Empty Slot)
  Widget _buildEmptyBatterySlot() {
    return Container(
      width: 185,
      height: 75,
      decoration: BoxDecoration(
        color: const Color(0xFF000000), // พื้นดำสนิท
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20)),
        // ขอบเทาเข้ม จำลองขอบพลาสติก
        border: Border.all(color: Colors.white12, width: 2),
      ),
      child: Center(
        child: Text(
          "INSERT BATTERY PACK",
          style: GoogleFonts.orbitron(color: Colors.white24, fontSize: 10),
        ),
      ),
    );
  }

  Widget _buildCompleteBanner() {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        decoration: BoxDecoration(
          gradient: Colors.green.withOpacity(0.9).createGradient(),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.lightGreenAccent, width: 2),
          boxShadow: const [
            BoxShadow(color: Colors.black, blurRadius: 20, spreadRadius: 5),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.military_tech,
              color: Colors.white,
              size: 60,
              shadows: [Shadow(color: Colors.black, blurRadius: 10)],
            ),
            Text(
              "MISSION COMPLETE!",
              style: GoogleFonts.blackOpsOne(
                fontSize: 24,
                color: Colors.white,
                shadows: [const Shadow(color: Colors.black, blurRadius: 5)],
              ),
            ),
            const SizedBox(height: 15),
            ElevatedButton.icon(
              onPressed: _resetMission,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.green[900],
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
              ),
              icon: const Icon(Icons.restart_alt),
              label: const Text("ASSEMBLE AGAIN"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropZone({
    required String targetId,
    required bool isInstalled,
    required Widget installedWidget,
    required Widget ghostWidget,
    required VoidCallback onDropped,
  }) {
    return DragTarget<String>(
      builder: (context, candidateData, rejectedData) {
        bool isHovering =
            candidateData.isNotEmpty && candidateData.first == targetId;
        if (isInstalled) return installedWidget;
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: isHovering
                ? [
                    BoxShadow(
                      color: Colors.greenAccent.withOpacity(0.6),
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ]
                : null,
          ),
          child: ghostWidget,
        );
      },
      onWillAcceptWithDetails: (data) => data == targetId,
      onAcceptWithDetails: (data) => onDropped(),
    );
  }

  Widget _buildDraggablePart(String id, Widget child) {
    return Draggable<String>(
      data: id,
      feedback: Material(type: MaterialType.transparency, child: child),
      childWhenDragging: Opacity(opacity: 0.2, child: child),
      child: child,
    );
  }

  void _resetMission() {
    setState(() {
      isAntennaInstalled = false;
      isBatteryInstalled = false;
      isHandsetInstalled = false;
    });
  }
}

extension ColorExt on Color {
  LinearGradient createGradient() {
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [this, withOpacity(0.6)],
    );
  }
}
