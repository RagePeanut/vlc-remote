import { Request, Response } from 'express';

import { EpisodeInfoFinder, MediaFinderByImdbId, MediaFinderByTmdbId, MovieFinder, MovieInfoFinder, SeriesFinder, SeriesInfoFinder, TitlePartRemover } from '../impl/finders';
import { MediaQuery } from '../models';
import TMDb from '../services/tmdb';

export default class MediaController {
    private tmdb: TMDb;

    constructor() {
        this.tmdb = TMDb.Instance;
    }

    find = async (req: Request, res: Response) => {
        const query = req.query['query'] as string;
        if(!query) res.sendStatus(400);

        const titlePartRemover = new TitlePartRemover(null, this.tmdb);
        const mediaFinders = new MovieFinder(new SeriesFinder(titlePartRemover, this.tmdb), this.tmdb);
        titlePartRemover.next = mediaFinders;
        
        const mediaQuery = new MediaQuery(query);
        const results = await mediaFinders.find(mediaQuery, req.query);
        if(results) {
            const infoFinders = new MovieInfoFinder(new SeriesInfoFinder(new EpisodeInfoFinder(null, this.tmdb), this.tmdb), this.tmdb);
            while(results.length > 0) {
                const media = await infoFinders.find(results.shift(), mediaQuery, req.query);
                if(media) {
                    return res.json(media);
                }
            }
        }

        res.sendStatus(404);
    }

    findById = async (req: Request, res: Response) => {
        const id = req.query['id'] as string;
        if(!id) res.sendStatus(400);
        const complete = req.query['complete'] !== 'false';

        const finders = new MediaFinderByImdbId(new MediaFinderByTmdbId(null, this.tmdb), this.tmdb);
        const media = await finders.find(id, complete, req.query);
        if(media) {
            return res.json(media);
        }
        res.sendStatus(404);
    }
}