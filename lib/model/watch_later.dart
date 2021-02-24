class WatchLater {
  String id;
  String videoId;

  WatchLater({this.id, this.videoId});

  factory WatchLater.fromJson(Map<String, dynamic> json) =>
      WatchLater(id: json['id'], videoId: json['video_id']);
}
