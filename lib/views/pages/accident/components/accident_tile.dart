import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:fyp_emergency_services_pannel/constants/colors.dart';
import 'package:fyp_emergency_services_pannel/models/accident.dart';
import 'package:fyp_emergency_services_pannel/providers/accident.dart';
import 'package:fyp_emergency_services_pannel/repository/accident.dart';
import 'package:fyp_emergency_services_pannel/services/datetime.dart';
import 'package:fyp_emergency_services_pannel/views/widgets/confirm_dialoge.dart';
import 'package:fyp_emergency_services_pannel/views/widgets/custom_button.dart';
import 'package:fyp_emergency_services_pannel/views/widgets/custom_dilaoge.dart';
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
    this.accidentUpdates,
  });

  final AccidentModel accident;

  final VoidCallback? onUpdate;
  final bool isUpdateAllowed;
  final Stream<AccidentModel?>? accidentUpdates;

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

    return GestureDetector(
      onTap: () {
        print('Accident ID: ${accident.id}');

        showDialog<void>(
          context: context,
          builder: (_) {
            print('Accident ID: ${accident.id}');
            return _AccidentVerificationDialog(
              accident: accident,
              onUpdate: onUpdate,
              accidentUpdates: accidentUpdates,
            );
          },
        );
      },
      // borderRadius: BorderRadius.circular(12),
      child: Container(
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
                      onTap: () =>
                          _openAccidentVideo(context, accident, onUpdate),
                    ),

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
}

class _AccidentVerificationDialog extends StatefulWidget {
  const _AccidentVerificationDialog({
    required this.accident,
    this.onUpdate,
    this.accidentUpdates,
  });

  final AccidentModel accident;
  final VoidCallback? onUpdate;
  final Stream<AccidentModel?>? accidentUpdates;

  @override
  State<_AccidentVerificationDialog> createState() =>
      _AccidentVerificationDialogState();
}

class _AccidentVerificationDialogState
    extends State<_AccidentVerificationDialog> {
  late final Stream<AccidentModel?> _accidentUpdates =
      widget.accidentUpdates ??
      AccidentRepository().streamAccident(widget.accident.id);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AccidentModel?>(
      stream: _accidentUpdates,
      initialData: widget.accident,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return _buildStreamErrorDialog(context);
        }
        if (snapshot.connectionState == ConnectionState.active &&
            snapshot.data == null) {
          return _buildMissingAccidentDialog(context);
        }
        return _buildDialog(context, snapshot.data ?? widget.accident);
      },
    );
  }

  Widget _buildStreamErrorDialog(BuildContext context) {
    return CustomDialogeWidget(
      title: 'Verification unavailable',
      subtitile: 'Could not load the latest accident details.',
      icon: Icons.error_outline,
      isActionBtn: false,
      child: Padding(
        padding: const EdgeInsets.only(top: 18),
        child: Text(
          'The live accident data could not be retrieved. Close this dialog and try again.',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }

  Widget _buildMissingAccidentDialog(BuildContext context) {
    return CustomDialogeWidget(
      title: 'Accident no longer available',
      subtitile: 'This accident report may have been deleted.',
      icon: Icons.info_outline,
      isActionBtn: false,
      child: Padding(
        padding: const EdgeInsets.only(top: 18),
        child: Text(
          'The accident record could not be found.',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }

  Widget _buildDialog(BuildContext context, AccidentModel accident) {
    final verification = accident.verification;
    final pendingValue = 'AI is processing...';
    final fields = <(String, String?, IconData, bool)>[
      ('Verdict', verification?.verdict, Icons.fact_check_outlined, false),
      (
        'Confidence',
        verification?.confidence?.toStringAsFixed(2),
        Icons.insights_outlined,
        false,
      ),
      ('Severity', verification?.severity, Icons.warning_amber_rounded, false),
      (
        'Incident types',
        _formatList(verification?.incidentTypes, 'None detected'),
        Icons.category_outlined,
        false,
      ),
      (
        'Hazards detected',
        _formatList(verification?.hazardsDetected, 'None detected'),
        Icons.report_gmailerrorred_outlined,
        false,
      ),
      (
        'Reasoning summary',
        verification?.reasoningSummary,
        Icons.subject_outlined,
        true,
      ),
      (
        'Recommended action',
        verification?.recommendedAction,
        Icons.medical_services_outlined,
        true,
      ),
      (
        'Requires more frames',
        verification?.requiresMoreFrames == true
            ? 'Yes'
            : verification?.requiresMoreFrames == false
            ? 'No'
            : null,
        Icons.video_camera_back_outlined,
        false,
      ),
      (
        'Alternative explanations',
        _formatList(verification?.alternativeExplanations, 'None reported'),
        Icons.alt_route_outlined,
        true,
      ),
      (
        'Visual evidence',
        _formatList(
          verification?.visualEvidence,
          'No visual evidence provided',
        ),
        Icons.visibility_outlined,
        true,
      ),
    ];
    final hasPendingFields = fields.any((field) => field.$2 == null);

    return CustomDialogeWidget(
      title: 'AI accident verification',
      subtitile: 'Review the analysis and evidence for this reported accident.',
      icon: Icons.car_crash_outlined,
      maxwidth: 760,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      isActionBtn: false,

      child: Padding(
        padding: const EdgeInsets.only(top: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: .06),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: AppColors.primary.withValues(alpha: .12),
                ),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.tag_outlined,
                    size: 18,
                    color: AppColors.primary,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Accident ID',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey.shade700,
                    ),
                  ),
                  const Spacer(),
                  Flexible(
                    child: Text(
                      'acc_${accident.id}',
                      textAlign: TextAlign.end,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                CustomButton(
                  label: 'View video',
                  width: 200,
                  icon: Icons.play_circle_outline,
                  onTap: () =>
                      _openAccidentVideo(context, accident, widget.onUpdate),
                ),
                CustomButton(
                  label: 'Open location',
                  width: 215,
                  icon: Icons.location_on_outlined,
                  color: Colors.green.shade600,
                  onTap: () =>
                      openLocationInMaps(accident.latitude, accident.longitude),
                ),
              ],
            ),
            if (hasPendingFields) ...[
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.orange.withValues(alpha: .08),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.orange.withValues(alpha: .2),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.hourglass_top_rounded,
                      color: Colors.deepOrange,
                      size: 20,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'AI verification is in progress. Fields without a value are still being processed.',
                        style: Theme.of(
                          context,
                        ).textTheme.bodySmall?.copyWith(height: 1.4),
                      ),
                    ),
                  ],
                ),
              ),
            ],
            const SizedBox(height: 18),
            Text(
              'VERIFICATION DETAILS',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w700,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 10),
            LayoutBuilder(
              builder: (context, constraints) {
                final isWide = constraints.maxWidth >= 560;
                final regularWidth = isWide
                    ? (constraints.maxWidth - 12) / 2
                    : constraints.maxWidth;

                return Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    for (final field in fields)
                      SizedBox(
                        width: field.$4 || !isWide
                            ? constraints.maxWidth
                            : regularWidth,
                        child: _verificationField(
                          context,
                          label: field.$1,
                          value: field.$2 ?? pendingValue,
                          icon: field.$3,
                          isPending: field.$2 == null,
                        ),
                      ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  static String? _formatList(List<String>? values, String emptyValue) {
    if (values == null) return null;
    return values.isEmpty ? emptyValue : values.join(', ');
  }

  static Widget _verificationField(
    BuildContext context, {
    required String label,
    required String value,
    required IconData icon,
    required bool isPending,
  }) {
    final mutedColor = Colors.grey.shade500;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: (isPending ? Colors.orange : AppColors.primary).withValues(
                alpha: .09,
              ),
              borderRadius: BorderRadius.circular(9),
            ),
            child: Icon(
              isPending ? Icons.hourglass_empty_rounded : icon,
              size: 18,
              color: isPending ? Colors.deepOrange : AppColors.primary,
            ),
          ),
          const SizedBox(width: 11),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  value,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: isPending ? mutedColor : Colors.black87,
                    fontStyle: isPending ? FontStyle.italic : FontStyle.normal,
                    height: 1.4,
                    fontWeight: isPending ? FontWeight.w400 : FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Future<void> _openAccidentVideo(
  BuildContext context,
  AccidentModel accident,
  VoidCallback? onUpdate,
) async {
  final provider = context.read<AccidentProvider>();
  final originalUrl = accident.videoUrl;
  final transformedUrl =
      originalUrl.contains('/q_auto:good,vc_auto,ar_16:9,so_auto/')
      ? originalUrl
      : originalUrl.replaceFirst(
          '/upload/',
          '/upload/q_auto:good,vc_auto,ar_16:9,so_auto/',
        );
  final uri = Uri.tryParse(transformedUrl);

  if (uri == null || !await canLaunchUrl(uri)) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Unable to open the accident video.')),
      );
    }
    return;
  }

  if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Unable to open the accident video.')),
      );
    }
    return;
  }

  await provider.updateAccidentStatus(accident.id, 'scened');
  onUpdate?.call();
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
