import 'package:flutter/material.dart';

class Goal {
  String id;
  String title;
  int points;
  DateTime date;
  IconData icon;
  bool isCompleted;

  Goal({
    required this.id,
    required this.title,
    required this.points,
    required this.date,
    required this.icon,
    this.isCompleted = false,
  });
}

class GoalsScreen extends StatefulWidget {
  @override
  _PostDischargeGoalsScreenState createState() => _PostDischargeGoalsScreenState();
}

class _PostDischargeGoalsScreenState extends State<GoalsScreen> {
  List<Goal> goals = [
    Goal(
      id: '1',
      title: '10,000 steps walking',
      points: 1,
      date: DateTime.now(),
      icon: Icons.directions_walk,
    ),
    Goal(
      id: '2',
      title: 'Take medications',
      points: 3,
      date: DateTime.now(),
      icon: Icons.medication,
    ),
    Goal(
      id: '3',
      title: 'Follow-up appointment',
      points: 2,
      date: DateTime.now(),
      icon: Icons.calendar_today,
    ),
  ];

  int totalPoints = 12;
  int targetPoints = 150;

  void _editGoal(Goal goal) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit Goal'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Goal Title'),
              controller: TextEditingController(text: goal.title),
              onChanged: (value) {
                goal.title = value;
              },
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Points'),
              controller: TextEditingController(text: goal.points.toString()),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                goal.points = int.tryParse(value) ?? goal.points;
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {});
              Navigator.pop(context);
            },
            child: Text('Save'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text('Goals'),
      ),
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Your Progress',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.blue[100],
                          child: Icon(Icons.person, color: Colors.blue),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Text(
                            '$totalPoints pts',
                            style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Your score this week',
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(height: 10),
                          LinearProgressIndicator(
                            value: totalPoints / targetPoints,
                            backgroundColor: Colors.grey[200],
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.green,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Target: $targetPoints pts',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final goal = goals[index];
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.blue[100],
                          child: Icon(goal.icon, color: Colors.blue),
                        ),
                        title: Text(goal.title),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('${goal.points} pts'),
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () => _editGoal(goal),
                            ),
                            Checkbox(
                              value: goal.isCompleted,
                              onChanged: (value) {
                                setState(() {
                                  goal.isCompleted = value!;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                childCount: goals.length,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
         
          setState(() {
            goals.add(Goal(
              id: DateTime.now().toString(),
              title: 'New Goal',
              points: 1,
              date: DateTime.now(),
              icon: Icons.star,
            ));
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}