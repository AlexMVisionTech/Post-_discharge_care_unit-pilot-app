import 'package:flutter/material.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text('Weather'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF1A237E), // Deep night blue
              Color(0xFF3949AB), // Royal blue
              Color(0xFF5C6BC0), // Lighter blue
            ],
          ),
        ),
        child: Stack(
          children: [
            // Animated weather particles (stars/rain/snow)
            ...List.generate(
              20,
              (index) => Positioned(
                left: index * 20.0,
                top: index * 30.0,
                child: Opacity(
                  opacity: 0.3,
                  child: Icon(
                    Icons.star,
                    color: Colors.white,
                    size: 10,
                  ),
                ),
              ),
            ),
            CustomScrollView(
              physics: BouncingScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: SafeArea(
                    child: Column(
                      children: [
                        _buildCurrentWeather(),
                        _buildHourlyForecast(),
                        _buildDetailsCard(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrentWeather() {
    return Container(
      padding: EdgeInsets.all(32),
      child: Column(
        children: [
          Text(
            'Daystar Athi River',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w300,
              letterSpacing: 5,
            ),
          ),
          SizedBox(height: 20),
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white.withOpacity(0.2),
                  Colors.white.withOpacity(0.1),
                ],
              ),
              border: Border.all(
                color: Colors.white.withOpacity(0.2),
                width: 2,
              ),
            ),
            child: Column(
              children: [
                Icon(
                  Icons.wb_sunny,
                  color: Colors.orange,
                  size: 64,
                ),
                SizedBox(height: 10),
                Text(
                  '59.9°F',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 48,
                    fontWeight: FontWeight.w200,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Text(
            'PARTLY CLOUDY',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 16,
              letterSpacing: 3,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHourlyForecast() {
    return Container(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16),
        itemCount: 24,
        itemBuilder: (context, index) {
          return Container(
            width: 80,
            margin: EdgeInsets.symmetric(horizontal: 8),
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: Colors.white24,
                width: 1,
              ),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white.withOpacity(0.2),
                  Colors.white.withOpacity(0.1),
                ],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  '${index}:00',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
                Icon(
                  Icons.wb_sunny,
                  color: Colors.orange,
                  size: 24,
                ),
                Text(
                  '${60 + index}°',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildDetailsCard() {
    return Container(
      margin: EdgeInsets.all(24),
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withOpacity(0.2),
            Colors.white.withOpacity(0.1),
          ],
        ),
        border: Border.all(
          color: Colors.white24,
          width: 1,
        ),
      ),
      child: Column(
        children: [
          _buildDetailRow(Icons.water_drop, 'Humidity', '65%'),
          Divider(color: Colors.white24, height: 30),
          _buildDetailRow(Icons.air, 'Wind Speed', '8.5 mph'),
          Divider(color: Colors.white24, height: 30),
          _buildDetailRow(Icons.thermostat, 'Feels Like', '58°F'),
        ],
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(icon, color: Colors.white70, size: 24),
            SizedBox(width: 12),
            Text(
              label,
              style: TextStyle(
                color: Colors.white70,
                fontSize: 16,
              ),
            ),
          ],
        ),
        Text(
          value,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}