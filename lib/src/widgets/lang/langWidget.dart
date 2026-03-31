import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pickup_load_update/src/configs/appUtils.dart';
import 'package:pickup_load_update/src/widgets/appbar/customAppbar.dart';
import 'package:pickup_load_update/src/widgets/card/customCardWidget.dart';

import '../../configs/appColors.dart';
import '../../controllers/language/langController.dart';
import '../../models/lang/langModel.dart';

class LanguagesWidget extends StatefulWidget {
  const LanguagesWidget({super.key});

  @override
  State<LanguagesWidget> createState() => _LanguagesWidgetState();
}

class _LanguagesWidgetState extends State<LanguagesWidget> {
  late final LanguagesList languagesList;
  final _langC = Get.put(LangController());

  @override
  void initState() {
    super.initState();
    languagesList = LanguagesList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: CustomAppBar(appbarTitle: 'Select language'.tr),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        itemCount: languagesList.languages.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final language = languagesList.languages[index];
          return Obx(() => _LanguageTile(
            language: language,
            isSelected: _langC.checkLang(Locale(language.lCode, language.cCode)),
            onTap: () => _selectLanguage(language),
          ));
        },
      ),
    );
  }

  void _selectLanguage(Language language) async {
    await _langC.changeLang(Locale(language.lCode, language.cCode));
    log(_langC.selectedLang.value.toString(), name: "lang test");
    if (mounted) Get.back();
  }
}

class _LanguageTile extends StatelessWidget {
  final Language language;
  final bool isSelected;
  final VoidCallback onTap;

  const _LanguageTile({
    required this.language,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              _LanguageIndicator(isSelected: isSelected),
              const SizedBox(width: 16),
              Expanded(child: _LanguageTexts(language: language)),
              if (isSelected) _SelectedBadge(),
            ],
          ),
        ),
      ),
    );
  }
}

class _LanguageIndicator extends StatelessWidget {
  final bool isSelected;

  const _LanguageIndicator({required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      width: 44,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isSelected ? primaryColor.withOpacity(0.1) : Colors.grey.withOpacity(0.1),
      ),
      child: isSelected
          ? Icon(Icons.check, color: primaryColor, size: 24)
          : Icon(Icons.language, color: Colors.grey.shade400, size: 24),
    );
  }
}

class _LanguageTexts extends StatelessWidget {
  final Language language;

  const _LanguageTexts({required this.language});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          language.englishName,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 4),
        Text(
          language.localName.tr,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Colors.grey.shade600,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}

class _SelectedBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check_circle, color: primaryColor, size: 16),
          const SizedBox(width: 4),
          Text(
            'Selected'.tr,
            style: TextStyle(
              color: primaryColor,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
