import 'package:flutter/material.dart';

import '../../../utils/appColors/AppColors.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(color: AppColors.primaryPurple);
  }
}