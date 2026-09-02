import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:fyp_emergency_services_pannel/constants/colors.dart';
import 'package:fyp_emergency_services_pannel/models/accident.dart';
import 'package:fyp_emergency_services_pannel/providers/accident.dart';
import 'package:fyp_emergency_services_pannel/services/datetime.dart';
import 'package:fyp_emergency_services_pannel/views/widgets/confirm_dialoge.dart';
import 'package:fyp_emergency_services_pannel/views/widgets/drop_down.dart';
import 'package:fyp_emergency_services_pannel/views/widgets/icon_button.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class AccidentTile extends StatelessWidget {
  const AccidentTile({
    super.key,
    required this.accident,
    this.onUpdate,
    this.isUpdateAllowed = false,
  });

  final AccidentModel accident;

  final VoidCallback? onUpdate;
  final bool isUpdateAllowed;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    // ---- STATIC SAMPLE DATA ----
    String accidentId = 'acc_${accident.id}';
    String location = accident.address;
    String time = DateTimeService.formatTimestamp(accident.timestamp);
    String severity = accident.severity;
    String status = accident.status;
    const String detectedBy = "Camera";

    final statusColor = AppColors.getStatusColor(status);

    return Container(
      width: 290,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: statusColor.withOpacity(.03),
        border: Border(left: BorderSide(width: 5, color: statusColor)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Accident Icon + ID
          Row(
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor: statusColor,
                child: Icon(Icons.car_crash, color: Colors.white),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  "Accident ID: $accidentId",
                  style: textTheme.titleMedium,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),

          // Location
          _dataTile(
            textTheme: textTheme,
            icon: Icons.location_on_outlined,
            label: "Location",
            value: location,
          ),

          const SizedBox(height: 10),

          // Time
          _dataTile(
            textTheme: textTheme,
            icon: Icons.access_time,
            label: "Time",
            value: time,
          ),

          const SizedBox(height: 10),

          // Severity
          _dataTile(
            textTheme: textTheme,
            icon: Icons.warning_amber_rounded,
            label: "Severity",
            value: severity,
          ),

          const SizedBox(height: 10),

          // Status
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _dataTile(
                textTheme: textTheme,
                icon: Icons.info,
                label: "Status",
                value: status,
              ),

              if (isUpdateAllowed)
                Consumer<AccidentProvider>(
                  builder: (context, provider, _) {
                    return CustomDropDown(
                      width: 130,
                      isLoading:
                          provider.isUpdatingStatus &&
                          provider.updatingStatusId == accident.id,
                      selectedLable: status,
                      items: ["scened", "confirmed", "resolved"],
                      onChanged: (val) async {
                        provider.updatingStatusId = accident.id;

                        await provider.updateAccidentStatus(accident.id, val);

                        onUpdate?.call();
                      },
                    );
                  },
                ),
            ],
          ),

          const SizedBox(height: 10),

          // Detected by
          _dataTile(
            textTheme: textTheme,
            icon: Icons.videocam,
            label: "Detected By",
            value: detectedBy,
          ),

          const SizedBox(height: 20),

          // Buttons
          Row(
            children: [
              Row(
                spacing: 10,
                children: [
                  CustomIconButton(
                    activeColor: Colors.blueAccent,
                    icons: Icons.video_camera_back,
                    label: "View",
                    onTap: () async {
                      // Add Cloudinary transformations automatically
                      final originalUrl = accident.videoUrl;

                      String transformedUrl = originalUrl;

                      // Only add transformations if not already present
                      if (!originalUrl.contains(
                        "/q_auto:good,vc_auto,ar_16:9,so_auto/",
                      )) {
                        transformedUrl = originalUrl.replaceFirst(
                          "/upload/",
                          "/upload/q_auto:good,vc_auto,ar_16:9,so_auto/",
                        );
                      }

                      if (await canLaunchUrl(Uri.parse(transformedUrl))) {
                        await launchUrl(
                          Uri.parse(transformedUrl),
                          mode: LaunchMode.externalApplication, // opens new tab
                        );

                        await context
                            .read<AccidentProvider>()
                            .updateAccidentStatus(accident.id, "scened");
                        onUpdate?.call();
                      } else {
                        print("Could not launch $transformedUrl");
                      }
                    },
                  ),
                  // CustomIconButton(
                  //   activeColor: Colors.purpleAccent,
                  //   icons: HugeIcons.strokeRoundedEditUser02,
                  //   label: "Edit",
                  //   onTap: () {},
                  // ),
                  CustomIconButton(
                    activeColor: Colors.green,
                    icons: FluentIcons.location_12_regular,
                    onTap: () => openLocationInMaps(
                      accident.latitude,
                      accident.longitude,
                    ),
                  ),
                  CustomIconButton(
                    activeColor: Colors.red,
                    icons: FluentIcons.delete_12_regular,
                    onTap: () => showConfirmationDialoge(
                      onConfirm: () => Provider.of<AccidentProvider>(
                        context,
                        listen: false,
                      ).deleteAccident(accident.id),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ---- DATA TILE ----
  Column _dataTile({
    required TextTheme textTheme,
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 18, color: Colors.grey),
            const SizedBox(width: 6),
            Text(
              label,
              style: textTheme.bodySmall!.copyWith(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
          ],
        ),
        Text(
          "   $value",
          style: textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w600),
        ),
      ],
    );
  }

  // ---- ACTION BUTTON ----
  // Widget _actionButton({
  //   required Color color,
  //   required String label,
  //   required IconData icon,
  //   required VoidCallback onTap,
  // }) {
  //   return InkWell(
  //     onTap: onTap,
  //     child: Container(
  //       padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
  //       decoration: BoxDecoration(
  //         color: color.withOpacity(.1),
  //         borderRadius: BorderRadius.circular(8),
  //         border: Border.all(color: color),
  //       ),
  //       child: Row(
  //         children: [
  //           Icon(icon, size: 16, color: color),
  //           const SizedBox(width: 6),
  //           Text(label, style: TextStyle(color: color)),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}

Future<void> openLocationInMaps(double lat, double lng) async {
  final googleMapsUrl = "https://www.google.com/maps?q=$lat,$lng";

  if (!await launchUrl(
    Uri.parse(googleMapsUrl),
    mode: LaunchMode.externalApplication,
  )) {
    throw Exception("Could not launch $googleMapsUrl");
  }
}
