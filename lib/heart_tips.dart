import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class HeartTipsScreen extends StatefulWidget {
  final String language;

  HeartTipsScreen({required this.language});

  @override
  _HeartTipsScreenState createState() => _HeartTipsScreenState();
}

class _HeartTipsScreenState extends State<HeartTipsScreen> {
  final FlutterTts flutterTts = FlutterTts();

  @override
  void initState() {
    super.initState();
    _setLanguage();
  }

  void _setLanguage() async {
    if (widget.language == 'hi') {
      await flutterTts.setLanguage("hi-IN");
    } else {
      await flutterTts.setLanguage("en-US");
    }
    await flutterTts.setSpeechRate(0.5); // optional: slower speech
  }

  void _speak(String text) async {
    await flutterTts.stop();
    await flutterTts.speak(text);
  }

  @override
  void dispose() {
    flutterTts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isHindi = widget.language == 'hi';
    String heading = isHindi ? 'स्वस्थ दिल के लिए सुझाव:' : 'Tips for a Healthy Heart:';
    String tips = isHindi
        ? '- संतुलित आहार लें\n- नियमित व्यायाम करें\n- धूम्रपान न करें\n- तनाव कम करें\n- नियमित जांच कराएं'
        : '- Eat a balanced diet\n- Exercise regularly\n- Avoid smoking\n- Manage stress\n- Get regular checkups';

    return Scaffold(
      appBar: AppBar(title: Text(isHindi ? 'दिल की सलाह' : 'Heart Tips')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    heading,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.volume_up),
                  onPressed: () => _speak("$heading\n$tips"),
                )
              ],
            ),
            SizedBox(height: 12),
            Text(tips, style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
