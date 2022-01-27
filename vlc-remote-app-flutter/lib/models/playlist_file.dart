import 'file/file.dart';

class PlaylistFile extends File {
    PlaylistFile.fromNode(dynamic node)
      : this.id = node["id"],
        this.currentlyPlaying = node["current"] == "current",
        this.duration = node["duration"],
        super.fromNode(node);
    
    final String id;
    final bool currentlyPlaying;
    final int duration;

    @override
    List<Object> get props => [id, duration, ...super.props];
}