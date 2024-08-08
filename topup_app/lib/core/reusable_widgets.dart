import 'package:flutter/material.dart';
import 'package:topup_app/core/app_colors.dart';

AppBar getAppBar(
  String? title, {
  required BuildContext ctx,
  bool? centerTitle,
}) {
  return AppBar(
    iconTheme: const IconThemeData(
      color: AppColors.color30447D,
    ),
    title: Text(
      title ?? '',
      style: const TextStyle(
        color: AppColors.color30447D,
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
    ),
    centerTitle: centerTitle,
  );
}
