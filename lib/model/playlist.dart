// To parse this JSON data, do
//
//     final playlist = playlistFromJson(jsonString);

import 'dart:convert';

Playlist playlistFromJson(String str) => Playlist.fromJson(json.decode(str));

String playlistToJson(Playlist data) => json.encode(data.toJson());

class Playlist {
  Playlist({
    this.kind,
    this.etag,
    this.nextPageToken,
    this.pageInfo,
    this.items,
  });

  String kind;
  String etag;
  String nextPageToken;
  PageInfo pageInfo;
  List<Item> items;

  factory Playlist.fromJson(Map<String, dynamic> json) => Playlist(
    kind: json["kind"] == null ? null : json["kind"],
    etag: json["etag"] == null ? null : json["etag"],
    nextPageToken: json["nextPageToken"] == null ? null : json["nextPageToken"],
    pageInfo: json["pageInfo"] == null ? null : PageInfo.fromJson(json["pageInfo"]),
    items: json["items"] == null ? null : List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "kind": kind == null ? null : kind,
    "etag": etag == null ? null : etag,
    "nextPageToken": nextPageToken == null ? null : nextPageToken,
    "pageInfo": pageInfo == null ? null : pageInfo.toJson(),
    "items": items == null ? null : List<dynamic>.from(items.map((x) => x.toJson())),
  };
}

class Item {
  Item({
    this.kind,
    this.etag,
    this.id,
    this.snippet,
  });

  Kind kind;
  String etag;
  String id;
  Snippet snippet;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    kind: json["kind"] == null ? null : kindValues.map[json["kind"]],
    etag: json["etag"] == null ? null : json["etag"],
    id: json["id"] == null ? null : json["id"],
    snippet: json["snippet"] == null ? null : Snippet.fromJson(json["snippet"]),
  );

  Map<String, dynamic> toJson() => {
    "kind": kind == null ? null : kindValues.reverse[kind],
    "etag": etag == null ? null : etag,
    "id": id == null ? null : id,
    "snippet": snippet == null ? null : snippet.toJson(),
  };
}

enum Kind { YOUTUBE_PLAYLIST }

final kindValues = EnumValues({
  "youtube#playlist": Kind.YOUTUBE_PLAYLIST
});

class Snippet {
  Snippet({
    this.publishedAt,
    this.channelId,
    this.title,
    this.description,
    this.thumbnails,
    this.channelTitle,
    this.localized,
  });

  DateTime publishedAt;
  ChannelId channelId;
  String title;
  String description;
  Thumbnails thumbnails;
  ChannelTitle channelTitle;
  Localized localized;

  factory Snippet.fromJson(Map<String, dynamic> json) => Snippet(
    publishedAt: json["publishedAt"] == null ? null : DateTime.parse(json["publishedAt"]),
    channelId: json["channelId"] == null ? null : channelIdValues.map[json["channelId"]],
    title: json["title"] == null ? null : json["title"],
    description: json["description"] == null ? null : json["description"],
    thumbnails: json["thumbnails"] == null ? null : Thumbnails.fromJson(json["thumbnails"]),
    channelTitle: json["channelTitle"] == null ? null : channelTitleValues.map[json["channelTitle"]],
    localized: json["localized"] == null ? null : Localized.fromJson(json["localized"]),
  );

  Map<String, dynamic> toJson() => {
    "publishedAt": publishedAt == null ? null : publishedAt.toIso8601String(),
    "channelId": channelId == null ? null : channelIdValues.reverse[channelId],
    "title": title == null ? null : title,
    "description": description == null ? null : description,
    "thumbnails": thumbnails == null ? null : thumbnails.toJson(),
    "channelTitle": channelTitle == null ? null : channelTitleValues.reverse[channelTitle],
    "localized": localized == null ? null : localized.toJson(),
  };
}

enum ChannelId { UCW5_YEU_ER_MMLNQO4_OQ8_VW_UPG }

final channelIdValues = EnumValues({
  "UCW5YeuERMmlnqo4oq8vwUpg": ChannelId.UCW5_YEU_ER_MMLNQO4_OQ8_VW_UPG
});

enum ChannelTitle { THE_NET_NINJA }

final channelTitleValues = EnumValues({
  "The Net Ninja": ChannelTitle.THE_NET_NINJA
});

class Localized {
  Localized({
    this.title,
    this.description,
  });

  String title;
  String description;

  factory Localized.fromJson(Map<String, dynamic> json) => Localized(
    title: json["title"] == null ? null : json["title"],
    description: json["description"] == null ? null : json["description"],
  );

  Map<String, dynamic> toJson() => {
    "title": title == null ? null : title,
    "description": description == null ? null : description,
  };
}

class Thumbnails {
  Thumbnails({
    this.thumbnailsDefault,
    this.medium,
    this.high,
    this.standard,
    this.maxres,
  });

  Default thumbnailsDefault;
  Default medium;
  Default high;
  Default standard;
  Default maxres;

  factory Thumbnails.fromJson(Map<String, dynamic> json) => Thumbnails(
    thumbnailsDefault: json["default"] == null ? null : Default.fromJson(json["default"]),
    medium: json["medium"] == null ? null : Default.fromJson(json["medium"]),
    high: json["high"] == null ? null : Default.fromJson(json["high"]),
    standard: json["standard"] == null ? null : Default.fromJson(json["standard"]),
    maxres: json["maxres"] == null ? null : Default.fromJson(json["maxres"]),
  );

  Map<String, dynamic> toJson() => {
    "default": thumbnailsDefault == null ? null : thumbnailsDefault.toJson(),
    "medium": medium == null ? null : medium.toJson(),
    "high": high == null ? null : high.toJson(),
    "standard": standard == null ? null : standard.toJson(),
    "maxres": maxres == null ? null : maxres.toJson(),
  };
}

class Default {
  Default({
    this.url,
    this.width,
    this.height,
  });

  String url;
  int width;
  int height;

  factory Default.fromJson(Map<String, dynamic> json) => Default(
    url: json["url"] == null ? null : json["url"],
    width: json["width"] == null ? null : json["width"],
    height: json["height"] == null ? null : json["height"],
  );

  Map<String, dynamic> toJson() => {
    "url": url == null ? null : url,
    "width": width == null ? null : width,
    "height": height == null ? null : height,
  };
}

class PageInfo {
  PageInfo({
    this.totalResults,
    this.resultsPerPage,
  });

  int totalResults;
  int resultsPerPage;

  factory PageInfo.fromJson(Map<String, dynamic> json) => PageInfo(
    totalResults: json["totalResults"] == null ? null : json["totalResults"],
    resultsPerPage: json["resultsPerPage"] == null ? null : json["resultsPerPage"],
  );

  Map<String, dynamic> toJson() => {
    "totalResults": totalResults == null ? null : totalResults,
    "resultsPerPage": resultsPerPage == null ? null : resultsPerPage,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
