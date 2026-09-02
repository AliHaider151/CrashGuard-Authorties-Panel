import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fyp_emergency_services_pannel/constants/colors.dart';
import 'package:fyp_emergency_services_pannel/utils/spacing.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.label,
    this.width,
    this.icon,
    required this.onTap,
    this.color,
    this.textColor,
    this.rotateAngle,
    this.borderColor,
    this.isLoading = false,
    this.height,
  });

  final String label;
  final double? width;
  final double? height;
  final IconData? icon;
  final VoidCallback onTap;
  final Color? color;
  final Color? textColor;
  final Color? borderColor;
  final double? rotateAngle;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isLoading ? null : onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: height ?? 40,
        width: width ?? double.infinity,
        decoration: BoxDecoration(
          color: color ?? AppColors.primary,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: borderColor ?? Colors.transparent),
        ),
        child: isLoading
            ? SpinKitFadingCircle(color: textColor ?? Colors.white, size: 35)
            : Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (icon != null) ...[
                    Transform.rotate(
                      angle: rotateAngle ?? 0,
                      child: Icon(
                        icon,
                        color: textColor ?? Colors.white,
                        size: 16,
                      ),
                    ),
                    12.width,
                  ],
                  Text(
                    label,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontSize: 12,
                      color: textColor ?? Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
