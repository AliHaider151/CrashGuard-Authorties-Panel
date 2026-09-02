import 'package:flutter/material.dart';

class CustomIconButton extends StatefulWidget {
  const CustomIconButton({
    super.key,
    this.label = "",
    this.icons,
    required this.activeColor,
    required this.onTap,
    this.iconActiveColor,
    this.iconColor,
    this.borderColor,
    this.borderWidth = 1,
    this.rotateAngle,
  });

  final String label;
  final IconData? icons;
  final Color activeColor;
  final Color? iconActiveColor;
  final Color? iconColor;
  final Color? borderColor;
  final VoidCallback onTap;
  final double borderWidth;
  final double? rotateAngle;

  @override
  State<CustomIconButton> createState() => _CustomIconButtonState();
}

class _CustomIconButtonState extends State<CustomIconButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: _isHovered ? widget.activeColor : Colors.white,
            border: Border.all(
              color: widget.borderColor ?? widget.activeColor,
              width: widget.borderWidth,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              widget.icons == null
                  ? SizedBox.shrink()
                  : Transform.rotate(
                      angle: widget.rotateAngle ?? 0,
                      child: Icon(
                        widget.icons,
                        size: 18,
                        color: _isHovered
                            ? widget.iconActiveColor ?? Colors.white
                            : widget.iconColor ?? widget.activeColor,
                      ),
                    ),
              if (widget.icons != null && widget.label.isNotEmpty)
                const SizedBox(width: 10),
              widget.label.isEmpty
                  ? SizedBox.shrink()
                  : Text(
                      widget.label,
                      style: textTheme.bodySmall!.copyWith(
                        fontWeight: FontWeight.w500,
                        color: _isHovered ? Colors.white : widget.activeColor,
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
