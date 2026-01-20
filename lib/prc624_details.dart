import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:google_fonts/google_fonts.dart';

class Prc624DetailScreen extends StatefulWidget {
  const Prc624DetailScreen({super.key});

  @override
  State<Prc624DetailScreen> createState() => _Prc624DetailScreenState();
}

class _Prc624DetailScreenState extends State<Prc624DetailScreen> {
  // ✅ ใช้ assets/assets/ (ถูกต้องตามที่เทสผ่าน)
  final String _gh3DBase =
      "https://saisansan11.github.io/military_sim_2026/assets/assets/models/";

  final List<Map<String, dynamic>> parts = [
    {'id': 'FULL', 'name': 'AN/PRC-624 (FULL)', 'file': 'prc624.glb'},
    {'id': 'RT-624', 'name': 'Receiver-Transmitter', 'file': 'body.glb'},
    {'id': 'BASE', 'name': 'Antenna Base', 'file': 'antenna_base.glb'},
    {'id': 'WHIP', 'name': 'Antenna Whip', 'file': 'antenna_whip.glb'},
    {'id': 'BATT', 'name': 'Battery (BA-624)', 'file': 'battery.glb'},
  ];

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    String currentModelUrl = "$_gh3DBase${parts[selectedIndex]['file']}";

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        // เปลี่ยนชื่อหัวข้อให้รู้ว่าแก้ถูกไฟล์แล้ว
        title: Text(
          "SPECIFICATIONS (FIXED)",
          style: GoogleFonts.blackOpsOne(color: const Color(0xFF00FF41)),
        ),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Color(0xFF00FF41)),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[800]!),
                borderRadius: BorderRadius.circular(12),
                color: Colors.black,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: ModelViewer(
                  key: ValueKey(currentModelUrl),
                  src: currentModelUrl, // ✅ ลิ้งก์ถูกต้องแน่นอน
                  alt: "A 3D model",
                  ar: true,
                  autoRotate: true,
                  cameraControls: true,
                  backgroundColor: Colors.transparent,
                  loading: Loading.eager,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Color(0xFF1E1E1E),
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "SPECIFICATIONS",
                    style: GoogleFonts.blackOpsOne(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(10),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      _getSpecText(parts[selectedIndex]['id']),
                      style: GoogleFonts.sarabun(
                        color: const Color(0xFF00FF41),
                        fontSize: 12,
                      ),
                    ),
                  ),
                  const Spacer(),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: parts.asMap().entries.map((entry) {
                        int idx = entry.key;
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: ChoiceChip(
                            label: Text(
                              entry.value['id'],
                              style: GoogleFonts.blackOpsOne(),
                            ),
                            selected: idx == selectedIndex,
                            selectedColor: const Color(0xFF00FF41),
                            onSelected: (val) {
                              if (val) setState(() => selectedIndex = idx);
                            },
                          ),
                        );
                      }).toList(),
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

  String _getSpecText(String id) {
    switch (id) {
      case 'FULL':
        return "• System: AN/PRC-624\n• Freq: 30-88 MHz";
      case 'RT-624':
        return "• Power: 1-2 Watts\n• Channels: 2,320";
      case 'BASE':
        return "• Connector: TNC Type";
      case 'WHIP':
        return "• Length: 1.2m (Flexible)";
      case 'BATT':
        return "• Type: Li-ion 7.4V";
      default:
        return "N/A";
    }
  }
}
