import 'package:flutter/material.dart';
import 'package:fyp_emergency_services_pannel/constants/response.dart';
import 'package:fyp_emergency_services_pannel/utils/spacing.dart';
import 'package:fyp_emergency_services_pannel/views/pages/main_layout/components/side_bar.dart';
import 'package:fyp_emergency_services_pannel/views/widgets/custom_header.dart';

class CustomPageWidget extends StatelessWidget {
  const CustomPageWidget({
    super.key,
    required this.title,
    required this.subTitle,
    required this.child,
    this.icon,
    this.titleColor,
    this.padding,
    this.color,
    this.action,
  });

  final String title;
  final String subTitle;
  final Widget child;
  final IconData? icon;
  final Color? titleColor;
  final EdgeInsets? padding;
  final Color? color;
  final List<Widget>? action;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      drawer: Drawer(child: SidebarWidget()),
      body: Column(
        children: [
          CustomHeader(),
          20.height,
          Expanded(
            child: Container(
              padding:
                  padding ?? EdgeInsets.symmetric(horizontal: 0, vertical: 6),
              decoration: BoxDecoration(color: color ?? Colors.grey.shade50),
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ResponsiveHandling.isDesktop(context) ||
                            ResponsiveHandling.isTablet(context)
                        ? Row(
                            children: [
                              _TiTleSubtitleSection(
                                icon: icon,
                                titleColor: titleColor,
                                title: title,
                                textTheme: textTheme,
                                subTitle: subTitle,
                              ),
                              Spacer(),
                              if (action != null) ...action!,
                            ],
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 10,
                            children: [
                              _TiTleSubtitleSection(
                                icon: icon,
                                titleColor: titleColor,
                                title: title,
                                textTheme: textTheme,
                                subTitle: subTitle,
                              ),
                              if (action != null) ...action!,
                            ],
                          ),
                    25.height,
                    child,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TiTleSubtitleSection extends StatelessWidget {
  const _TiTleSubtitleSection({
    required this.icon,
    required this.titleColor,
    required this.title,
    required this.textTheme,
    required this.subTitle,
  });

  final IconData? icon;
  final Color? titleColor;
  final String title;
  final TextTheme textTheme;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            if (icon != null) Icon(icon, color: titleColor, size: 40),
            if (icon != null) 8.width,
            Text(
              title,
              style: textTheme.headlineSmall!.copyWith(
                fontWeight: FontWeight.w600,
                color: titleColor,
                fontSize: 30,
              ),
            ),
          ],
        ),
        2.height,
        Text(
          subTitle,
          style: textTheme.bodySmall!.copyWith(color: Colors.grey),
        ),
      ],
    );
  }
}
