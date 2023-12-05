import 'package:immich_mobile/shared/models/asset.dart';
import 'package:immich_mobile/shared/models/person.dart';
import 'package:isar/isar.dart';

part 'asset_person.g.dart';

@collection
class AssetPerson {
  Id id = Isar.autoIncrement;

  int assetId;
  int peopleId;

  AssetPerson({
    required this.assetId,
    required this.peopleId,
  });
}
