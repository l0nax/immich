import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:immich_mobile/modules/album/providers/album.provider.dart';
import 'package:immich_mobile/modules/search/models/curated_content.dart';
import 'package:immich_mobile/modules/search/models/search_page_state.model.dart';
import 'package:immich_mobile/modules/search/services/person.service.dart';

import 'package:immich_mobile/modules/search/services/search.service.dart';
import 'package:openapi/api.dart';

class SearchPageStateNotifier extends StateNotifier<SearchPageState> {
  SearchPageStateNotifier(this._searchService, this._ref)
      : super(
          SearchPageState(
            searchTerm: "",
            isSearchEnabled: false,
            searchSuggestion: [],
            userSuggestedSearchTerms: [],
            suggestedAlbums: null,
          ),
        );

  final SearchService _searchService;
  final Ref _ref;

  void enableSearch() {
    state = state.copyWith(isSearchEnabled: true);
  }

  void disableSearch() {
    state = state.copyWith(isSearchEnabled: false);
  }

  void setSearchTerm(String value) {
    state = state.copyWith(searchTerm: value);

    _getSearchSuggestion(state.searchTerm);
    _updateSuggestedAlbums(state.searchTerm);
    _updateSuggestedPeople(state.searchTerm);
  }

  void _getSearchSuggestion(String searchTerm) {
    var searchList = state.userSuggestedSearchTerms;

    var newList = searchList.where((e) => e.toLowerCase().contains(searchTerm));

    state = state.copyWith(searchSuggestion: [...newList]);

    if (searchTerm.isEmpty) {
      state = state.copyWith(searchSuggestion: []);
    }
  }

  void getSuggestedSearchTerms() async {
    var userSuggestedSearchTerms =
        await _searchService.getUserSuggestedSearchTerms();

    state = state.copyWith(userSuggestedSearchTerms: userSuggestedSearchTerms);
  }

  void _updateSuggestedAlbums(String searchTerm) async {
    await _ref.read(albumProvider.notifier).getAllAlbums();

    final albums = _ref
        .read(albumProvider)
        .where((a) => a.name.toLowerCase().contains(searchTerm))
        .toList();

    state = state.copyWith(suggestedAlbums: albums);
  }

  void _updateSuggestedPeople(String searchTerm) async {
    final PersonService personService = _ref.read(personServiceProvider);
    final curatedPeople = await personService.getCuratedPeople();

    final rr = curatedPeople
        .map((p) => CuratedContent(id: p.id, label: p.name))
        .where(
          (p) =>
              p.label.isNotEmpty && p.label.toLowerCase().contains(searchTerm),
        )
        .toList();

    state = state.copyWith(suggestedPeople: rr);
  }
}

final searchPageStateProvider =
    StateNotifierProvider<SearchPageStateNotifier, SearchPageState>((ref) {
  return SearchPageStateNotifier(ref.watch(searchServiceProvider), ref);
});

final getCuratedLocationProvider =
    FutureProvider.autoDispose<List<CuratedLocationsResponseDto>>((ref) async {
  final SearchService searchService = ref.watch(searchServiceProvider);

  var curatedLocation = await searchService.getCuratedLocation();
  return curatedLocation ?? [];
});
