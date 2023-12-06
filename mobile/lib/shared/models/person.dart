import 'package:flutter/cupertino.dart';
import 'package:isar/isar.dart';
import 'package:openapi/api.dart';

part 'person.g.dart';

@Collection(inheritance: false)
class Person {
  @protected
  Person({
    required this.remoteId,
    this.birthDate,
    required this.isHidden,
    required this.name,
  });

  Id id = Isar.autoIncrement;

  @Index(unique: false, replace: false, type: IndexType.hash)
  String remoteId;

  DateTime? birthDate;

  bool isHidden;

  String name;

  @override
  bool operator ==(Object other) {
    if (other is! Person) return false;

    return id == other.id &&
        remoteId == other.remoteId &&
        birthDate == other.birthDate &&
        isHidden == other.isHidden &&
        name == other.name;
  }

  @override
  @ignore
  int get hashCode =>
      id.hashCode ^
      remoteId.hashCode ^
      birthDate.hashCode ^
      isHidden.hashCode ^
      name.hashCode;

  @override
  String toString() => name;

  static Person remote(PersonResponseDto dto) {
    return Person(
      remoteId: dto.id,
      isHidden: dto.isHidden,
      name: dto.name,
      birthDate: dto.birthDate,
    );
  }

  static List<Person> remoteList(List<PersonResponseDto> dto) {
    final people = <Person>[];
    for (final personDto in dto) {
      people.add(remote(personDto));
    }

    return people;
  }

  /// Sorts the given list in a deterministic and user friendly way.
  /// For usability reasons people is returned.
  static List<Person> sortList(List<Person> people) {
    people.sort((a, b) {
      final aNameEmpty = a.name.isEmpty;
      final bNameEmpty = b.name.isEmpty;

      if (aNameEmpty && bNameEmpty) {
        return 0;
      }

      if (aNameEmpty && !bNameEmpty) {
        return 1;
      }

      if (bNameEmpty && !aNameEmpty) {
        return -1;
      }

      return a.name.compareTo(b.name);
    });

    return people;
  }
}
