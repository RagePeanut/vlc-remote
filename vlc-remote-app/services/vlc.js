import store from '../store';
import { fetchStatusData } from '../store/thunks/status';

const dispatchThunk = params => {
    store.dispatch(fetchStatusData(params));
}

export const changeVolume = volume => {
    dispatchThunk({ command: 'volume', val: volume });
}

export const play = id => {
    dispatchThunk({ command: 'pl_play', id: id });
}

export const removeFromPlaylist = id => {
    dispatchThunk({ command: 'pl_delete', id: id });
}

export const seek = time => {
    dispatchThunk({ command: 'seek', val: time });
}

export const seekChapter = chapter => {
    dispatchThunk({ command: 'chapter', val: chapter });
};

export const switchAudioTrack = () => {
    dispatchThunk({ command: 'key', val: 'audio-track' });
}

export const switchSubtitleTrack = () => {
    dispatchThunk({ command: 'key', val: 'subtitle-track' });
}

export const switchVideoTrack = () => {
    dispatchThunk({ command: 'key', val: 'video-track' });
}

export const toggleFullscreen = () => {
    dispatchThunk({ command: 'fullscreen' });
};

export const togglePause = () => {
    dispatchThunk({ command: 'pl_pause' });
};