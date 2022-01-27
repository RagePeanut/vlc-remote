export const nonWordRegex          = /[^a-zA-Z\u00C0-\u00D6\u00D8-\u00F6\u00F8-\u024F\d]+/g,
             yearRegex             = /[^\d](1(?:8(?:8[89]|9\d)|9\d{2})|2\d{3})(?:[^\d]|$)/g,
             seasonEpisodeRegex    = /[Ss](\d+) ?[Ee](\d+)/,
             seasonEpisodeUrlRegex = /\/season\/(\d+)(?:\/episode\/(\d+))?/,
             junkRegex             = / *\w*(\d+[A-Za-z]+|[A-Za-z]+\d+).*$/,
             lastWordRegex         = / [^ ]+$/,
             imdbIdRegex           = /tt\d{7,}/,               // Matches IDs from https://www.imdb.com/
             tmdbIdRegex           = /[1-9]\d*(?:-[^?]+)?/;    // Matches IDs from https://www.themoviedb.org/