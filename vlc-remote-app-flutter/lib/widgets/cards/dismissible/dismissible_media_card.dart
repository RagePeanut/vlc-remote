import 'package:flutter/material.dart';

import '../../../models/media/media.dart';
import '../media_card.dart';
import 'dismissible_card.dart';

class DismissibleMediaCard extends StatelessWidget {
    DismissibleMediaCard({
        @required this.media,
        @required this.onDismissed,
    });

    final Media media;
    final VoidCallback onDismissed;

    @override
    Widget build(BuildContext context) {
        return DismissibleCard(
            card: MediaCard(
                media: media,
            ),
            onDismissed: onDismissed,
        );
    }

}