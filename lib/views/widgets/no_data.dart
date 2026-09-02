import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NoDataWidget extends StatelessWidget {
  const NoDataWidget({super.key, this.message});

  final String? message;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,

        children: [
          Lottie.asset(
            'assets/icons/no_data.json',
            width: 200,
            height: 200,
            fit: BoxFit.contain,
          ),
          Text(
            message ?? "No Data Found.",
            style: textTheme.bodySmall!.copyWith(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
