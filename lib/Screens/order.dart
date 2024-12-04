import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:fl_chart/fl_chart.dart';

class DoctorScreen extends StatefulWidget {
  @override
  _DoctorScreenState createState() => _DoctorScreenState();
}

class _DoctorScreenState extends State<DoctorScreen> {
  late VideoPlayerController _controller;
  int recoveryProgress = 45;
  List<String> tasks = [];
  List<bool> taskCompletionStatus = [];
  String encouragementMessage = "Keep going, you're doing great!";
  List<double> weeklyProgress = [50, 60, 65, 70, 80, 85, 90];

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/images/9669109-hd_1080_1920_25fps.mp4')
      ..initialize().then((_) {
        if (mounted) {
          setState(() {
            _controller.play();
            _controller.setLooping(true);
          });
        }
      }).catchError((error) {
        print("Error loading video: $error");
      });

    _generateDailyTasks();
  }

  void _generateDailyTasks() {
    tasks = [
      'Take medication',
      'Rest for 20 minutes',
      'Do breathing exercises',
      'Take a walk',
      'Check vitals',
    ];
    taskCompletionStatus = List<bool>.filled(tasks.length, false);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background video
          Positioned.fill(
            child: VideoPlayer(_controller),
          ),
          // Main content overlay
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(),
                    SizedBox(height: 20),
                    _buildProgressTracker(),
                    SizedBox(height: 20),
                    _buildDailyActivities(),
                    SizedBox(height: 20),
                    _buildWeeklyProgressGraph(),
                    SizedBox(height: 20),
                    _buildChatButton(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage('assets/images/profile.png'),
            ),
            SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Hello, Alex Mwera',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
                SizedBox(height: 8),
                Text('Let\'s work through your recovery!',
                    style: TextStyle(fontSize: 16, color: Colors.white70)),
              ],
            ),
          ],
        ),
        SizedBox(height: 20),
        Text(
          encouragementMessage,
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ],
    );
  }

  Widget _buildProgressTracker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Your Recovery Progress',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
        SizedBox(height: 10),
        Center(
          child: SizedBox(
            width: 150,
            height: 150,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CircularProgressIndicator(
                  value: recoveryProgress / 100,
                  strokeWidth: 10,
                  backgroundColor: Colors.grey[300],
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                ),
                Text(
                  '$recoveryProgress%',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDailyActivities() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Today\'s Activities',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
        SizedBox(height: 10),
        ...List.generate(tasks.length, (index) {
          return _buildActivityItem(tasks[index], index);
        }),
        SizedBox(height: 20),
        _buildActivityProgress(),
      ],
    );
  }

  Widget _buildActivityItem(String task, int index) {
    return Card(
      margin: EdgeInsets.only(bottom: 10),
      elevation: 5,
      color: Colors.white.withOpacity(0.8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        title: Text(task, style: TextStyle(fontSize: 16)),
        trailing: Checkbox(
          value: taskCompletionStatus[index],
          onChanged: (bool? value) {
            setState(() {
              taskCompletionStatus[index] = value ?? false;
            });
          },
        ),
      ),
    );
  }

  Widget _buildActivityProgress() {
    int completedTasks = taskCompletionStatus.where((status) => status).length;
    double progress = completedTasks / tasks.length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Activity Completion Progress',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
        SizedBox(height: 10),
        LinearProgressIndicator(
          value: progress,
          minHeight: 12,
          backgroundColor: Colors.grey[300],
          color: Colors.blue,
        ),
        SizedBox(height: 10),
        Text('$completedTasks of ${tasks.length} tasks completed',
            style: TextStyle(fontSize: 16, color: Colors.white)),
      ],
    );
  }

  Widget _buildWeeklyProgressGraph() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Weekly Progress',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
        SizedBox(height: 10),
        AspectRatio(
          aspectRatio: 1.5,
          child: LineChart(
            LineChartData(
              gridData: FlGridData(show: false),
              titlesData: FlTitlesData(
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 40,
                    interval: 20,
                    getTitlesWidget: (value, meta) => Text(
                      '${value.toInt()}%',
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
                      return Text(
                        days[value.toInt()],
                        style: const TextStyle(color: Colors.white, fontSize: 12),
                      );
                    },
                  ),
                ),
              ),
              borderData: FlBorderData(show: false),
              lineBarsData: [
                LineChartBarData(
                  spots: List.generate(
                    weeklyProgress.length,
                    (index) => FlSpot(index.toDouble(), weeklyProgress[index]),
                  ),
                  isCurved: true,
                  color: Colors.deepOrange,
                  barWidth: 4,
                  isStrokeCapRound: true,
                  belowBarData: BarAreaData(show: false),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildChatButton() {
    return Center(
      child: GestureDetector(
        onTap: _showChatDialog,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 36),
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(30),
            boxShadow: const [BoxShadow(color: Colors.black26, spreadRadius: 2, blurRadius: 10)],
          ),
          child: const Text(
            'Chat with Dr. Recovery',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      ),
    );
  }

  void _showChatDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Ask Dr. Recovery'),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('You can ask questions about your recovery process, and Dr. Recovery will assist you!'),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(hintText: 'Type your question...'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {},
              child: const Text('Send'),
            ),
          ],
        );
      },
    );
  }
}