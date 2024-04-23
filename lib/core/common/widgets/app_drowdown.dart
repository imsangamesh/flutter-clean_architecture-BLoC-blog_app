import 'package:blog_app/core/constants/app_text_styles.dart';
import 'package:blog_app/core/constants/colors.dart';
import 'package:blog_app/core/constants/constants.dart';
import 'package:flutter/material.dart';

class CustomDropdown extends StatelessWidget {
  const CustomDropdown(
    this.selectedItem,
    this.items, {
    required this.setSelectedItem,
    super.key,
  });

  final String selectedItem;
  final List<String> items;
  final void Function(String item) setSelectedItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.listTile,
        borderRadius: BorderRadius.circular(kBR),
      ),
      child: DropdownButton<String>(
        iconEnabledColor: AppColors.prim,
        padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
        borderRadius: BorderRadius.circular(kBR),
        underline: const SizedBox(),
        iconSize: 28,
        isExpanded: true,
        value: selectedItem,
        items: items
            .map(
              (e) => DropdownMenuItem<String>(
                value: e,
                child: Text(
                  e,
                  style:
                      selectedItem == e ? AppTStyles.primary : AppTStyles.body,
                ),
              ),
            )
            .toList(),
        onChanged: (newVal) => setSelectedItem(newVal!),
      ),
    );
  }
}
