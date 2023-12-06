import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:immich_mobile/modules/home/ui/asset_grid/asset_grid_data_structure.dart';
import 'package:immich_mobile/modules/search/models/curated_content.dart';
import 'package:immich_mobile/modules/settings/providers/app_settings.provider.dart';
import 'package:immich_mobile/modules/settings/services/app_settings.service.dart';
import 'package:immich_mobile/shared/models/person.dart';
import 'package:immich_mobile/shared/providers/db.provider.dart';
import 'package:isar/isar.dart';
import 'package:logging/logging.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../services/person.service.dart';

part 'people.provider.g.dart';

@riverpod
class PeopleNotifier extends _$PeopleNotifier {
  final log = Logger('PeopleNotifier');

  @override
  Future<bool> build() async {
    return false;
  }

  Future<void> getAllPeople() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final PersonService personService = ref.read(personServiceProvider);
      await personService.refreshPeople();

      // trigger update
      final oldState = state.value ?? false;
      return !oldState;
    });
  }
}

@riverpod
Future<List<CuratedContent>> getCuratedPeople(GetCuratedPeopleRef ref) async {
  final people = await ref.watch(personServiceProvider).getCuratedPeople();

  return people
      .map((p) => CuratedContent(id: p.remoteId, label: p.name))
      .toList();
}

@riverpod
Future<RenderList> personAssets(PersonAssetsRef ref, String personId) async {
  final PersonService personService = ref.read(personServiceProvider);
  final assets = await personService.getPersonAssets(personId);
  if (assets == null) {
    return RenderList.empty();
  }

  final settings = ref.read(appSettingsServiceProvider);
  final groupBy =
      GroupAssetsBy.values[settings.getSetting(AppSettingsEnum.groupAssetsBy)];
  return await RenderList.fromAssets(assets, groupBy);
}

@riverpod
Future<bool> updatePersonName(
  UpdatePersonNameRef ref,
  String personId,
  String updatedName,
) async {
  final PersonService personService = ref.read(personServiceProvider);
  final person = await personService.updateName(personId, updatedName);

  if (person != null && person.name == updatedName) {
    // update people list
    await ref.read(personServiceProvider).refreshPeople();
    ref.invalidate(getCuratedPeopleProvider);

    return true;
  }

  return false;
}
