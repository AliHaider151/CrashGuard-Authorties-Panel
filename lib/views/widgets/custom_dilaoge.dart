import 'package:flutter/material.dart';
import 'package:fyp_emergency_services_pannel/constants/colors.dart';
import 'package:fyp_emergency_services_pannel/constants/decoration.dart';
import 'package:fyp_emergency_services_pannel/utils/spacing.dart';
import 'package:fyp_emergency_services_pannel/views/widgets/custom_button.dart';
import 'package:fyp_emergency_services_pannel/views/widgets/icon_button.dart';

class CustomDialogeWidget extends StatelessWidget {
  const CustomDialogeWidget({
    super.key,
    this.title,
    this.subtitile,
    this.onTab,
    this.actionBtnLabel,
    this.btnwidth,
    required this.child,
    this.padding,
    this.maxwidth,
    this.showDevider = false,
    this.isLoading = false,
    this.isActionBtn = true,
    this.icon,
    this.headerWidget, // 🔥 new optional widget
  });

  final String? title;
  final String? subtitile;
  final double? btnwidth;
  final Widget child;
  final String? actionBtnLabel;
  final VoidCallback? onTab;
  final EdgeInsets? padding;
  final double? maxwidth;
  final bool showDevider;
  final bool isLoading;
  final bool isActionBtn;
  final IconData? icon;
  final Widget? headerWidget;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      insetPadding: padding,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: maxwidth ?? 500,
            maxHeight: MediaQuery.of(context).size.height * 0.9,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  if (icon != null) ...[
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: ContainerDecoration.transparentBorder
                          .copyWith(color: AppColors.primary.withOpacity(.1)),
                      child: Icon(icon, color: AppColors.primary),
                    ),
                    10.width,
                  ],
                  if (headerWidget != null) ...[
                    Expanded(child: headerWidget!),
                  ] else ...[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title ?? '',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (subtitile != null) ...[
                            const SizedBox(height: 4),
                            Text(
                              subtitile!,
                              style: textTheme.bodySmall!.copyWith(
                                color: Colors.grey,
                                fontSize: 12.5,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                  Spacer(),
                  CustomIconButton(
                    icons: Icons.close,
                    onTap: () => Navigator.of(context).pop(),
                    activeColor: Colors.grey.shade200,
                    iconColor: Colors.grey,
                    iconActiveColor: Colors.black,
                    borderColor: Colors.transparent,
                  ),
                ],
              ),
              if (showDevider)
                Container(
                  width: double.infinity,
                  color: Colors.grey.shade400,
                  height: .5,
                ),
              Flexible(child: SingleChildScrollView(child: child)),
              if (isActionBtn) ...[
                20.height,
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomButton(
                      label: 'Cancel',
                      width: 80,
                      onTap: () => Navigator.of(context).pop(),
                      color: Colors.red,
                    ),
                    const SizedBox(width: 12),
                    CustomButton(
                      label: actionBtnLabel ?? '',
                      isLoading: isLoading,
                      width: btnwidth ?? 120,
                      onTap: onTab ?? () {},
                    ),
                  ],
                ),
              ],
              10.height,
            ],
          ),
        ),
      ),
    );
  }
}
