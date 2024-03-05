import 'dart:io';

import 'package:http/http.dart';
import 'package:immich_mobile/shared/models/asset.dart';
import 'package:immich_mobile/shared/models/person.dart';
import 'package:immich_mobile/shared/models/store.dart';
import 'package:immich_mobile/shared/providers/api.provider.dart';
import 'package:immich_mobile/shared/providers/db.provider.dart';
import 'package:immich_mobile/shared/services/api.service.dart';
import 'package:isar/isar.dart';
import 'package:logging/logging.dart';
import 'package:openapi/api.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'person.service.g.dart';

@riverpod
PersonService personService(PersonServiceRef ref) =>
    PersonService(ref.read(apiServiceProvider), ref.read(dbProvider));

class PersonService {
  final Logger _log = Logger("PersonService");
  final ApiService _apiService;
  final Isar _db;

  PersonService(this._apiService, this._db);

  get utf8 => null;

  Future<List<Person>> getCuratedPeople() async {
    try {
      final knownEtag = Store.tryGet(StoreKey.peopleETag);
      final response = await _apiService.personApi.getAllPeopleWithHttpInfo(
        ifNoneMatch: knownEtag,
      );

      if (response.statusCode == 304) {
        final people = await _db.persons.where().findAll();
        return people;
      } else if (response.statusCode >= HttpStatus.badRequest) {
        throw ApiException(
          response.statusCode,
          await _decodeBodyBytes(response),
        );
      }

      if (response.body.isNotEmpty &&
          response.statusCode != HttpStatus.noContent) {
        final responseBody = await _decodeBodyBytes(response);
        final etag = response.headers[HttpHeaders.etagHeader];
        final data = (await apiClient.deserializeAsync(
          responseBody,
          'List<AssetResponseDto>',
        ) as List)
            .cast<AssetResponseDto>()
            .toList();
        return (data, etag);
      }

      return peopleResponseDto?.people ?? [];
    } catch (error, stack) {
      _log.severe("Error while fetching curated people", error, stack);
      return [];
    }
  }

  Future<List<Asset>?> getPersonAssets(String id) async {
    try {
      final assets = await _apiService.personApi.getPersonAssets(id);
      if (assets == null) return null;
      return await _db.assets.getAllByRemoteId(assets.map((e) => e.id));
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

  /// Returns the decoded body as UTF-8 if the given headers indicate an 'application/json'
  /// content type. Otherwise, returns the decoded body as decoded by dart:http package.
  Future<String> _decodeBodyBytes(Response response) async {
    final contentType = response.headers['content-type'];
    return contentType != null &&
            contentType.toLowerCase().startsWith('application/json')
        ? response.bodyBytes.isEmpty
            ? ''
            : utf8.decode(response.bodyBytes)
        : response.body;
  }
}
