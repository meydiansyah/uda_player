import 'dart:convert';

Video videoFromJson(String str) => Video.fromJson(json.decode(str));

String videoToJson(Video data) => json.encode(data.toJson());

class Video {
  String kind;
  VideoPageinfo pageInfo;
  String etag;
  List<VideoItem> items;

  Video({this.kind, this.pageInfo, this.etag, this.items});

  Video.fromJson(Map<String, dynamic> json) {
    kind = json['kind'];
    pageInfo = json['pageInfo'] != null
        ? new VideoPageinfo.fromJson(json['pageInfo'])
        : null;
    etag = json['etag'];
    if (json['items'] != null) {
      items = new List<VideoItem>();
      (json['items'] as List).forEach((v) {
        items.add(new VideoItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['kind'] = this.kind;
    if (this.pageInfo != null) {
      data['pageInfo'] = this.pageInfo.toJson();
    }
    data['etag'] = this.etag;
    if (this.items != null) {
      data['items'] = this.items.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class VideoPageinfo {
  int totalResults;
  int resultsPerPage;

  VideoPageinfo({this.totalResults, this.resultsPerPage});

  VideoPageinfo.fromJson(Map<String, dynamic> json) {
    totalResults = json['totalResults'];
    resultsPerPage = json['resultsPerPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalResults'] = this.totalResults;
    data['resultsPerPage'] = this.resultsPerPage;
    return data;
  }
}

class VideoItem {
  VideoItemsSnippet snippet;
  String kind;
  String etag;
  String id;
  ContentDetails contentDetails;

  VideoItemsStatistics statistics;

  VideoItem(
      {this.snippet,
      this.kind,
      this.etag,
      this.id,
      this.contentDetails,
      this.statistics});

  VideoItem.fromJson(Map<String, dynamic> json) {
    snippet = json['snippet'] != null
        ? new VideoItemsSnippet.fromJson(json['snippet'])
        : null;
    kind = json['kind'];
    etag = json['etag'];
    id = json['id'];
    statistics = json['statistics'] != null
        ? new VideoItemsStatistics.fromJson(json['statistics'])
        : null;
    contentDetails = json['contentDetails'] != null
        ? new ContentDetails.fromJson(json['contentDetails'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.snippet != null) {
      data['snippet'] = this.snippet.toJson();
    }
    data['kind'] = this.kind;
    data['etag'] = this.etag;
    data['id'] = this.id;
    if (this.statistics != null) {
      data['statistics'] = this.statistics.toJson();
    }
    if (this.contentDetails != null) {
      data['contentDetails'] = this.contentDetails.toJson();
    }
    return data;
  }
}

class ContentDetails {
  ContentDetails({
    this.duration,
    this.dimension,
    this.definition,
    this.caption,
    this.licensedContent,
    this.projection,
  });

  String duration;
  String dimension;
  String definition;
  String caption;
  bool licensedContent;
  String projection;

  factory ContentDetails.fromJson(Map<String, dynamic> json) => ContentDetails(
        duration: json["duration"],
        dimension: json["dimension"],
        definition: json["definition"],
        caption: json["caption"],
        licensedContent: json["licensedContent"],
        projection: json["projection"],
      );

  Map<String, dynamic> toJson() => {
        "duration": duration,
        "dimension": dimension,
        "definition": definition,
        "caption": caption,
        "licensedContent": licensedContent,
        "projection": projection,
      };
}

class VideoItemsSnippet {
  String publishedAt;
  String defaultAudioLanguage;
  VideoItemsSnippetLocalized localized;
  String description;
  String title;
  VideoItemsSnippetThumbnails thumbnails;
  String channelId;
  String categoryId;
  String channelTitle;
  List<String> tags;
  String liveBroadcastContent;

  VideoItemsSnippet(
      {this.publishedAt,
      this.defaultAudioLanguage,
      this.localized,
      this.description,
      this.title,
      this.thumbnails,
      this.channelId,
      this.categoryId,
      this.channelTitle,
      this.tags,
      this.liveBroadcastContent});

  VideoItemsSnippet.fromJson(Map<String, dynamic> json) {
    publishedAt = json['publishedAt'];
    defaultAudioLanguage = json['defaultAudioLanguage'];
    localized = json['localized'] != null
        ? new VideoItemsSnippetLocalized.fromJson(json['localized'])
        : null;
    description = json['description'];
    title = json['title'];
    thumbnails = json['thumbnails'] != null
        ? new VideoItemsSnippetThumbnails.fromJson(json['thumbnails'])
        : null;
    channelId = json['channelId'];
    categoryId = json['categoryId'];
    channelTitle = json['channelTitle'];
    tags = json['tags']?.cast<String>();
    liveBroadcastContent = json['liveBroadcastContent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['publishedAt'] = this.publishedAt;
    data['defaultAudioLanguage'] = this.defaultAudioLanguage;
    if (this.localized != null) {
      data['localized'] = this.localized.toJson();
    }
    data['description'] = this.description;
    data['title'] = this.title;
    if (this.thumbnails != null) {
      data['thumbnails'] = this.thumbnails.toJson();
    }
    data['channelId'] = this.channelId;
    data['categoryId'] = this.categoryId;
    data['channelTitle'] = this.channelTitle;
    data['tags'] = this.tags;
    data['liveBroadcastContent'] = this.liveBroadcastContent;
    return data;
  }
}

class VideoItemsSnippetLocalized {
  String description;
  String title;

  VideoItemsSnippetLocalized({this.description, this.title});

  VideoItemsSnippetLocalized.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['description'] = this.description;
    data['title'] = this.title;
    return data;
  }
}

class VideoItemsSnippetThumbnails {
  VideoItemsSnippetThumbnailsStandard standard;
  VideoItemsSnippetThumbnailsDefault xDefault;
  VideoItemsSnippetThumbnailsHigh high;
  VideoItemsSnippetThumbnailsMaxres maxres;
  VideoItemsSnippetThumbnailsMedium medium;

  VideoItemsSnippetThumbnails(
      {this.standard, this.xDefault, this.high, this.maxres, this.medium});

  VideoItemsSnippetThumbnails.fromJson(Map<String, dynamic> json) {
    standard = json['standard'] != null
        ? new VideoItemsSnippetThumbnailsStandard.fromJson(json['standard'])
        : null;
    xDefault = json['default'] != null
        ? new VideoItemsSnippetThumbnailsDefault.fromJson(json['default'])
        : null;
    high = json['high'] != null
        ? new VideoItemsSnippetThumbnailsHigh.fromJson(json['high'])
        : null;
    maxres = json['maxres'] != null
        ? new VideoItemsSnippetThumbnailsMaxres.fromJson(json['maxres'])
        : null;
    medium = json['medium'] != null
        ? new VideoItemsSnippetThumbnailsMedium.fromJson(json['medium'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.standard != null) {
      data['standard'] = this.standard.toJson();
    }
    if (this.xDefault != null) {
      data['default'] = this.xDefault.toJson();
    }
    if (this.high != null) {
      data['high'] = this.high.toJson();
    }
    if (this.maxres != null) {
      data['maxres'] = this.maxres.toJson();
    }
    if (this.medium != null) {
      data['medium'] = this.medium.toJson();
    }
    return data;
  }
}

class VideoItemsSnippetThumbnailsStandard {
  int width;
  String url;
  int height;

  VideoItemsSnippetThumbnailsStandard({this.width, this.url, this.height});

  VideoItemsSnippetThumbnailsStandard.fromJson(Map<String, dynamic> json) {
    width = json['width'];
    url = json['url'];
    height = json['height'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['width'] = this.width;
    data['url'] = this.url;
    data['height'] = this.height;
    return data;
  }
}

class VideoItemsSnippetThumbnailsDefault {
  int width;
  String url;
  int height;

  VideoItemsSnippetThumbnailsDefault({this.width, this.url, this.height});

  VideoItemsSnippetThumbnailsDefault.fromJson(Map<String, dynamic> json) {
    width = json['width'];
    url = json['url'];
    height = json['height'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['width'] = this.width;
    data['url'] = this.url;
    data['height'] = this.height;
    return data;
  }
}

class VideoItemsSnippetThumbnailsHigh {
  int width;
  String url;
  int height;

  VideoItemsSnippetThumbnailsHigh({this.width, this.url, this.height});

  VideoItemsSnippetThumbnailsHigh.fromJson(Map<String, dynamic> json) {
    width = json['width'];
    url = json['url'];
    height = json['height'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['width'] = this.width;
    data['url'] = this.url;
    data['height'] = this.height;
    return data;
  }
}

class VideoItemsSnippetThumbnailsMaxres {
  int width;
  String url;
  int height;

  VideoItemsSnippetThumbnailsMaxres({this.width, this.url, this.height});

  VideoItemsSnippetThumbnailsMaxres.fromJson(Map<String, dynamic> json) {
    width = json['width'];
    url = json['url'];
    height = json['height'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['width'] = this.width;
    data['url'] = this.url;
    data['height'] = this.height;
    return data;
  }
}

class VideoItemsSnippetThumbnailsMedium {
  int width;
  String url;
  int height;

  VideoItemsSnippetThumbnailsMedium({this.width, this.url, this.height});

  VideoItemsSnippetThumbnailsMedium.fromJson(Map<String, dynamic> json) {
    width = json['width'];
    url = json['url'];
    height = json['height'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['width'] = this.width;
    data['url'] = this.url;
    data['height'] = this.height;
    return data;
  }
}

class VideoItemsStatistics {
  String dislikeCount;
  String likeCount;
  String viewCount;
  String favoriteCount;
  String commentCount;

  VideoItemsStatistics(
      {this.dislikeCount,
      this.likeCount,
      this.viewCount,
      this.favoriteCount,
      this.commentCount});

  VideoItemsStatistics.fromJson(Map<String, dynamic> json) {
    dislikeCount = json['dislikeCount'];
    likeCount = json['likeCount'];
    viewCount = json['viewCount'];
    favoriteCount = json['favoriteCount'];
    commentCount = json['commentCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dislikeCount'] = this.dislikeCount;
    data['likeCount'] = this.likeCount;
    data['viewCount'] = this.viewCount;
    data['favoriteCount'] = this.favoriteCount;
    data['commentCount'] = this.commentCount;
    return data;
  }
}
