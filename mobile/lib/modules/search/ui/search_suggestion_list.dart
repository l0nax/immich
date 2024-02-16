import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:immich_mobile/extensions/build_context_extensions.dart';
import 'package:immich_mobile/modules/search/providers/search_page_state.provider.dart';
import 'package:immich_mobile/routing/router.dart';

class SearchSuggestionList extends ConsumerWidget {
  const SearchSuggestionList({super.key, required this.onSubmitted});

  final Function(String) onSubmitted;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchTerm = ref.watch(searchPageStateProvider).searchTerm;
    final searchSuggestion =
        ref.watch(searchPageStateProvider).searchSuggestion;
    final suggestedAlbums = ref.watch(searchPageStateProvider).suggestedAlbums;
    final suggestedPeople = ref.watch(searchPageStateProvider).suggestedPeople;

    buildSuggestedPeople() {
      if (suggestedPeople == null || suggestedPeople.isEmpty) {
        return [];
      }

      final list = <Widget>[];
      for (final person in suggestedPeople) {
        list.add(
          ListTile(
            leading: const Icon(Icons.person_outline),
            title: Text(person.label),
            onTap: () => context.pushRoute(
              PersonResultRoute(
                personId: person.id,
                personName: person.label,
              ),
            ),
          ),
        );
      }

      return list;
    }

    buildSuggestedAlbum() {
      if (suggestedAlbums == null || suggestedAlbums.isEmpty) {
        return [];
      }

      final list = <Widget>[];

      for (final album in suggestedAlbums) {
        list.add(
          ListTile(
            leading: const Icon(Icons.photo_album_outlined),
            title: Text(album.name),
            onTap: () => context.pushRoute(
              AlbumViewerRoute(albumId: album.id),
            ),
          ),
        );
      }

      return list;
    }

    return Container(
      color: context.scaffoldBackgroundColor,
      child: ListView(
        children: [
          if (searchTerm.isNotEmpty)
            ListTile(
              leading: const Icon(Icons.search_outlined),
              title: Text("Search for \"$searchTerm\""),
              onTap: () => onSubmitted(searchTerm),
            ),
          ...buildSuggestedPeople(),
          ...buildSuggestedAlbum(),
        ],
      ),
    );
  }
}
