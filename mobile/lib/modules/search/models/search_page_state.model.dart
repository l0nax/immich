import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:immich_mobile/modules/search/models/curated_content.dart';
import 'package:immich_mobile/shared/models/album.dart';

class SearchPageState {
  final String searchTerm;
  final bool isSearchEnabled;
  final List<String> searchSuggestion;
  final List<String> userSuggestedSearchTerms;
  final List<Album>? suggestedAlbums;
  final List<CuratedContent>? suggestedPeople;

  SearchPageState({
    required this.searchTerm,
    required this.isSearchEnabled,
    required this.searchSuggestion,
    required this.userSuggestedSearchTerms,
    this.suggestedAlbums,
    this.suggestedPeople,
  });

  SearchPageState copyWith({
    String? searchTerm,
    bool? isSearchEnabled,
    List<String>? searchSuggestion,
    List<String>? userSuggestedSearchTerms,
    List<Album>? suggestedAlbums,
    List<CuratedContent>? suggestedPeople,
    List<CuratedContent>? availablePeople,
  }) {
    return SearchPageState(
      searchTerm: searchTerm ?? this.searchTerm,
      isSearchEnabled: isSearchEnabled ?? this.isSearchEnabled,
      searchSuggestion: searchSuggestion ?? this.searchSuggestion,
      userSuggestedSearchTerms:
          userSuggestedSearchTerms ?? this.userSuggestedSearchTerms,
      suggestedAlbums: suggestedAlbums ?? this.suggestedAlbums,
      suggestedPeople: suggestedPeople ?? this.suggestedPeople,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'searchTerm': searchTerm,
      'isSearchEnabled': isSearchEnabled,
      'searchSuggestion': searchSuggestion,
      'userSuggestedSearchTerms': userSuggestedSearchTerms,
    };
  }

  factory SearchPageState.fromMap(Map<String, dynamic> map) {
    return SearchPageState(
      searchTerm: map['searchTerm'] ?? '',
      isSearchEnabled: map['isSearchEnabled'] ?? false,
      searchSuggestion: List<String>.from(map['searchSuggestion']),
      userSuggestedSearchTerms:
          List<String>.from(map['userSuggestedSearchTerms']),
    );
  }

  String toJson() => json.encode(toMap());

  factory SearchPageState.fromJson(String source) =>
      SearchPageState.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SearchPageState(searchTerm: $searchTerm, isSearchEnabled: $isSearchEnabled, searchSuggestion: $searchSuggestion, userSuggestedSearchTerms: $userSuggestedSearchTerms)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is SearchPageState &&
        other.searchTerm == searchTerm &&
        other.isSearchEnabled == isSearchEnabled &&
        listEquals(other.searchSuggestion, searchSuggestion) &&
        listEquals(other.userSuggestedSearchTerms, userSuggestedSearchTerms);
  }

  @override
  int get hashCode {
    return searchTerm.hashCode ^
        isSearchEnabled.hashCode ^
        searchSuggestion.hashCode ^
        userSuggestedSearchTerms.hashCode;
  }
}
