import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';

/// Multi-ring circular progress used for the daily calorie/macro summary.
/// Each entry in [rings] is drawn as a concentric ring, outermost first.
class RingData {
  final double progress; // 0..1+
  final Color color;
  const RingData({required this.progress, required this.color});
}

class ProgressRing extends StatelessWidget {
  final List<RingData> rings;
  final double size;
  final double strokeWidth;
  final String centerValue;
  final String centerLabel;

  const ProgressRing({
    super.key,
    required this.rings,
    this.size = 120,
    this.strokeWidth = 10,
    required this.centerValue,
    required this.centerLabel,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: Size(size, size),
            painter: _RingPainter(rings: rings, strokeWidth: strokeWidth),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(centerValue, style: AppTypography.headingLg, textAlign: TextAlign.center),
              Text(centerLabel, style: AppTypography.caption, textAlign: TextAlign.center),
            ],
          ),
        ],
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  final List<RingData> rings;
  final double strokeWidth;

  _RingPainter({required this.rings, required this.strokeWidth});

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    for (var i = 0; i < rings.length; i++) {
      final radius = (size.width / 2) - strokeWidth / 2 - (i * (strokeWidth + 4));
      if (radius <= 0) continue;
      final bgPaint = Paint()
        ..color = AppColors.surface2
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth;
      canvas.drawCircle(center, radius, bgPaint);

      final fgPaint = Paint()
        ..color = rings[i].color
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..strokeWidth = strokeWidth;
      final sweep = 2 * math.pi * rings[i].progress.clamp(0, 1);
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        -math.pi / 2,
        sweep,
        false,
        fgPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _RingPainter oldDelegate) =>
      oldDelegate.rings != rings || oldDelegate.strokeWidth != strokeWidth;
}
