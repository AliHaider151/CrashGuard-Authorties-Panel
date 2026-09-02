import 'package:flutter/material.dart';

class StatusTile extends StatelessWidget {
  const StatusTile({
    super.key,
    required this.label,
    this.color,
    this.gradientColor,
    this.borderColor,
    this.textColor,
    this.padding,
    this.textSize,
    this.fontWeight,
  });

  final String label;
  final Color? color;
  final List<Color>? gradientColor;
  final Color? textColor;
  final Color? borderColor;
  final EdgeInsets? padding;
  final double? textSize;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final gradient = gradientColor == null
        ? null
        : LinearGradient(
            colors: gradientColor!,
          );

    return Container(
      padding: padding ?? EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        color: color,
        gradient: gradient,
        border:
            Border.all(color: borderColor ?? Colors.transparent, width: 0.5),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Text(
        label,
        style: textTheme.bodySmall!.copyWith(
          color: textColor ?? Colors.white,
          fontSize: textSize ?? 10,
          fontWeight: fontWeight ?? FontWeight.w500,
        ),
      ),
    );
  }
}
