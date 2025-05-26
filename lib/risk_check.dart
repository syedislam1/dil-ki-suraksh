import 'package:flutter/material.dart';
import 'heart_tips.dart';

class RiskCheckScreen extends StatefulWidget {
  final String language;

  RiskCheckScreen({required this.language});

  @override
  _RiskCheckScreenState createState() => _RiskCheckScreenState();
}

class _RiskCheckScreenState extends State<RiskCheckScreen> {
  late List<String> questions;
  late String yesText;
  late String noText;

  List<bool?> answers = List.filled(5, null); // Each answer can be true, false, or null

  @override
  void initState() {
    super.initState();
    bool isHindi = widget.language == 'hi';

    questions = isHindi
        ? [
      'क्या आप धूम्रपान करते हैं?',
      'क्या आपका पेट बाहर निकला हुआ है?',
      'क्या आप बहुत कम चलते हैं?',
      'क्या आप थकावट महसूस करते हैं?',
      'क्या आपके परिवार में दिल की बीमारी है?',
    ]
        : [
      'Do you smoke?',
      'Do you have abdominal obesity?',
      'Do you walk very little?',
      'Do you feel fatigued often?',
      'Is there a history of heart disease in your family?',
    ];

    yesText = isHindi ? 'हाँ' : 'Yes';
    noText = isHindi ? 'नहीं' : 'No';
  }

  String getRiskLevel() {
    int score = answers.where((a) => a == true).length;
    if (widget.language == 'hi') {
      if (score >= 4) return 'उच्च जोखिम';
      if (score >= 2) return 'मध्यम जोखिम';
      return 'न्यून जोखिम';
    } else {
      if (score >= 4) return 'High Risk';
      if (score >= 2) return 'Moderate Risk';
      return 'Low Risk';
    }
  }

  String getAdvice() {
    return widget.language == 'hi'
        ? 'अपने स्वास्थ्य का ध्यान रखें:\n- व्यायाम करें\n- धूम्रपान से बचें\n- संतुलित आहार लें\n- तनाव कम करें\n- नियमित जांच कराएं'
        : 'Take care of your health:\n- Exercise\n- Avoid smoking\n- Eat a balanced diet\n- Reduce stress\n- Get regular check-ups';
  }

  @override
  Widget build(BuildContext context) {
    bool isHindi = widget.language == 'hi';

    return Scaffold(
      appBar: AppBar(title: Text(isHindi ? 'जोखिम जांच' : 'Risk Check')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              isHindi
                  ? 'अपने दिल के स्वास्थ्य की जांच करें'
                  : 'Check your heart health',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            ...List.generate(questions.length, (index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    questions[index],
                    style: TextStyle(fontSize: 18),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => setState(() => answers[index] = true),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: answers[index] == true
                                ? Colors.green
                                : Colors.grey[300],
                            foregroundColor: Colors.black,
                          ),
                          child: Text(yesText),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => setState(() => answers[index] = false),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: answers[index] == false
                                ? Colors.red
                                : Colors.grey[300],
                            foregroundColor: Colors.black,
                          ),
                          child: Text(noText),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                ],
              );
            }),
            if (!answers.contains(null)) ...[
              Divider(),
              Text(
                isHindi ? 'आपका जोखिम स्तर:' : 'Your Risk Level:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                getRiskLevel(),
                style: TextStyle(fontSize: 22, color: Colors.deepPurple),
              ),
              SizedBox(height: 10),
              Text(
                getAdvice(),
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          HeartTipsScreen(language: widget.language),
                    ),
                  );
                },
                child: Text(isHindi ? 'दिल की सलाह देखें' : 'View Heart Tips'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
