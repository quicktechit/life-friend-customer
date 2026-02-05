import 'package:hive/hive.dart';
part 'lang.g.dart';

@HiveType(typeId: 1)
class Lang extends HiveObject {
  @HiveField(0)
  String? languageCode;
  @HiveField(1)
  String? countryCode;

  Lang({
    this.languageCode,
    this.countryCode,
  });
}
