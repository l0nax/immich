import 'package:collection/collection.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:immich_mobile/shared/models/asset.dart';
import 'package:immich_mobile/shared/models/asset_person.dart';
import 'package:immich_mobile/shared/models/person.dart';
import 'package:immich_mobile/shared/providers/api.provider.dart';
import 'package:immich_mobile/shared/providers/db.provider.dart';
import 'package:immich_mobile/utils/diff.dart';
import 'package:isar/isar.dart';
import 'package:logging/logging.dart';
import 'package:openapi/api.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'api.service.dart';

part 'person.service.g.dart';

@riverpod
PersonService personService(PersonServiceRef ref) =>
    PersonService(ref.read(apiServiceProvider), ref.read(dbProvider));

class PersonService {
  final Logger _log = Logger("PersonService");
  final ApiService _apiService;
  final Isar _db;

  PersonService(this._apiService, this._db);

  Future<List<Person>> getCuratedPeople() async {
    try {
      final persons =
          await _db.persons.filter().isHiddenEqualTo(false).findAll();

      return Person.sortList(persons);
    } catch (error, stack) {
      _log.severe("Error while fetching local people", error, stack);
      return [];
    }
  }

  Future<List<PersonResponseDto>> getRemotePeople() async {
    try {
      final peopleResponseDto = await _apiService.personApi.getAllPeople();
      return peopleResponseDto?.people ?? [];
    } catch (error, stack) {
      _log.severe("Error while fetching curated people", error, stack);
      return [];
    }
  }

  Future<bool> refreshPeople() async {
    try {
      _log.info("Refreshing people");

      final remotePeople = await getRemotePeople();
      final localPeople = await getCuratedPeople();

      remotePeople.sortBy((e) => e.id);

      final List<Id> toDelete = [];
      final List<Person> toAdd = [];
      final List<Person> toUpdate = [];

      final changed = diffSortedListsSync(
        remotePeople,
        localPeople,
        compare: (PersonResponseDto a, Person b) => a.id.compareTo(b.remoteId),
        both: (PersonResponseDto a, Person b) => _isRemoteEqual(a, b, toUpdate),
        onlyFirst: (PersonResponseDto p) => toAdd.add(Person.remote(p)),
        onlySecond: (Person p) => toDelete.add(p.id),
      );

      if (!changed || (toDelete.isEmpty && toAdd.isEmpty && toUpdate.isEmpty)) {
        _log.info("Local and remote people data is in sync");
        return true;
      }

      try {
        await _db.writeTxn(() async {
          await _db.persons.putAll(toUpdate);
          await _db.persons.putAll(toAdd);
          await _db.persons.deleteAll(toDelete);

          // delete all Asset<->Person links
          for (final personId in toDelete) {
            await _db.assetPersons
                .where()
                .filter()
                .peopleIdEqualTo(personId)
                .deleteAll();
          }
        });
      } on IsarError catch (error) {
        _log.severe("Failed to sync remote people with DB", error);
      }

      return true;
    } catch (error, stack) {
      _log.severe("Error while refreshing people", error, stack);
      return false;
    }
  }

  /// Compares if the local object is different from the remote one
  /// and adds it to updateList if true.
  bool _isRemoteEqual(
    PersonResponseDto remote,
    Person local,
    List<Person> updateList,
  ) {
    var remotePerson = Person.remote(remote);
    remotePerson.id = local.id;

    if (remotePerson != local) {
      updateList.add(remotePerson);
      return true;
    }

    return false;
  }

  Future<List<Asset>?> getPersonAssets(String id) async {
    try {
      final assets = await _apiService.personApi.getPersonAssets(id);
      return assets?.map((e) => Asset.remote(e)).toList();
    } catch (error, stack) {
      _log.severe("Error while fetching person assets", error, stack);
    }
    return null;
  }

  Future<PersonResponseDto?> updateName(String id, String name) async {
    try {
      return await _apiService.personApi.updatePerson(
        id,
        PersonUpdateDto(
          name: name,
        ),
      );
    } catch (error, stack) {
      _log.severe("Error while updating person name", error, stack);
    }
    return null;
  }
}
