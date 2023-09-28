class HomeModel {
  String? response;
  Data? data;

  HomeModel({this.response, this.data});

  HomeModel.fromJson(Map<String, dynamic> json) {
    response = json['response'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['response'] = this.response;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  UserData? userData;
  bool? hasNotification;
  List<AllEpisodes>? allEpisodes;

  Data({this.userData, this.hasNotification, this.allEpisodes});

  Data.fromJson(Map<String, dynamic> json) {
    userData = json['user_data'] != null
        ? new UserData.fromJson(json['user_data'])
        : null;
    hasNotification = json['has_notification'];
    if (json['all_episodes'] != null) {
      allEpisodes = <AllEpisodes>[];
      json['all_episodes'].forEach((v) {
        allEpisodes!.add(new AllEpisodes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userData != null) {
      data['user_data'] = this.userData!.toJson();
    }
    data['has_notification'] = this.hasNotification;
    if (this.allEpisodes != null) {
      data['all_episodes'] = this.allEpisodes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserData {
  String? firstName;
  String? lastName;
  String? profilePhoto;

  UserData({this.firstName, this.lastName, this.profilePhoto});

  UserData.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    profilePhoto = json['profile_photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['profile_photo'] = this.profilePhoto;
    return data;
  }
}

class AllEpisodes {
  int? id;
  String? title;
  String? caption;
  String? video;
  String? datePublished;
  List<int>? tags;
  List<int>? sharedEpisodes;
  int? user;
  List<int>? likes;
  int? views;
  int? trendingNo;
  bool? active;

  AllEpisodes(
      {this.id,
        this.title,
        this.caption,
        this.video,
        this.datePublished,
        this.tags,
        this.sharedEpisodes,
        this.user,
        this.likes,
        this.views,
        this.trendingNo,
        this.active});

  AllEpisodes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    caption = json['caption'];
    video = json['video'];
    datePublished = json['date_published'];
    tags = json['tags'].cast<int>();
    sharedEpisodes = json['shared_episodes'].cast<int>();
    user = json['user'];
    likes = json['likes'].cast<int>();
    views = json['views'];
    trendingNo = json['trending_no'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['caption'] = this.caption;
    data['video'] = this.video;
    data['date_published'] = this.datePublished;
    data['tags'] = this.tags;
    data['shared_episodes'] = this.sharedEpisodes;
    data['user'] = this.user;
    data['likes'] = this.likes;
    data['views'] = this.views;
    data['trending_no'] = this.trendingNo;
    data['active'] = this.active;
    return data;
  }
}
