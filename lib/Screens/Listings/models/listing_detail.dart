class ListingDetailModel {
  String? response;
  Data? data;

  ListingDetailModel({this.response, this.data});

  ListingDetailModel.fromJson(Map<String, dynamic> json) {
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
  ListingDetail? listingDetail;

  Data({this.listingDetail});

  Data.fromJson(Map<String, dynamic> json) {
    listingDetail = json['listing_detail'] != null
        ? new ListingDetail.fromJson(json['listing_detail'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.listingDetail != null) {
      data['listing_detail'] = this.listingDetail!.toJson();
    }
    return data;
  }
}

class ListingDetail {
  String? itemId;
  int? garage;
  String? itemName;
  String? description;
  String? reason;
  String? quality;
  List<ItemCategory>? itemCategory;
  bool? isPremium;
  bool? isListed;
  bool? hidden;
  bool? isItem;
  String? bidStarts;
  int? duration;
  bool? autoRelist;
  List<Reactions>? reactions;
  bool? withAnything;
  List<CanCounterItem>? canCounterItem;
  String? distance;
  Null? meetUpLoc;
  String? meetUpLat;
  String? meetUpLng;
  bool? addGenericLoc;
  String? status;
  List<GarageItemImages>? garageItemImages;
  List<GarageItemVideos>? garageItemVideos;
  List<GarageItemComments>? garageItemComments;

  ListingDetail(
      {this.itemId,
        this.garage,
        this.itemName,
        this.description,
        this.reason,
        this.quality,
        this.itemCategory,
        this.isPremium,
        this.isListed,
        this.hidden,
        this.isItem,
        this.bidStarts,
        this.duration,
        this.autoRelist,
        this.reactions,
        this.withAnything,
        this.canCounterItem,
        this.distance,
        this.meetUpLoc,
        this.meetUpLat,
        this.meetUpLng,
        this.addGenericLoc,
        this.status,
        this.garageItemImages,
        this.garageItemVideos,
        this.garageItemComments});

  ListingDetail.fromJson(Map<String, dynamic> json) {
    itemId = json['item_id'];
    garage = json['garage'];
    itemName = json['item_name'];
    description = json['description'];
    reason = json['reason'];
    quality = json['quality'];
    if (json['item_category'] != null) {
      itemCategory = <ItemCategory>[];
      json['item_category'].forEach((v) {
        itemCategory!.add(new ItemCategory.fromJson(v));
      });
    }
    isPremium = json['is_premium'];
    isListed = json['is_listed'];
    hidden = json['hidden'];
    isItem = json['is_item'];
    bidStarts = json['bid_starts'];
    duration = json['duration'];
    autoRelist = json['auto_relist'];
    if (json['reactions'] != null) {
      reactions = <Reactions>[];
      json['reactions'].forEach((v) {
        reactions!.add(new Reactions.fromJson(v));
      });
    }
    withAnything = json['with_anything'];
    if (json['can_counter_item'] != null) {
      canCounterItem = <CanCounterItem>[];
      json['can_counter_item'].forEach((v) {
        canCounterItem!.add(new CanCounterItem.fromJson(v));
      });
    }
    distance = json['distance'];
    meetUpLoc = json['meet_up_loc'];
    meetUpLat = json['meet_up_lat'];
    meetUpLng = json['meet_up_lng'];
    addGenericLoc = json['add_generic_loc'];
    status = json['status'];
    if (json['garage_item_images'] != null) {
      garageItemImages = <GarageItemImages>[];
      json['garage_item_images'].forEach((v) {
        garageItemImages!.add(new GarageItemImages.fromJson(v));
      });
    }
    if (json['garage_item_videos'] != null) {
      garageItemVideos = <GarageItemVideos>[];
      json['garage_item_videos'].forEach((v) {
        garageItemVideos!.add(new GarageItemVideos.fromJson(v));
      });
    }
    if (json['garage_item_comments'] != null) {
      garageItemComments = <GarageItemComments>[];
      json['garage_item_comments'].forEach((v) {
        garageItemComments!.add(new GarageItemComments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['item_id'] = this.itemId;
    data['garage'] = this.garage;
    data['item_name'] = this.itemName;
    data['description'] = this.description;
    data['reason'] = this.reason;
    data['quality'] = this.quality;
    if (this.itemCategory != null) {
      data['item_category'] =
          this.itemCategory!.map((v) => v.toJson()).toList();
    }
    data['is_premium'] = this.isPremium;
    data['is_listed'] = this.isListed;
    data['hidden'] = this.hidden;
    data['is_item'] = this.isItem;
    data['bid_starts'] = this.bidStarts;
    data['duration'] = this.duration;
    data['auto_relist'] = this.autoRelist;
    if (this.reactions != null) {
      data['reactions'] = this.reactions!.map((v) => v.toJson()).toList();
    }
    data['with_anything'] = this.withAnything;
    if (this.canCounterItem != null) {
      data['can_counter_item'] =
          this.canCounterItem!.map((v) => v.toJson()).toList();
    }
    data['distance'] = this.distance;
    data['meet_up_loc'] = this.meetUpLoc;
    data['meet_up_lat'] = this.meetUpLat;
    data['meet_up_lng'] = this.meetUpLng;
    data['add_generic_loc'] = this.addGenericLoc;
    data['status'] = this.status;
    if (this.garageItemImages != null) {
      data['garage_item_images'] =
          this.garageItemImages!.map((v) => v.toJson()).toList();
    }
    if (this.garageItemVideos != null) {
      data['garage_item_videos'] =
          this.garageItemVideos!.map((v) => v.toJson()).toList();
    }
    if (this.garageItemComments != null) {
      data['garage_item_comments'] =
          this.garageItemComments!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ItemCategory {
  int? id;
  String? categoryName;

  ItemCategory({this.id, this.categoryName});

  ItemCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryName = json['category_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_name'] = this.categoryName;
    return data;
  }
}

class Reactions {
  String? userId;
  String? email;
  String? lastName;
  String? username;
  String? firstName;
  UserPersonalInfo? userPersonalInfo;

  Reactions(
      {this.userId,
        this.email,
        this.lastName,
        this.username,
        this.firstName,
        this.userPersonalInfo});

  Reactions.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    email = json['email'];
    lastName = json['last_name'];
    username = json['username'];
    firstName = json['first_name'];
    userPersonalInfo = json['user_personal_info'] != null
        ? new UserPersonalInfo.fromJson(json['user_personal_info'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['email'] = this.email;
    data['last_name'] = this.lastName;
    data['username'] = this.username;
    data['first_name'] = this.firstName;
    if (this.userPersonalInfo != null) {
      data['user_personal_info'] = this.userPersonalInfo!.toJson();
    }
    return data;
  }
}

class UserPersonalInfo {
  int? id;
  String? photo;

  UserPersonalInfo({this.id, this.photo});

  UserPersonalInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    photo = json['photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['photo'] = this.photo;
    return data;
  }
}

class CanCounterItem {
  int? id;
  String? itemName;

  CanCounterItem({this.id, this.itemName});

  CanCounterItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    itemName = json['item_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['item_name'] = this.itemName;
    return data;
  }
}

class GarageItemImages {
  int? id;
  int? garageItem;
  String? image;

  GarageItemImages({this.id, this.garageItem, this.image});

  GarageItemImages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    garageItem = json['garage_item'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['garage_item'] = this.garageItem;
    data['image'] = this.image;
    return data;
  }
}

class GarageItemVideos {
  int? id;
  int? garageItem;
  String? video;

  GarageItemVideos({this.id, this.garageItem, this.video});

  GarageItemVideos.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    garageItem = json['garage_item'];
    video = json['video'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['garage_item'] = this.garageItem;
    data['video'] = this.video;
    return data;
  }
}

class GarageItemComments {
  int? id;
  String? comment;
  Reactions? user;
  String? createdAt;

  GarageItemComments({this.id, this.comment, this.user, this.createdAt});

  GarageItemComments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    comment = json['comment'];
    user = json['user'] != null ? new Reactions.fromJson(json['user']) : null;
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['comment'] = this.comment;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['created_at'] = this.createdAt;
    return data;
  }
}
