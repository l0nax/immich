import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';

part 'person.g.dart';

@Collection()
class Person {
  @protected
  Person({
    this.remoteId,
    required this.name,
  });

  Id id = Isar.autoIncrement;
  @Index(unique: true, replace: false, type: IndexType.hash)
  String? remoteId;
  String name;

  @override
  String toString() => name;
}
