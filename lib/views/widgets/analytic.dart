import 'package:flutter/material.dart';
import 'package:fyp_emergency_services_pannel/constants/decoration.dart';
import 'package:fyp_emergency_services_pannel/utils/spacing.dart';

class AnalyticTile extends StatefulWidget {
  const AnalyticTile({
    super.key,
    required this.label,
    required this.icon,
    required this.value,
    required this.color,
    required this.des1,
    required this.des2,
    this.textColor,
  });

  final String label;
  final IconData icon;
  final Color color;
  final String value;
  final String des1;
  final String des2;
  final Color? textColor;

  @override
  State<AnalyticTile> createState() => _AnalyticTileState();
}

class _AnalyticTileState extends State<AnalyticTile> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: AnimatedScale(
        scale: _isHovering ? 1.05 : 1.0,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        child: Container(
          width: 285,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 23),
          decoration: ContainerDecoration.greyBorder.copyWith(
            color: widget.color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: widget.color.withOpacity(.2)),
          ),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  1.height,
                  Text(
                    widget.label,
                    style: textTheme.bodySmall!.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                  10.height,
                  Text(
                    widget.value,
                    style: textTheme.headlineSmall!.copyWith(
                      fontSize: 19,
                      fontWeight: FontWeight.w800,
                      color: widget.color,
                    ),
                  ),
                  5.height,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.des1,
                        style: textTheme.bodySmall!.copyWith(
                          color: widget.color,
                          fontSize: 11,
                        ),
                      ),
                      Text(
                        widget.des2,
                        style: textTheme.bodySmall!.copyWith(
                          color: widget.textColor ?? Colors.white70,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Positioned(
                right: 4,
                top: 0,
                child: Container(
                  padding: EdgeInsets.all(7),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: widget.color.withOpacity(0.15),
                  ),
                  child: Icon(widget.icon, color: widget.color, size: 21),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
