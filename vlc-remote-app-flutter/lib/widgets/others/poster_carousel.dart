import 'package:flutter/material.dart';
import 'package:preload_page_view/preload_page_view.dart';

import '../../models/media/media.dart';
import 'poster.dart';

typedef VoidCallbackInt = void Function(int);

class PosterCarousel extends StatefulWidget {
    PosterCarousel({
        int initialIndex,
        List<Media> medias,
        @required this.onPosterChanged,
        this.callOnPointerUp = true,
    }) : this.initialIndex = initialIndex ?? 0,
         this.medias = medias.length > 0 ? medias : [ null ];

    final bool callOnPointerUp;
    final int initialIndex;
    final List<Media> medias;
    final VoidCallbackInt onPosterChanged;

    @override
    _PosterCarouselState createState() => _PosterCarouselState();
}

class _PosterCarouselState extends State<PosterCarousel> {
    PreloadPageController controller;

    @override
    void initState() {
        super.initState();
        controller = PreloadPageController(
            initialPage: widget.initialIndex,
        );
    }

    @override
    void dispose() {
        controller.dispose();
        super.dispose();
    }

    @override
    Widget build(BuildContext context) {
        if(controller.hasClients) controller.animateToPage(widget.initialIndex, duration: Duration(milliseconds: 200), curve: Curves.easeInOut);
        int pageIndex = widget.initialIndex;
        List<int> pointers = [];
        return Listener(
            child: PreloadPageView(
                controller: controller,
                children: widget.medias.map((Media media) => Center(
                    child: Poster(media: media),
                )).toList(),
                preloadPagesCount: 3,
                onPageChanged: (int index) {
                    pageIndex = index;
                    if(!widget.callOnPointerUp) widget.onPosterChanged(index);
                    else if(pointers.length == 0 && index != widget.initialIndex) widget.onPosterChanged(index);
                },
            ),
            onPointerDown: (PointerDownEvent event) => pointers.add(event.pointer),
            onPointerUp: (PointerUpEvent event) {
                pointers.remove(event.pointer);
                if(pointers.length == 0 && pageIndex != widget.initialIndex && widget.callOnPointerUp) widget.onPosterChanged(pageIndex);
            },
        );
    }
}