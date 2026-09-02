import 'package:flutter/material.dart';
import 'package:fyp_emergency_services_pannel/constants/router.dart';
import 'package:fyp_emergency_services_pannel/views/widgets/custom_button.dart';

void showConfirmationDialoge({
  String? title,
  String? subTitle,
  String? confimrBtnTitle,
  required Future<void> Function() onConfirm,
}) {
  showDialog(
    context: RouterService.context,
    builder: (context) {
      return _ConfirmationDialog(
        title: title,
        subTitle: subTitle,
        onConfirm: onConfirm,
        confimrBtnTitle: confimrBtnTitle,
      );
    },
  );
}

class _ConfirmationDialog extends StatefulWidget {
  final String? title;
  final String? subTitle;
  final Future<void> Function() onConfirm;
  final String? confimrBtnTitle;

  const _ConfirmationDialog({
    this.title,
    this.subTitle,
    required this.onConfirm,
    this.confimrBtnTitle,
  });

  @override
  State<_ConfirmationDialog> createState() => _ConfirmationDialogState();
}

class _ConfirmationDialogState extends State<_ConfirmationDialog> {
  bool isLoading = false;

  Future<void> _handleConfirm() async {
    setState(() => isLoading = true);
    try {
      await widget.onConfirm();
      if (mounted) Navigator.of(context).pop(); // close dialog after success
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title ?? 'Delete This Item?'),
      content: Text(widget.subTitle ?? 'Are you sure you want to delete this?'),
      actions: [
        if (!isLoading)
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
        CustomButton(
          label: widget.confimrBtnTitle ?? "Delete",
          onTap: _handleConfirm,
          color: Colors.red,
          width: 150,
          isLoading: isLoading,
        ),
      ],
    );
  }
}
