
class FavoriteVideo {
  String id;
  String videoId;
  String userId;
  String createdAt;

  FavoriteVideo({this.id, this.videoId, this.userId, this.createdAt});

  factory FavoriteVideo.fromJson(Map<String, dynamic> json) => FavoriteVideo(
    id: json['id'],
    videoId: json['video_id'],
    userId: json['user_id'],
    createdAt: json['created_at']
  );
}