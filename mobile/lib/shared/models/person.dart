import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';

part 'person.g.dart';

@Collection()
class Person {
  @protected
  Person({
    this.remoteId,
    required this.name,
    this.birthDate,
    this.isHidden = false,
    required this.thumbnailPath,
  });

  Id id = Isar.autoIncrement;
  @Index(unique: true, replace: false, type: IndexType.hash)
  String? remoteId;
  String name;
  DateTime? birthDate;
  bool isHidden;
  String thumbnailPath;

  @override
  String toString() => name;
}
