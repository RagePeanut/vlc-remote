import React, { createContext, useState, useCallback, useEffect } from 'react';

import { tmdb } from '../services/axios';

const PosterContext = createContext();

export const PosterProvider = ({ children }) => {
    const [ baseUrl, setBaseUrl ] = useState('https://image.tmdb.org/t/p/');
    const [ sizes, setSizes ] = useState({ original: 999999 });

    const getPosterUrl = useCallback(path => {
        return baseUrl + Object.keys(sizes).last + path;
    }, [ baseUrl, sizes ]);

    const getPosterUrlForWidth = useCallback((path, width) => {
        const sizeEntries = Object.entries(sizes);

        let a = -1;
        let b = sizeEntries.length - 1;
        while(b - a > 1) {
            const middle = a + ~~((b - a) / 2);
            if(width > sizeEntries[middle][1]) {
                a = middle;
            } else {
                b = middle;
            }
        }
        return baseUrl + sizeEntries[b][0] + path;
    }, [ baseUrl, sizes ]);

    useEffect(() => {
        (async () => {
            const { data } = await tmdb.get('/configuration');
            setBaseUrl(data.base_url);
            setSizes(data.poster_sizes);
        })();
    }, [ setBaseUrl, setSizes ]);

    return (
        <PosterContext.Provider value={{
            getPosterUrl,
            getPosterUrlForWidth,
        }}>
            { children }
        </PosterContext.Provider>
    );
};

export default PosterContext;