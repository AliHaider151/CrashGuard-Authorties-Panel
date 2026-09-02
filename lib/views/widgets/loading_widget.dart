import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 20,
        width: 20,
        child: CircularProgressIndicator(
          color: Theme.of(context).primaryColor,
          strokeWidth: 3,

          // strokeWidth: ,
        ),
      ),
    );
  }
}
