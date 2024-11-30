import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../utils/responsive_helper.dart';

class StatsChart extends StatefulWidget {
  @override
  _StatsChartState createState() => _StatsChartState();
}

class _StatsChartState extends State<StatsChart> {
  String selectedPeriod = 'Month';
  
  final Map<String, List<FlSpot>> chartData = {
    'Day': [
      FlSpot(1, 15),  // Monday
      FlSpot(2, 22),  // Tuesday
      FlSpot(3, 18),  // Wednesday
      FlSpot(4, 25),  // Thursday
      FlSpot(5, 20),  // Friday
      FlSpot(6, 28),  // Saturday
      FlSpot(7, 24),  // Sunday
    ],
    'Month': [
      FlSpot(1, 15),   // Day 1
      FlSpot(5, 18),   // Day 5
      FlSpot(10, 22),  // Day 10
      FlSpot(15, 20),  // Day 15
      FlSpot(20, 25),  // Day 20
      FlSpot(25, 23),  // Day 25
      FlSpot(30, 28),  // Day 30
    ],
    'Year': [
      FlSpot(0, 15),   // Jan
      FlSpot(1, 18),   // Feb
      FlSpot(2, 14),   // Mar
      FlSpot(3, 22),   // Apr
      FlSpot(4, 19),   // May
      FlSpot(5, 25),   // Jun
      FlSpot(6, 23),   // Jul
      FlSpot(7, 28),   // Aug
      FlSpot(8, 24),   // Sep
      FlSpot(9, 27),   // Oct
      FlSpot(10, 25),  // Nov
      FlSpot(11, 30),  // Dec
    ],
  };

  Map<String, List<String>> periodLabels = {
    'Day': ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
    'Month': ['1', '5', '10', '15', '20', '25', '30'],
    'Year': ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
  };

  @override
  Widget build(BuildContext context) {
    double maxY = selectedPeriod == 'Year' ? 35 : 30;
    double interval = selectedPeriod == 'Year' ? 7 : 5;
    bool isMobile = MediaQuery.of(context).size.width < 600;

    return Container(
      width: MediaQuery.of(context).size.width,
      height: isMobile ? 260 : 400,
      child: Column(
        children: [
          // Time period selector
          Container(
            margin: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 24),
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(43),
              boxShadow: [
                BoxShadow(
                  color: Color(0x141A1F44),
                  blurRadius: 60,
                  offset: Offset(0, 16),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: ['Day', 'Month', 'Year'].map((period) => 
                _buildPeriodButton(period, isMobile)
              ).toList(),
            ),
          ),
          SizedBox(height: isMobile ? 16 : 20),
          // Chart
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                right: isMobile ? 8 : 16,
                left: isMobile ? 0 : 8,
                top: isMobile ? 8 : 16,
                bottom: isMobile ? 8 : 16,
              ),
              child: LineChart(
                LineChartData(
                  minX: selectedPeriod == 'Day' ? 1 : 0,
                  maxX: selectedPeriod == 'Day' ? 7 : 
                        selectedPeriod == 'Month' ? 30 : 11,
                  minY: 0,
                  maxY: maxY,
                  gridData: FlGridData(
                    show: true,
                    drawHorizontalLine: true,
                    drawVerticalLine: false,
                    horizontalInterval: interval,
                    getDrawingHorizontalLine: (value) {
                      return FlLine(
                        color: Colors.grey.withOpacity(0.2),
                        strokeWidth: 1,
                      );
                    },
                  ),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: selectedPeriod == 'Year' ? 20 : 10,
                        getTitlesWidget: (value, meta) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: Text(
                              '\$${value.toInt()}k',
                              style: TextStyle(
                                color: Color(0xFF8A8A8A),
                                fontSize: ResponsiveHelper.getBodySize(context),
                                fontFamily: 'HK Grotesk',
                              ),
                            ),
                          );
                        },
                        reservedSize: 40,
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          final labels = periodLabels[selectedPeriod]!;
                          final index = value.toInt();
                          if (index >= 0 && index < labels.length) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Text(
                                labels[index],
                                style: TextStyle(
                                  color: Color(0xFF8A8A8A),
                                  fontSize: ResponsiveHelper.getBodySize(context),
                                  fontFamily: 'HK Grotesk',
                                ),
                              ),
                            );
                          }
                          return Text('');
                        },
                        reservedSize: 30,
                      ),
                    ),
                    topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots: chartData[selectedPeriod]!,
                      isCurved: true,
                      color: Color(0xFF608EE9),
                      barWidth: 2,
                      isStrokeCapRound: true,
                      dotData: FlDotData(
                        show: true,
                        getDotPainter: (spot, percent, barData, index) {
                          return FlDotCirclePainter(
                            radius: 4,
                            color: Colors.white,
                            strokeWidth: 2,
                            strokeColor: Color(0xFF608EE9),
                          );
                        },
                      ),
                      belowBarData: BarAreaData(
                        show: true,
                        color: Color(0xFF608EE9).withOpacity(0.1),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPeriodButton(String period, bool isMobile) {
    bool isSelected = selectedPeriod == period;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPeriod = period;
        });
      },
      child: Container(
        width: isSelected ? 100 : 70,
        height: 40,
        decoration: BoxDecoration(
          color: isSelected ? Color(0xFF608EE9) : Colors.transparent,
          borderRadius: BorderRadius.circular(42),
        ),
        child: Center(
          child: Text(
            period,
            style: TextStyle(
              color: isSelected ? Colors.white : Color(0xFFA4ADBD),
              fontSize: isSelected ? 13 : 11,
              fontFamily: 'HK Grotesk',
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
} 