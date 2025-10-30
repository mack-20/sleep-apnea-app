import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:sleep_apnea_app/features/profiles/data/profile_model.dart';

// Data models for monitoring
class VitalSignsData {
  final int oxygenLevel;
  final int pulseRate;
  final List<BreathingRatePoint> breathingRatePoints;
  final List<ApneaEvent> apneaEvents;

  VitalSignsData({
    required this.oxygenLevel,
    required this.pulseRate,
    required this.breathingRatePoints,
    required this.apneaEvents,
  });
}

class BreathingRatePoint {
  final DateTime timestamp;
  final double rate;

  BreathingRatePoint({required this.timestamp, required this.rate});
}

class ApneaEvent {
  final DateTime timestamp;
  final int count;

  ApneaEvent({required this.timestamp, required this.count});
}

class HomePage extends StatefulWidget {
  final ProfileModel profile;

  const HomePage({super.key, required this.profile});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isConnected = false;
  int batteryLevel = 75;
  
  // Mock data - Replace with actual Bluetooth stream data
  VitalSignsData? vitalSignsData;

  @override
  void initState() {
    super.initState();
    // Simulate initial data - Replace with Bluetooth listener
    _loadMockData();
  }

  void _loadMockData() {
    // TODO: Replace this with actual Bluetooth data stream
    setState(() {
      vitalSignsData = VitalSignsData(
        oxygenLevel: 91,
        pulseRate: 128,
        breathingRatePoints: [
          BreathingRatePoint(timestamp: DateTime.now().subtract(Duration(minutes: 4)), rate: 8.5),
          BreathingRatePoint(timestamp: DateTime.now().subtract(Duration(minutes: 3)), rate: 2.0),
          BreathingRatePoint(timestamp: DateTime.now().subtract(Duration(minutes: 2)), rate: 6.5),
          BreathingRatePoint(timestamp: DateTime.now().subtract(Duration(minutes: 1)), rate: 1.5),
          BreathingRatePoint(timestamp: DateTime.now(), rate: 9.0),
        ],
        apneaEvents: [
          ApneaEvent(timestamp: DateTime.now().subtract(Duration(minutes: 4)), count: 4),
          ApneaEvent(timestamp: DateTime.now().subtract(Duration(minutes: 3)), count: 4),
          ApneaEvent(timestamp: DateTime.now().subtract(Duration(minutes: 2)), count: 5),
          ApneaEvent(timestamp: DateTime.now().subtract(Duration(minutes: 1)), count: 5),
          ApneaEvent(timestamp: DateTime.now(), count: 6),
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildVitalSignsRow(),
                    const SizedBox(height: 24),
                    _buildBreathingRateChart(),
                    const SizedBox(height: 24),
                    _buildApneicOccurrencesChart(),
                    const SizedBox(height: 80), // Space for bottom nav
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigation(),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          // Baby icon with status
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: const Color(0xFFFF6B6B),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.child_care, color: Colors.white, size: 32),
          ),
          const SizedBox(width: 12),
          // Device name and status
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Infant Apnea Monitor',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  isConnected ? 'Connected' : 'Disconnected',
                  style: TextStyle(
                    fontSize: 13,
                    color: isConnected ? Colors.green : const Color(0xFFFF6B6B),
                  ),
                ),
              ],
            ),
          ),
          // Battery indicator
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 2),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              children: [
                Icon(
                  batteryLevel > 20 ? Icons.battery_std : Icons.battery_alert,
                  size: 20,
                ),
                const SizedBox(width: 4),
                Text('$batteryLevel%', style: const TextStyle(fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVitalSignsRow() {
    return Row(
      children: [
        Expanded(
          child: _buildVitalSignCard(
            'Oxygen Level',
            '${vitalSignsData?.oxygenLevel ?? '--'}%',
            Colors.blue.shade50,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildVitalSignCard(
            'Pulse Rate',
            '${vitalSignsData?.pulseRate ?? '--'} /min',
            Colors.red.shade50,
          ),
        ),
      ],
    );
  }

  Widget _buildVitalSignCard(String label, String value, Color bgColor) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBreathingRateChart() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Breathing Rate',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          height: 220,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(12),
          ),
          child: vitalSignsData?.breathingRatePoints.isEmpty ?? true
              ? const Center(
                  child: Text(
                    'No data points',
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                )
              : LineChart(
                  LineChartData(
                    gridData: FlGridData(show: false),
                    titlesData: FlTitlesData(
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          interval: 2.5,
                          reservedSize: 30,
                          getTitlesWidget: (value, meta) {
                            return Text(
                              value.toInt().toString(),
                              style: const TextStyle(fontSize: 10),
                            );
                          },
                        ),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          interval: 1,
                          getTitlesWidget: (value, meta) {
                            return Text(
                              'Te\nxt',
                              style: const TextStyle(fontSize: 9),
                              textAlign: TextAlign.center,
                            );
                          },
                        ),
                      ),
                      rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    ),
                    borderData: FlBorderData(show: false),
                    minY: 0,
                    maxY: 10,
                    lineBarsData: [
                      LineChartBarData(
                        spots: _getBreathingRateSpots(),
                        isCurved: true,
                        color: const Color(0xFFFF6B6B),
                        barWidth: 3,
                        dotData: FlDotData(show: false),
                        belowBarData: BarAreaData(show: false),
                      ),
                    ],
                  ),
                ),
        ),
      ],
    );
  }

  Widget _buildApneicOccurrencesChart() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Apneic Occurrences',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          height: 220,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(12),
          ),
          child: vitalSignsData?.apneaEvents.isEmpty ?? true
              ? const Center(
                  child: Text(
                    'No data points',
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                )
              : BarChart(
                  BarChartData(
                    alignment: BarChartAlignment.spaceEvenly,
                    gridData: FlGridData(show: false),
                    titlesData: FlTitlesData(
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          interval: 2.5,
                          reservedSize: 30,
                          getTitlesWidget: (value, meta) {
                            return Text(
                              value.toInt().toString(),
                              style: const TextStyle(fontSize: 10),
                            );
                          },
                        ),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            return Text(
                              'Te\nxt',
                              style: const TextStyle(fontSize: 9),
                              textAlign: TextAlign.center,
                            );
                          },
                        ),
                      ),
                      rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    ),
                    borderData: FlBorderData(show: false),
                    minY: 0,
                    maxY: 10,
                    barGroups: _getApneaBarGroups(),
                  ),
                ),
        ),
      ],
    );
  }

  Widget _buildBottomNavigation() {
    return Container(
      height: 70,
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFF6B6B),
        borderRadius: BorderRadius.circular(35),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline, color: Colors.white, size: 28),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.history, color: Colors.white, size: 28),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: Colors.white, size: 28),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.settings_outlined, color: Colors.white, size: 28),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  List<FlSpot> _getBreathingRateSpots() {
    if (vitalSignsData?.breathingRatePoints == null) return [];
    
    final points = vitalSignsData!.breathingRatePoints;
    return List.generate(
      points.length,
      (index) => FlSpot(index.toDouble(), points[index].rate),
    );
  }

  List<BarChartGroupData> _getApneaBarGroups() {
    if (vitalSignsData?.apneaEvents == null) return [];
    
    final events = vitalSignsData!.apneaEvents;
    return List.generate(
      events.length,
      (index) => BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: events[index].count.toDouble(),
            color: const Color(0xFFFF6B6B),
            width: 16,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      ),
    );
  }
}