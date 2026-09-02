import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show FilteringTextInputFormatter;
import 'package:fyp_emergency_services_pannel/utils/spacing.dart';

class CustomTextField extends StatelessWidget {
  final String? label;
  final String? header;
  final TextEditingController controller;
  final bool obscureText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final double? radius;
  final double? width;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final VoidCallback? ontap;
  final bool? readOnly;
  final int? maxlines;
  final TextInputType? keyboardType;
  final FocusNode? focusNode;
  final bool autoUnfocus;
  const CustomTextField({
    required this.controller,
    super.key,
    this.label,
    this.header,
    this.obscureText = false,
    this.keyboardType,
    this.onSubmitted,
    this.suffixIcon,
    this.radius,
    this.width,
    this.onChanged,
    this.prefixIcon,
    this.ontap,
    this.maxlines,
    this.readOnly = false,
    this.focusNode,
    this.autoUnfocus = true,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (header != null) ...[
          Text(
            header ?? '',
            style: textTheme.bodySmall!.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
          3.height,
        ],
        SizedBox(
          height: maxlines != null ? null : 43,
          width: width,
          child: TextField(
            keyboardType: keyboardType,
            onTapOutside: (val) {
              if (autoUnfocus) {
                FocusManager.instance.primaryFocus?.unfocus();
              }
            },
            maxLines: maxlines ?? 1,
            onTap: ontap,
            readOnly: readOnly!,
            focusNode: focusNode,
            controller: controller,
            onChanged: onChanged,
            onSubmitted: onSubmitted,
            obscureText: obscureText,
            inputFormatters: keyboardType == TextInputType.number
                ? [FilteringTextInputFormatter.digitsOnly]
                : null,
            style: textTheme.bodySmall!.copyWith(
              color: Colors.black,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
            cursorColor: Colors.grey,
            decoration: InputDecoration(
              // labelText: label,
              hintText: label ?? header,
              alignLabelWithHint: true,
              hintStyle: TextStyle(
                color: Colors.grey.shade400,
                fontWeight: FontWeight.w400,
                fontSize: 12,
              ),
              labelStyle: TextStyle(
                color: Colors.grey.shade400,
                fontWeight: FontWeight.w400,
                fontSize: 12,
              ),
              floatingLabelStyle: const TextStyle(
                color: Colors.black,
                fontSize: 12,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade200),
                borderRadius: BorderRadius.circular(radius ?? 12),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade400),
                borderRadius: BorderRadius.circular(radius ?? 12),
              ),
              suffixIcon: suffixIcon,
              prefixIcon: prefixIcon,
              filled: true,

              fillColor: Colors.white,
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(
                vertical: 18,
                horizontal: 12,
              ), // Adjusted vertical padding
            ),
          ),
        ),
      ],
    );
  }
}
