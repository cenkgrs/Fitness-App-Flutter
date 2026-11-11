import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
/// wrapping fl_chart with the app's dark theme: the latest value and the
/// change since the first point up top, an optional dashed target line,
/// and first/last dates along the bottom.
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

  String _fmt(double v) => v == v.roundToDouble() ? v.round().toString() : v.toStringAsFixed(1);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context).toLanguageTag();
    if (points.isEmpty) {
      return AppCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: AppTypography.bodyMd),
            SizedBox(
              height: 140,
              child: Center(child: Text(l10n.lineChartNoData, style: AppTypography.bodyMd)),
            ),
          ],
        ),
      );
    }

    final spots = <FlSpot>[
      for (var i = 0; i < points.length; i++) FlSpot(i.toDouble(), points[i].value),
    ];
    final values = [...points.map((p) => p.value), if (targetValue != null) targetValue!];
    final minY = values.reduce((a, b) => a < b ? a : b);
    final maxY = values.reduce((a, b) => a > b ? a : b);
    final padding = (maxY - minY).abs() * 0.2 + 1;
    final latest = points.last.value;
    final delta = latest - points.first.value;
    final dateFormat = DateFormat.MMMd(locale);

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTypography.bodyMd),
          const SizedBox(height: AppSpacing.xs),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('${_fmt(latest)}$unit', style: AppTypography.displayMd),
              const SizedBox(width: AppSpacing.sm),
              if (points.length > 1 && delta.abs() >= 0.05)
                Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Text(
                    '${delta > 0 ? '+' : '−'}${_fmt(delta.abs())}$unit',
                    style: AppTypography.caption.copyWith(color: AppColors.textPrimary),
                  ),
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          SizedBox(
            height: 170,
            child: LineChart(
              LineChartData(
                minY: minY - padding,
                maxY: maxY + padding,
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: ((maxY - minY).abs() + 2 * padding) / 3,
                  getDrawingHorizontalLine: (_) => const FlLine(color: AppColors.surfaceBorder, strokeWidth: 1),
                ),
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
                        '${_fmt(point.value)}$unit\n',
                        AppTypography.caption.copyWith(color: AppColors.textPrimary),
                        children: [
                          TextSpan(text: dateFormat.format(point.date), style: AppTypography.caption),
                        ],
                      );
                    }).toList(),
                  ),
                ),
                extraLinesData: targetValue == null
                    ? const ExtraLinesData()
                    : ExtraLinesData(horizontalLines: [
                        HorizontalLine(
                          y: targetValue!,
                          color: AppColors.textTertiary,
                          strokeWidth: 1,
                          dashArray: [4, 4],
                          label: HorizontalLineLabel(
                            show: true,
                            alignment: Alignment.topRight,
                            style: AppTypography.caption.copyWith(color: AppColors.textTertiary),
                            labelResolver: (_) => '${_fmt(targetValue!)}$unit',
                          ),
                        ),
                      ]),
                lineBarsData: [
                  LineChartBarData(
                    spots: spots,
                    isCurved: true,
                    preventCurveOverShooting: true,
                    color: lineColor,
                    barWidth: 2.5,
                    // A single point has no line to draw, so it'd otherwise
                    // render as an empty-looking card — show the dot then.
                    dotData: FlDotData(
                      show: true,
                      checkToShowDot: (spot, _) => points.length == 1 || spot.x == spots.last.x,
                      getDotPainter: (spot, a, b, c) => FlDotCirclePainter(
                        radius: 4,
                        color: lineColor,
                        strokeWidth: 2,
                        strokeColor: AppColors.surface1,
                      ),
                    ),
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [lineColor.withValues(alpha: 0.18), lineColor.withValues(alpha: 0)],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(dateFormat.format(points.first.date), style: AppTypography.caption),
              if (points.length > 1) Text(dateFormat.format(points.last.date), style: AppTypography.caption),
            ],
          ),
        ],
      ),
    );
  }
}
