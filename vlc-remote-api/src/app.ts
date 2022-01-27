import express from 'express';
import dotenv from 'dotenv';
import morgan from 'morgan';
import cors from 'cors';

import {
    ConfigurationController,
    MediaController,
    TranslationController,
} from './controllers';

dotenv.config();
const app = express();
const configController = new ConfigurationController();
const mediaController = new MediaController();
const translationController = new TranslationController();

app.use(cors());

app.use(morgan('dev'));

app.get('/configuration', configController.get);

app.get('/find', mediaController.find);

app.get('/find_by_id', mediaController.findById);

app.get('/translations/:lng', translationController.get);

app.listen(process.env.PORT, () => {
    console.log(`Server is running on ${process.env.PORT}`);
});
