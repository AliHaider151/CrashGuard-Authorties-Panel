import 'package:flutter/material.dart';

class ContainerDecoration {
  static final BoxDecoration greyBorder = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(12),
    border: Border.all(
      color: Colors.grey.shade200,
    ),
  );
  static final BoxDecoration transparentBorder = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(12),
  );
}
