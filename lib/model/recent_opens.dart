
import 'dart:convert';

RecentOpens recentOpensFromJson(String str) => RecentOpens.fromJson(json.decode(str));

class RecentOpens {
  String videoId;
  String createdAt;
  String time;

  RecentOpens({this.videoId, this.createdAt, this.time});

  RecentOpens.fromJson(Map<String, dynamic> json) {
    videoId = json['video_id'];
    createdAt = json['created_at'];
    time = json['timestamp'];
  }

}