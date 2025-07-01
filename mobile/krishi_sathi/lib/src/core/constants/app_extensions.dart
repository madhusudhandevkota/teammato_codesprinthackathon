import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_enums.dart';

extension ToastEnumsExtension on ToastType {
  Color getColor() {
    switch (this) {
      case ToastType.error:
        return AppColors.red;
      case ToastType.success:
        return AppColors.green;
    }
  }
}
