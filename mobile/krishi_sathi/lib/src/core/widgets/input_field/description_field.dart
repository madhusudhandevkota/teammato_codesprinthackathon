import 'package:flutter/material.dart';
import 'package:krishi_sathi/src/core/constants/app_assets.dart';
import 'package:krishi_sathi/src/core/constants/app_colors.dart';

class DescriptionField extends StatelessWidget {
  final String title;
  final Function()? onPressed;
  final TextEditingController controller;

  const DescriptionField({
    Key? key,
    required this.controller,
    required this.title,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          TextField(
            controller: controller,
            keyboardType: TextInputType.multiline,
            maxLines: 5,
            cursorColor: AppColors.graphite,
            decoration: InputDecoration(
              fillColor: AppColors.midnight,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide:
                    const BorderSide(color: AppColors.foreground, width: 1.5),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(11),
                borderSide:
                    const BorderSide(color: AppColors.foreground, width: 1.5),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(11),
                borderSide:
                    const BorderSide(color: AppColors.foreground, width: 1.5),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(11),
                borderSide:
                    const BorderSide(color: AppColors.foreground, width: 1.5),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(11),
                borderSide:
                    const BorderSide(color: AppColors.foreground, width: 1.5),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              hintText: title,
              hintStyle: const TextStyle(
                color: AppColors.gray,
                fontSize: 16,
              ),
            ),
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: AppColors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                ),
          ),
          Positioned(
            bottom: 8,
            right: 8,
            child: GestureDetector(
              onTap: onPressed,
              child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.frog),
                  borderRadius: BorderRadius.all(const Radius.circular(50)),
                  color: AppColors.midnight,
                ),
                child: Image.asset(
                  AppIcons.send,
                  height: 20.0,
                  width: 20.0,
                  color: AppColors.frog,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
