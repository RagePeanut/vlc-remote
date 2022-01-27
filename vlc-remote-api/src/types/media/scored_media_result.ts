import MediaResult from './media_result';

type ScoredMediaResult = MediaResult & { score: number };

export default ScoredMediaResult;