class Language {
  String lCode;
  String cCode;
  String englishName;
  String localName;
  bool selected;

  Language(
    this.lCode,
    this.cCode,
    this.englishName,
    this.localName, {
    this.selected = false,
  });

}

class LanguagesList {
  List<Language>? _languages;

  LanguagesList() {
    this._languages = [
      Language("en", "US", "ENGLISH", ""),
      Language("bn", "BN", "বাংলা", ""),

    ];
  }

  List<Language> get languages => _languages!;
}
