import 'package:flutter/material.dart';
import 'package:immich_mobile/extensions/build_context_extensions.dart';
import 'package:immich_mobile/modules/search/models/curated_content.dart';
import 'package:immich_mobile/shared/models/store.dart';
import 'package:immich_mobile/utils/image_url_builder.dart';

class CuratedPeopleColumn extends StatelessWidget {
  final List<CuratedContent> content;

  /// Callback with the content and the index when tapped
  final Function(CuratedContent, int)? onTap;
  final Function(CuratedContent, int)? onNameTap;

  const CuratedPeopleColumn({
    super.key,
    required this.content,
    required this.onTap,
    this.onNameTap,
  });

  @override
  Widget build(BuildContext context) {
    const imageSize = 42.0;

    if (content.isEmpty) {
      return Container();
    }

    return ListView.builder(
      itemCount: content.length,
      itemBuilder: (context, index) {
        final person = content[index];
        final headers = {
          "Authorization": "Bearer ${Store.get(StoreKey.accessToken)}",
        };
        return Padding(
          padding: const EdgeInsets.only(right: 18.0),
          child: SizedBox(
            width: imageSize,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => onTap?.call(person, index),
                  child: SizedBox(
                    height: imageSize,
                    child: Material(
                      shape: const CircleBorder(side: BorderSide.none),
                      elevation: 3,
                      child: CircleAvatar(
                        maxRadius: imageSize / 2,
                        backgroundImage: NetworkImage(
                          getFaceThumbnailUrl(person.id),
                          headers: headers,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    person.label,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: context.textTheme.labelLarge,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
