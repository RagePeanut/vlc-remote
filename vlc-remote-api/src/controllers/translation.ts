import { Request, Response } from 'express';

const translations = new Map([
    ['en', require('../../locales/en')],
    ['fr', require('../../locales/fr')]
]);

export default class TranslationController {
    get = async (req: Request, res: Response) => {
        const lng = req.params.lng;
        res.json(translations.get(lng));
    }
}