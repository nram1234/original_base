import 'package:original_base/src/core/models/selectable_type.dart';
//------------------------------------------------------------------------

class TradeType implements SelectableType {
  late final int serverId;

  late final String nameAr;
  late final String nameEn;

  /// id used to translate trade name.
  late final String nameId;

  TradeType({
    required this.serverId,
    required this.nameId,
  });

  TradeType.fromJson(Map map) {
    serverId = map["id"];
    nameAr = map["name_ar"];
    nameEn = map["name_en"];
  }
}
