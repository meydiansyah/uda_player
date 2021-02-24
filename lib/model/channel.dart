// To parse this JSON data, do
//
//     final channel = channelFromJson(jsonString);

import 'dart:convert';

Channel channelFromJson(String str) => Channel.fromJson(json.decode(str));

String channelToJson(Channel data) => json.encode(data.toJson());

class Channel {
  Channel({
    this.kind,
    this.etag,
    this.pageInfo,
    this.items,
  });

  String kind;
  String etag;
  PageInfo pageInfo;
  List<Item> items;

  factory Channel.fromJson(Map<String, dynamic> json) => Channel(
    kind: json["kind"],
    etag: json["etag"],
    pageInfo: PageInfo.fromJson(json["pageInfo"]),
    items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "kind": kind,
    "etag": etag,
    "pageInfo": pageInfo.toJson(),
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
  };
}

class Item {
  Item({
    this.kind,
    this.etag,
    this.id,
    this.snippet,
    this.statistics,
    this.brandingSettings,
  });

  String kind;
  String etag;
  String id;
  Snippet snippet;
  Statistics statistics;
  BrandingSettings brandingSettings;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    kind: json["kind"],
    etag: json["etag"],
    id: json["id"],
    snippet: Snippet.fromJson(json["snippet"]),
    statistics: Statistics.fromJson(json["statistics"]),
    brandingSettings: BrandingSettings.fromJson(json["brandingSettings"]),
  );

  Map<String, dynamic> toJson() => {
    "kind": kind,
    "etag": etag,
    "id": id,
    "snippet": snippet.toJson(),
    "statistics": statistics.toJson(),
    "brandingSettings": brandingSettings.toJson(),
  };
}

class BrandingSettings {
  BrandingSettings({
    this.channel,
    this.image,
  });

  ChannelClass channel;
  Image image;

  factory BrandingSettings.fromJson(Map<String, dynamic> json) => BrandingSettings(
    channel: ChannelClass.fromJson(json["channel"]),
    image: Image.fromJson(json["image"]),
  );

  Map<String, dynamic> toJson() => {
    "channel": channel.toJson(),
    "image": image.toJson(),
  };
}

class ChannelClass {
  ChannelClass({
    this.title,
    this.description,
    this.keywords,
    this.defaultTab,
    this.showBrowseView,
    this.unsubscribedTrailer,
    this.profileColor,
    this.country,
  });

  String title;
  String description;
  String keywords;
  String defaultTab;
  bool showBrowseView;
  String unsubscribedTrailer;
  String profileColor;
  String country;

  factory ChannelClass.fromJson(Map<String, dynamic> json) => ChannelClass(
    title: json["title"],
    description: json["description"],
    keywords: json["keywords"],
    defaultTab: json["defaultTab"],
    showBrowseView: json["showBrowseView"],
    unsubscribedTrailer: json["unsubscribedTrailer"],
    profileColor: json["profileColor"],
    country: json["country"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "description": description,
    "keywords": keywords,
    "defaultTab": defaultTab,
    "showBrowseView": showBrowseView,
    "unsubscribedTrailer": unsubscribedTrailer,
    "profileColor": profileColor,
    "country": country,
  };
}

class Image {
  Image({
    this.bannerExternalUrl,
  });

  String bannerExternalUrl;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
    bannerExternalUrl: json["bannerExternalUrl"],
  );

  Map<String, dynamic> toJson() => {
    "bannerExternalUrl": bannerExternalUrl,
  };
}

class Snippet {
  Snippet({
    this.title,
    this.description,
    this.customUrl,
    this.publishedAt,
    this.thumbnails,
    this.localized,
    this.country,
  });

  String title;
  String description;
  String customUrl;
  DateTime publishedAt;
  Thumbnails thumbnails;
  Localized localized;
  String country;

  factory Snippet.fromJson(Map<String, dynamic> json) => Snippet(
    title: json["title"],
    description: json["description"],
    customUrl: json["customUrl"],
    publishedAt: DateTime.parse(json["publishedAt"]),
    thumbnails: Thumbnails.fromJson(json["thumbnails"]),
    localized: Localized.fromJson(json["localized"]),
    country: json["country"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "description": description,
    "customUrl": customUrl,
    "publishedAt": publishedAt.toIso8601String(),
    "thumbnails": thumbnails.toJson(),
    "localized": localized.toJson(),
    "country": country,
  };
}

class Localized {
  Localized({
    this.title,
    this.description,
  });

  String title;
  String description;

  factory Localized.fromJson(Map<String, dynamic> json) => Localized(
    title: json["title"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "description": description,
  };
}

class Thumbnails {
  Thumbnails({
    this.thumbnailsDefault,
    this.medium,
    this.high,
  });

  Default thumbnailsDefault;
  Default medium;
  Default high;

  factory Thumbnails.fromJson(Map<String, dynamic> json) => Thumbnails(
    thumbnailsDefault: Default.fromJson(json["default"]),
    medium: Default.fromJson(json["medium"]),
    high: Default.fromJson(json["high"]),
  );

  Map<String, dynamic> toJson() => {
    "default": thumbnailsDefault.toJson(),
    "medium": medium.toJson(),
    "high": high.toJson(),
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
    url: json["url"],
    width: json["width"],
    height: json["height"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "width": width,
    "height": height,
  };
}

class Statistics {
  Statistics({
    this.viewCount,
    this.subscriberCount,
    this.hiddenSubscriberCount,
    this.videoCount,
  });

  String viewCount;
  String subscriberCount;
  bool hiddenSubscriberCount;
  String videoCount;

  factory Statistics.fromJson(Map<String, dynamic> json) => Statistics(
    viewCount: json["viewCount"],
    subscriberCount: json["subscriberCount"],
    hiddenSubscriberCount: json["hiddenSubscriberCount"],
    videoCount: json["videoCount"],
  );

  Map<String, dynamic> toJson() => {
    "viewCount": viewCount,
    "subscriberCount": subscriberCount,
    "hiddenSubscriberCount": hiddenSubscriberCount,
    "videoCount": videoCount,
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
    totalResults: json["totalResults"] == null ? "" : json["totalResults"],
    resultsPerPage: json["resultsPerPage"] == null ? "" : json["resultsPerPage"],
  );

  Map<String, dynamic> toJson() => {
    "totalResults": totalResults,
    "resultsPerPage": resultsPerPage,
  };
}
