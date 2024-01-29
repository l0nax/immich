import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:immich_mobile/modules/search/models/curated_content.dart';

class SearchPageState {
  final String searchTerm;
  final bool isSearchEnabled;
  final List<String> searchSuggestion;
  final List<String> userSuggestedSearchTerms;
  final List<CuratedContent> peopleWithNames;

  SearchPageState({
    required this.searchTerm,
    required this.isSearchEnabled,
    required this.searchSuggestion,
    required this.userSuggestedSearchTerms,
    required this.peopleWithNames,
  });

  SearchPageState copyWith({
    String? searchTerm,
    bool? isSearchEnabled,
    List<String>? searchSuggestion,
    List<String>? userSuggestedSearchTerms,
    List<CuratedContent>? peopleWithNames,
  }) {
    return SearchPageState(
      searchTerm: searchTerm ?? this.searchTerm,
      isSearchEnabled: isSearchEnabled ?? this.isSearchEnabled,
      searchSuggestion: searchSuggestion ?? this.searchSuggestion,
      userSuggestedSearchTerms:
          userSuggestedSearchTerms ?? this.userSuggestedSearchTerms,
      peopleWithNames: peopleWithNames ?? this.peopleWithNames,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'searchTerm': searchTerm,
      'isSearchEnabled': isSearchEnabled,
      'searchSuggestion': searchSuggestion,
      'userSuggestedSearchTerms': userSuggestedSearchTerms,
      'peopleWithNames': peopleWithNames,
    };
  }

  factory SearchPageState.fromMap(Map<String, dynamic> map) {
    return SearchPageState(
      searchTerm: map['searchTerm'] ?? '',
      isSearchEnabled: map['isSearchEnabled'] ?? false,
      searchSuggestion: List<String>.from(map['searchSuggestion']),
      userSuggestedSearchTerms:
          List<String>.from(map['userSuggestedSearchTerms']),
      peopleWithNames: List<CuratedContent>.from(map['peopleWithNames']),
    );
  }

  String toJson() => json.encode(toMap());

  factory SearchPageState.fromJson(String source) =>
      SearchPageState.fromMap(json.decode(source));

  @override
  String toString() {
    // NOTE:  peopleWithNames is not added to the string
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
        listEquals(other.userSuggestedSearchTerms, userSuggestedSearchTerms) &&
        listEquals(other.peopleWithNames, peopleWithNames);
  }

  @override
  int get hashCode {
    return searchTerm.hashCode ^
        isSearchEnabled.hashCode ^
        searchSuggestion.hashCode ^
        userSuggestedSearchTerms.hashCode ^
        peopleWithNames.hashCode;
  }
}
