import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_radius.dart';

/// Shimmering skeleton placeholder card, per the loading-state spec
/// (soft left-to-right sheen instead of a bare spinner).
class LoadingShimmer extends StatefulWidget {
  final double height;
  final double? width;
  final BorderRadius? borderRadius;

  const LoadingShimmer({super.key, this.height = 80, this.width, this.borderRadius});

  @override
  State<LoadingShimmer> createState() => _LoadingShimmerState();
}

class _LoadingShimmerState extends State<LoadingShimmer> with SingleTickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(vsync: this, duration: const Duration(milliseconds: 1400))..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return Container(
          height: widget.height,
          width: widget.width,
          decoration: BoxDecoration(
            borderRadius: widget.borderRadius ?? BorderRadius.circular(AppRadius.lg),
            gradient: LinearGradient(
              begin: Alignment(-1 + _controller.value * 2, 0),
              end: Alignment(1 + _controller.value * 2, 0),
              colors: const [AppColors.surface1, AppColors.surface2, AppColors.surface1],
              stops: const [0.3, 0.5, 0.7],
            ),
          ),
        );
      },
    );
  }
}
