import 'package:flutter/material.dart';

import '../configs/appColors.dart';

class YesNoRadioRow extends StatelessWidget {
  final String title;
  final String? option1;
  final String? option2;
  final bool? value;
  final bool? shodDivider;
  final ValueChanged<bool?> onChanged;

  const YesNoRadioRow({
    super.key,
    required this.title,
    required this.value,
    required this.onChanged,
    this.option1,
    this.option2, this.shodDivider=true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric( vertical: 6),
      child: Column(
        children: [
          Row(
            children: [
              /// Question Title - Left side
              Expanded(
                flex: 3,
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ),

              const SizedBox(width: 12),

              /// Options Container - Right side
              Container(
                height: 32,
                width: 100, // Fixed width for smaller buttons
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceVariant,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(10),
                      blurRadius: 2,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    /// Yes Option
                    Expanded(
                      child: _buildSegmentedOption(
                        context: context,
                        optionValue: true,
                        label: option1 ?? "হ্যাঁ",
                        isFirst: true,
                      ),
                    ),

                    /// No Option
                    Expanded(
                      child: _buildSegmentedOption(
                        context: context,
                        optionValue: false,
                        label: option2 ?? "না",
                        isFirst: false,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if(shodDivider!)
            Divider(color: primaryColor,)
        ],
      ),
    );
  }

  Widget _buildSegmentedOption({
    required BuildContext context,
    required bool optionValue,
    required String label,
    required bool isFirst,
  }) {
    final isSelected = value == optionValue;
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () => onChanged(optionValue),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: isSelected ? primaryColor : Colors.transparent,
          borderRadius: isFirst
              ? const BorderRadius.only(
            topLeft: Radius.circular(10),
            bottomLeft: Radius.circular(10),
          )
              : const BorderRadius.only(
            topRight: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: theme.textTheme.labelMedium?.copyWith(
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: isSelected
                    ? theme.colorScheme.onPrimary
                    : theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}