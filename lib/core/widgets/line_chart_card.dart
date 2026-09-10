import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';
import 'app_card.dart';

class ChartPoint {
  final DateTime date;
  final double value;
  const ChartPoint(this.date, this.value);
}

/// Reusable line chart card (weight trend, strength progression, etc.)
/// wrapping fl_chart with Repwise's dark theme and an optional dashed
/// target line.
class LineChartCard extends StatelessWidget {
  final String title;
  final List<ChartPoint> points;
  final Color lineColor;
  final double? targetValue;
  final String unit;

  const LineChartCard({
    super.key,
    required this.title,
    required this.points,
    this.lineColor = AppColors.primary,
    this.targetValue,
    this.unit = '',
  });

  @override
  Widget build(BuildContext context) {
    if (points.isEmpty) {
      return AppCard(
        child: SizedBox(
          height: 160,
          child: Center(child: Text(AppLocalizations.of(context)!.lineChartNoData, style: AppTypography.bodyMd)),
        ),
      );
    }

    final spots = <FlSpot>[
      for (var i = 0; i < points.length; i++) FlSpot(i.toDouble(), points[i].value),
    ];
    final minY = [
      points.map((p) => p.value).reduce((a, b) => a < b ? a : b),
      if (targetValue != null) targetValue!,
    ].reduce((a, b) => a < b ? a : b);
    final maxY = [
      points.map((p) => p.value).reduce((a, b) => a > b ? a : b),
      if (targetValue != null) targetValue!,
    ].reduce((a, b) => a > b ? a : b);
    final padding = (maxY - minY).abs() * 0.15 + 1;

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTypography.headingSm),
          const SizedBox(height: AppSpacing.lg),
          SizedBox(
            height: 180,
            child: LineChart(
              LineChartData(
                minY: minY - padding,
                maxY: maxY + padding,
                gridData: const FlGridData(show: false),
                titlesData: const FlTitlesData(
                  topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
                borderData: FlBorderData(show: false),
                lineTouchData: LineTouchData(
                  touchTooltipData: LineTouchTooltipData(
                    getTooltipColor: (_) => AppColors.surface2,
                    getTooltipItems: (spots) => spots.map((s) {
                      final point = points[s.x.toInt()];
                      return LineTooltipItem(
                        '${point.value.toStringAsFixed(1)}$unit',
                        AppTypography.caption.copyWith(color: AppColors.textPrimary),
                      );
                    }).toList(),
                  ),
                ),
                extraLinesData: targetValue == null
                    ? const ExtraLinesData()
                    : ExtraLinesData(horizontalLines: [
                        HorizontalLine(
                          y: targetValue!,
                          color: AppColors.success,
                          strokeWidth: 1,
                          dashArray: [6, 4],
                        ),
                      ]),
                lineBarsData: [
                  LineChartBarData(
                    spots: spots,
                    isCurved: true,
                    color: lineColor,
                    barWidth: 3,
                    // A single point has no line to draw, so it'd otherwise
                    // render as an empty-looking card — show the dot then.
                    dotData: FlDotData(show: points.length == 1),
                    belowBarData: BarAreaData(show: true, color: lineColor.withOpacity(0.12)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
