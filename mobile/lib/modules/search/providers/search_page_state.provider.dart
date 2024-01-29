import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:immich_mobile/modules/search/models/curated_content.dart';
import 'package:immich_mobile/modules/search/models/search_page_state.model.dart';

import 'package:immich_mobile/modules/search/services/search.service.dart';
import 'package:openapi/api.dart';

class SearchPageStateNotifier extends StateNotifier<SearchPageState> {
  SearchPageStateNotifier(this._searchService)
      : super(
          SearchPageState(
            searchTerm: "",
            isSearchEnabled: false,
            searchSuggestion: [],
            userSuggestedSearchTerms: [],
            peopleWithNames: [],
          ),
        );

  final SearchService _searchService;

  /// A list of all people tagged with a name of the current user.
  List<CuratedContent>? peopleWithNames;

  void enableSearch() {
    state = state.copyWith(isSearchEnabled: true);
  }

  void disableSearch() {
    state = state.copyWith(isSearchEnabled: false);
  }

  void setSearchTerm(String value) {
    state = state.copyWith(searchTerm: value);

    getPeopleWithNames();
    _getSearchSuggestion(state.searchTerm);
  }

  void _getSearchSuggestion(String searchTerm) {
    var searchList = state.userSuggestedSearchTerms;

    var newList = searchList.where((e) => e.toLowerCase().contains(searchTerm));

    state = state.copyWith(searchSuggestion: [...newList]);

    if (searchTerm.isEmpty) {
      state = state.copyWith(searchSuggestion: []);
    }

    _filterPeopleSuggestion();
  }

  void _filterPeopleSuggestion() {
    if (peopleWithNames == null) {
      return;
    }
    if (state.searchTerm.isEmpty) {
      state = state.copyWith(peopleWithNames: peopleWithNames);
      return;
    }

    final suggestedPeople = peopleWithNames!
        .where((element) => element.label.contains(state.searchTerm))
        .toList();
    state = state.copyWith(peopleWithNames: suggestedPeople);
  }

  void getPeopleWithNames() async {
    if (peopleWithNames != null) return;
    peopleWithNames = (await _searchService.getCuratedPeopleWithNames()) ?? [];

    // since setSearchTerm already finished processing, we simply
    // recreate the suggestion list
    _filterPeopleSuggestion();
  }

  void getSuggestedSearchTerms() async {
    var userSuggestedSearchTerms =
        await _searchService.getUserSuggestedSearchTerms();

    state = state.copyWith(userSuggestedSearchTerms: userSuggestedSearchTerms);
  }
}

final searchPageStateProvider =
    StateNotifierProvider<SearchPageStateNotifier, SearchPageState>((ref) {
  return SearchPageStateNotifier(ref.watch(searchServiceProvider));
});

final getCuratedLocationProvider =
    FutureProvider.autoDispose<List<CuratedLocationsResponseDto>>((ref) async {
  final SearchService searchService = ref.watch(searchServiceProvider);

  var curatedLocation = await searchService.getCuratedLocation();
  return curatedLocation ?? [];
});
