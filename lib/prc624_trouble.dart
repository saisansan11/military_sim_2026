import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Prc624TroubleScreen extends StatefulWidget {
  const Prc624TroubleScreen({super.key});

  @override
  State<Prc624TroubleScreen> createState() => _Prc624TroubleScreenState();
}

class _Prc624TroubleScreenState extends State<Prc624TroubleScreen> {
  int totalScore = 0;
  int currentScenarioIndex = 0;
  int? selectedAnswer;
  bool answered = false;
  bool isCorrect = false;

  final List<Map<String, dynamic>> scenarios = [
    {
      "symptom":
          "เครื่องเปิดติด หน้าจอปกติ แต่ไม่มีเสียงสัญญาณใดๆ แม้แต่เสียงซ่า (Noise) เมื่อเปิด SQL Off",
      "options": [
        "แบตเตอรี่เสื่อม",
        "ลำโพงภายในหรือชุดหูฟังชำรุด",
        "เสาอากาศหักภายใน",
        "ตั้งช่องความถี่ผิด",
      ],
      "correctIndex": 1,
      "hint": "ถ้า SQL Off แล้วยังเงียบสนิท ปัญหาอยู่ที่ภาคเสียง (Audio Path)",
    },
    {
      "symptom":
          "ส่งสัญญาณออกไปแล้ว เพื่อนตอบกลับมาว่า 'เสียงเบามากและมีเสียงฮัม' (Humming)",
      "options": [
        "แบตเตอรี่อ่อน",
        "พูดห่างไมโครโฟนเกินไป",
        "ฝาครอบช่องเสียบ Audio (U-229) หลวมหรือสกปรก",
        "เสาอากาศผิดขนาด",
      ],
      "correctIndex": 2,
      "hint": "ขั้วต่อที่สกปรกทำให้เกิดความต้านทานและสัญญาณ rบกวนในสายไมค์",
    },
    {
      "symptom": "เครื่องร้อนจัดหลังจากกดส่งสัญญาณ (PTT) เพียงไม่กี่ครั้ง",
      "options": [
        "ใช้งานกลางแดด",
        "ค่า VSWR สูง (เสาอากาศชำรุด/ไม่ตรงย่าน)",
        "เปิดระดับเสียงดังเกินไป",
        "แบตเตอรี่ลัดวงจรภายใน",
      ],
      "correctIndex": 1,
      "hint":
          "แรงสะท้อนกลับจากเสาอากาศที่ชำรุดจะย้อนกลับมาเผาภาคส่ง (Final Amp)",
    },
    {
      "symptom": "หน้าจอแสดงตัวเลขความถี่ไม่ครบ (บางขีดหายไป)",
      "options": [
        "ถอดแบตเตอรี่ออกแล้วใส่ใหม่",
        "ส่งซ่อมระดับหน่วย (เปลี่ยนโมดูลหน้าจอ)",
        "เคาะเครื่องแรงๆ",
        "ปรับปุ่ม Volume",
      ],
      "correctIndex": 1,
      "hint":
          "อาการหน้าจอขาดส่วน (Missing Segments) เป็นปัญหาที่ฮาร์ดแวร์ภายใน",
    },
    {
      "symptom":
          "กดปุ่ม FUNCTION แล้วเครื่องไม่ตอบสนอง แต่ปุ่มหมุน Channel ยังใช้งานได้",
      "options": [
        "ปุ่มยางสกปรก/ค้าง",
        "เปิดระบบ Keypad Lock ไว้",
        "เครื่องแฮงค์ (Hang)",
        "แบตเตอรี่ใกล้หมด",
      ],
      "correctIndex": 1,
      "hint": "PRC-624 มีระบบป้องกันการกดปุ่มโดยไม่ตั้งใจ (Lock Symbol บนจอ)",
    },
    {
      "symptom": "รับสัญญาณได้ แต่มีเสียงวี๊ด (Whining) แทรกตลอดเวลา",
      "options": [
        "สายอากาศอยู่ใกล้สายไฟแรงสูง",
        "เครื่องส่งฝั่งตรงข้ามเสีย",
        "วงจรกรองกระแสภายในเสื่อม",
        "ใช้แบตเตอรี่ผิดประเภท",
      ],
      "correctIndex": 2,
      "hint": "เสียงวี๊ดตามจังหวะไฟมักเกิดจากตัวเก็บประจุภายในภาคจ่ายไฟรั่ว",
    },
    {
      "symptom":
          "หมุนปุ่มความถี่แล้ว ตัวเลขบนหน้าจอกระโดดข้ามไปมา ไม่เรียงลำดับ",
      "options": [
        "ปุ่มเลือกช่อง (Encoder) เสีย/สกปรก",
        "ซอฟต์แวร์เครื่องรวน",
        "แบตเตอรี่แรงดันเกิน",
        "ต้องกด reset",
      ],
      "correctIndex": 0,
      "hint": "หน้าสัมผัสภายในปุ่มหมุน (Selector Switch) สึกหรอหรือมีคราบไขมัน",
    },
    {
      "symptom":
          "เครื่องรีเซ็ตตัวเอง (ดับแล้วติดใหม่) ทันทีที่กดส่งสัญญาณ (PTT)",
      "options": [
        "แบตเตอรี่จ่ายกระแสไม่พอ (Voltage Drop)",
        "เสาอากาศชอร์ตลงดิน",
        "ปุ่ม PTT ลัดวงจร",
        "ความถี่ที่ตั้งไว้ไม่ได้รับอนุญาต",
      ],
      "correctIndex": 0,
      "hint": "ภาคส่งใช้ไฟสูงมาก ถ้าแบตเตอรี่เสื่อมแรงดันจะตกจนเครื่องดับ",
    },
    {
      "symptom": "มีกลิ่นไหม้ออกมาจากบริเวณช่องเสียบแบตเตอรี่",
      "options": [
        "ฝุ่นไหม้",
        "ขั้วแบตเตอรี่ลัดวงจร",
        "เครื่องทำงานหนักเกินไป",
        "แบตเตอรี่กำลังชาร์จ",
      ],
      "correctIndex": 1,
      "hint":
          "กลิ่นไหม้ในอุปกรณ์ไฟฟ้าคือสัญญาณอันตรายร้ายแรง ห้ามเปิดเครื่องเด็ดขาด",
    },
    {
      "symptom": "หน้าจอ LCD แสดงข้อความ 'ERR 01' หรือรหัสผิดพลาด",
      "options": [
        "เครื่องติดไวรัส",
        "ตั้งช่องความถี่ซ้ำกัน",
        "ระบบตรวจสอบตัวเองพบความผิดปกติภายใน (Internal Failure)",
        "ลืมใส่เสาอากาศ",
      ],
      "correctIndex": 2,
      "hint": "รหัส Error code หมายถึงจุดเสียเฉพาะที่ต้องใช้ช่างเทคนิคตรวจสอบ",
    },
  ];

  void checkAnswer(int index) {
    if (answered) return;
    setState(() {
      selectedAnswer = index;
      answered = true;
      isCorrect = (index == scenarios[currentScenarioIndex]['correctIndex']);
      if (isCorrect) totalScore += 10;
    });
  }

  void nextScenario() {
    if (currentScenarioIndex < scenarios.length - 1) {
      setState(() {
        currentScenarioIndex++;
        selectedAnswer = null;
        answered = false;
      });
    } else {
      showFinalScore();
    }
  }

  void showFinalScore() {
    String rank = totalScore >= 80
        ? "จ่าสื่อสารมือฉมัง"
        : (totalScore >= 50 ? "สิบตรีชำนาญการ" : "พลทหารฝึกหัด");
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.black,
        title: Text(
          "INSPECTION REPORT",
          style: GoogleFonts.blackOpsOne(color: const Color(0xFF00FF41)),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "คะแนนรวม: $totalScore / 100",
              style: const TextStyle(color: Colors.white, fontSize: 20),
            ),
            const SizedBox(height: 10),
            Text(
              "ระดับความสามารถ: $rank",
              style: const TextStyle(
                color: Color(0xFF00FF41),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                currentScenarioIndex = 0;
                totalScore = 0;
                selectedAnswer = null;
                answered = false;
              });
            },
            child: const Text(
              "RETAKE EXAM",
              style: TextStyle(color: Colors.orange),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text("EXIT", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final scenario = scenarios[currentScenarioIndex];

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        title: Text(
          "TROUBLESHOOTING",
          style: GoogleFonts.blackOpsOne(color: const Color(0xFF00FF41)),
        ),
        backgroundColor: Colors.black,
        actions: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Text(
                "SCORE: $totalScore",
                style: GoogleFonts.blackOpsOne(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            LinearProgressIndicator(
              value: (currentScenarioIndex + 1) / scenarios.length,
              backgroundColor: Colors.grey[800],
              color: const Color(0xFF00FF41),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1E1E1E),
                border: Border.all(color: Colors.orange, width: 2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  const Icon(Icons.biotech, color: Colors.orange, size: 30),
                  const SizedBox(height: 10),
                  Text(
                    scenario['symptom'],
                    textAlign: TextAlign.center,
                    style: GoogleFonts.sarabun(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: scenario['options'].length,
                itemBuilder: (context, index) {
                  bool isSelected = selectedAnswer == index;
                  bool isCorrectAnswer = scenario['correctIndex'] == index;

                  Color borderColor = Colors.grey[700]!;
                  if (answered) {
                    if (isCorrectAnswer) {
                      borderColor = Colors.green;
                    } else if (isSelected)
                      borderColor = Colors.red;
                  }

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: InkWell(
                      onTap: () => checkAnswer(index),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Colors.black
                              : const Color(0xFF1E1E1E),
                          border: Border.all(color: borderColor, width: 2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          scenario['options'][index],
                          style: GoogleFonts.sarabun(color: Colors.white),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            if (answered) ...[
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  "💡 คำแนะนำ: ${scenario['hint']}",
                  style: GoogleFonts.sarabun(
                    color: Colors.orange[300],
                    fontSize: 13,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: nextScenario,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00FF41),
                  ),
                  child: Text(
                    currentScenarioIndex < scenarios.length - 1
                        ? "NEXT STEP"
                        : "VIEW RESULTS",
                    style: GoogleFonts.blackOpsOne(color: Colors.black),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
