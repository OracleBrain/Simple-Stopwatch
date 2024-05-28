import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final Stopwatch _stopwatch = Stopwatch();
  String _formattedTime = '00:00:00';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _formattedTime,
              style: const TextStyle(fontSize: 48),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    _startPauseTimer();
                  },
                  child: Text(_stopwatch.isRunning ? 'Pause' : 'Start'),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    _resetTimer();
                  },
                  child: const Text('Reset'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _startPauseTimer() {
    if (_stopwatch.isRunning) {
      _stopwatch.stop();
    } else {
      _stopwatch.start();
      _updateTimer();
    }
  }

  void _resetTimer() {
    _stopwatch.reset();
    _updateTimer();
  }

  void _updateTimer() {
    setState(() {
      _formattedTime = _formatTime(_stopwatch.elapsedMilliseconds);
      if (_stopwatch.isRunning) {
        Future.delayed(const Duration(milliseconds: 100), _updateTimer);
      }
    });
  }

  String _formatTime(int milliseconds) {
    int seconds = (milliseconds / 1000).truncate();
    int minutes = (seconds / 60).truncate();
    int hours = (minutes / 60).truncate();

    String formattedTime = '';

    formattedTime += '${(hours % 60).toString().padLeft(2, '0')}:';
    formattedTime += '${(minutes % 60).toString().padLeft(2, '0')}:';
    formattedTime += (seconds % 60).toString().padLeft(2, '0');

    return formattedTime;
  }
}
