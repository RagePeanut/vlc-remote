import { Request, Response } from 'express';

import { Configuration } from '../models';

export default class ConfigurationController {
    private config: Configuration;

    constructor() {
        this.config = new Configuration();
    }

    get = async (_req: Request, res: Response) => {
        if(!this.config.hasBeenUpdated) await this.config.update();
        res.json(this.config.toJson());
    }
};