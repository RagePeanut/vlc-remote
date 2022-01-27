import 'package:flutter/foundation.dart';


class PosterConfiguration {
    final String baseUrl;
    final Map<String, int> posterSizes;

    PosterConfiguration({
        @required Map<String, dynamic> data,
    }) : this.baseUrl = data["base_url"],
         this.posterSizes = Map<String, int>.from(data["poster_sizes"]);

    String getPosterUrl(String path) {
        return baseUrl + posterSizes.keys.last + path;
    }

    String getPosterUrlForWidth(String path, double width) {
        List<MapEntry<String, int>> sizes = posterSizes.entries.toList();

        int a = -1, b = sizes.length - 1;
        while(b - a > 1) {
            int middle = a + (b-a) ~/ 2;
            if(width > sizes[middle].value) {
                a = middle;
            } else {
                b = middle;
            }

        }
        
        return baseUrl + sizes[b].key + path;
    }
}