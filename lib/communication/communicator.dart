import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class SignAnimator extends StatefulWidget {
  @override
  _SignAnimatorState createState() => _SignAnimatorState();
}

class _SignAnimatorState extends State<SignAnimator> {
  final TextEditingController _controller = TextEditingController();
  List<String> imagePaths = [];
  int currentIndex = 0;
  bool isPlaying = false;

  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _spokenText = '';

  final Map<String, String> signImages = {
    'A': 'assets/images/sign/A.png',
    'B': 'assets/images/sign/B.png',
    'C': 'assets/images/sign/C.png',
    'D': 'assets/images/sign/D.png',
    'E': 'assets/images/sign/E.png',
    'F': 'assets/images/sign/F.png',
    'G': 'assets/images/sign/G.png',
    'H': 'assets/images/sign/H.png',
    'I': 'assets/images/sign/I.png',
    'J': 'assets/images/sign/J.png',
    'K': 'assets/images/sign/K.png',
    'L': 'assets/images/sign/L.png',
    'M': 'assets/images/sign/M.png',
    'N': 'assets/images/sign/N.png',
    'O': 'assets/images/sign/O.png',
    'P': 'assets/images/sign/P.png',
    'Q': 'assets/images/sign/Q.png',
    'R': 'assets/images/sign/R.png',
    'S': 'assets/images/sign/S.png',
    'T': 'assets/images/sign/T.png',
    'U': 'assets/images/sign/U.png',
    'V': 'assets/images/sign/V.png',
    'W': 'assets/images/sign/W.png',
    'X': 'assets/images/sign/X.png',
    'Y': 'assets/images/sign/Y.png',
    'Z': 'assets/images/sign/Z.png',
  };

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  void convertTextToSign(String text) {
    setState(() {
      imagePaths = [];
      for (var letter in text.toUpperCase().split('')) {
        if (signImages.containsKey(letter)) {
          imagePaths.add(signImages[letter]!);
        }
      }
      currentIndex = 0;
    });

    if (imagePaths.isNotEmpty) {
      startAnimation();
    }
  }

  void startAnimation() async {
    setState(() {
      isPlaying = true;
    });

    for (int i = 0; i < imagePaths.length; i++) {
      if (!isPlaying) return;
      await Future.delayed(Duration(milliseconds: 800));
      if (mounted) {
        setState(() {
          currentIndex = i;
        });
      }
    }

    setState(() {
      isPlaying = false;
    });
  }

  void stopAnimation() {
    setState(() {
      isPlaying = false;
    });
  }

  void restartAnimation() {
    if (imagePaths.isNotEmpty) {
      setState(() {
        currentIndex = 0;
      });
      startAnimation();
    }
  }

  void listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize();
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (result) {
            setState(() {
              _spokenText = result.recognizedWords;
              _controller.text = _spokenText;
              convertTextToSign(_spokenText);
            });
          },
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sign Language Communicator")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: "Enter Text",
                border: OutlineInputBorder(),
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.send),
                      onPressed: () => convertTextToSign(_controller.text),
                    ),
                    IconButton(
                      icon: Icon(_isListening ? Icons.mic : Icons.mic_none),
                      onPressed: listen,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),

            // Optional: Show recognized voice text
            if (_spokenText.isNotEmpty)
              Text(
                'You said: $_spokenText',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),

            SizedBox(height: 20),

            // Display sign animation
            Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.grey[200],
                boxShadow: [
                  BoxShadow(color: Colors.black26, blurRadius: 10, spreadRadius: 2)
                ],
              ),
              child: Center(
                child: AnimatedSwitcher(
                  duration: Duration(milliseconds: 600),
                  transitionBuilder: (widget, animation) {
                    return FadeTransition(
                      opacity: animation,
                      child: ScaleTransition(scale: animation, child: widget),
                    );
                  },
                  child: imagePaths.isNotEmpty
                      ? Image.asset(
                          imagePaths[currentIndex],
                          key: ValueKey<String>(imagePaths[currentIndex]),
                          width: 200,
                          height: 200,
                        )
                      : Text(
                          "Enter text or speak to translate",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16, color: Colors.black54),
                        ),
                ),
              ),
            ),

            SizedBox(height: 20),

            // Control Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: restartAnimation,
                  icon: Icon(Icons.replay),
                  label: Text("Replay"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  ),
                ),
                SizedBox(width: 15),
                ElevatedButton.icon(
                  onPressed: stopAnimation,
                  icon: Icon(Icons.stop),
                  label: Text("Stop"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
