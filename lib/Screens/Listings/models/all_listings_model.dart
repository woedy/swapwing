class AllListingsModel {
  String? response;
  Data? data;

  AllListingsModel({this.response, this.data});

  AllListingsModel.fromJson(Map<String, dynamic> json) {
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
  List<AllItems>? allItems;
  List<AllItems>? allPremiumItems;

  Data({this.allItems, this.allPremiumItems});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['all_items'] != null) {
      allItems = <AllItems>[];
      json['all_items'].forEach((v) {
        allItems!.add(new AllItems.fromJson(v));
      });
    }
    if (json['all_premium_items'] != null) {
      allPremiumItems = <AllItems>[];
      json['all_premium_items'].forEach((v) {
        allPremiumItems!.add(new AllItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.allItems != null) {
      data['all_items'] = this.allItems!.map((v) => v.toJson()).toList();
    }
    if (this.allPremiumItems != null) {
      data['all_premium_items'] =
          this.allPremiumItems!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AllItems {
  int? id;
  String? itemId;
  String? itemName;
  String? bidStarts;
  int? endsIn;
  String? distance;
  bool? isPremium;
  GarageItemImages? garageItemImages;
  ItemOwner? itemOwner;

  AllItems(
      {this.id,
        this.itemId,
        this.itemName,
        this.bidStarts,
        this.endsIn,
        this.distance,
        this.isPremium,
        this.garageItemImages,
        this.itemOwner});

  AllItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    itemId = json['item_id'];
    itemName = json['item_name'];
    bidStarts = json['bid_starts'];
    endsIn = json['ends_in'];
    distance = json['distance'];
    isPremium = json['is_premium'];
    garageItemImages = json['garage_item_images'] != null
        ? new GarageItemImages.fromJson(json['garage_item_images'])
        : null;
    itemOwner = json['item_owner'] != null
        ? new ItemOwner.fromJson(json['item_owner'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['item_id'] = this.itemId;
    data['item_name'] = this.itemName;
    data['bid_starts'] = this.bidStarts;
    data['ends_in'] = this.endsIn;
    data['distance'] = this.distance;
    data['is_premium'] = this.isPremium;
    if (this.garageItemImages != null) {
      data['garage_item_images'] = this.garageItemImages!.toJson();
    }
    if (this.itemOwner != null) {
      data['item_owner'] = this.itemOwner!.toJson();
    }
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

class ItemOwner {
  String? userId;
  String? lastName;
  String? username;
  String? firstName;
  UserPersonalInfo? userPersonalInfo;

  ItemOwner(
      {this.userId,
        this.lastName,
        this.username,
        this.firstName,
        this.userPersonalInfo});

  ItemOwner.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
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
  bool? isOnline;

  UserPersonalInfo({this.id, this.photo, this.isOnline});

  UserPersonalInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    photo = json['photo'];
    isOnline = json['is_online'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['photo'] = this.photo;
    data['is_online'] = this.isOnline;
    return data;
  }
}
