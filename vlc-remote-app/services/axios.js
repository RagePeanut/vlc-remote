import axios from 'axios';
import { Buffer } from 'buffer';

// import { API_URL } from '@env';

// axios.defaults.headers.common['Content-Type'] = 'application/json';

export const companion = axios.create({
    baseURL: 'http://192.168.1.8:27797/',
    headers: {
        'Content-Type': 'application/json',
    },
});

export const tmdb = axios.create({
    baseURL: 'https://vlc-remote-api.herokuapp.com/',
    headers: {
        'Content-Type': 'application/json',
    },
});

export const vlc = axios.create({
    baseURL: 'http://192.168.1.8:8080/requests/',
    withCredentials: true,
    headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Basic ' + Buffer.from(':password', 'utf-8').toString('base64'),
    },
});

// TODO: bearer token interceptor
// instances.vlc.interceptors.request.use(config => {

// });

export default axios;