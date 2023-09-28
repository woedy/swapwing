class UserGarageModel {
  String? response;
  Data? data;

  UserGarageModel({this.response, this.data});

  UserGarageModel.fromJson(Map<String, dynamic> json) {
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
  String? garageId;
  bool? open;
  String? locationName;
  String? distance;
  String? lat;
  String? lng;
  List<GarageItems>? garageItems;
  List<GarageServices>? garageServices;

  Data(
      {this.garageId,
        this.open,
        this.locationName,
        this.distance,
        this.lat,
        this.lng,
        this.garageItems,
        this.garageServices});

  Data.fromJson(Map<String, dynamic> json) {
    garageId = json['garage_id'];
    open = json['open'];
    locationName = json['location_name'];
    distance = json['distance'];
    lat = json['lat'];
    lng = json['lng'];
    if (json['garage_items'] != null) {
      garageItems = <GarageItems>[];
      json['garage_items'].forEach((v) {
        garageItems!.add(new GarageItems.fromJson(v));
      });
    }
    if (json['garage_services'] != null) {
      garageServices = <GarageServices>[];
      json['garage_services'].forEach((v) {
        garageServices!.add(new GarageServices.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['garage_id'] = this.garageId;
    data['open'] = this.open;
    data['location_name'] = this.locationName;
    data['distance'] = this.distance;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    if (this.garageItems != null) {
      data['garage_items'] = this.garageItems!.map((v) => v.toJson()).toList();
    }
    if (this.garageServices != null) {
      data['garage_services'] =
          this.garageServices!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GarageItems {
  int? id;
  String? itemId;
  int? garage;
  String? itemName;
  bool? isListed;
  bool? hidden;
  List<int>? reactions;
  GarageItemImages? garageItemImages;

  GarageItems(
      {this.id,
        this.itemId,
        this.garage,
        this.itemName,
        this.isListed,
        this.hidden,
        this.reactions,
        this.garageItemImages});

  GarageItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    itemId = json['item_id'];
    garage = json['garage'];
    itemName = json['item_name'];
    isListed = json['is_listed'];
    hidden = json['hidden'];
    reactions = json['reactions'].cast<int>();
    garageItemImages = json['garage_item_images'] != null
        ? new GarageItemImages.fromJson(json['garage_item_images'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['item_id'] = this.itemId;
    data['garage'] = this.garage;
    data['item_name'] = this.itemName;
    data['is_listed'] = this.isListed;
    data['hidden'] = this.hidden;
    data['reactions'] = this.reactions;
    if (this.garageItemImages != null) {
      data['garage_item_images'] = this.garageItemImages!.toJson();
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

class GarageServices {
  int? id;
  String? serviceId;
  int? garage;
  String? serviceName;
  bool? isListed;
  bool? hidden;
  List<int>? reactions;
  GarageServiceImages? garageServiceImages;

  GarageServices(
      {this.id,
        this.serviceId,
        this.garage,
        this.serviceName,
        this.isListed,
        this.hidden,
        this.reactions,
        this.garageServiceImages});

  GarageServices.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serviceId = json['service_id'];
    garage = json['garage'];
    serviceName = json['service_name'];
    isListed = json['is_listed'];
    hidden = json['hidden'];
    reactions = json['reactions'].cast<int>();
    garageServiceImages = json['garage_service_images'] != null
        ? new GarageServiceImages.fromJson(json['garage_service_images'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['service_id'] = this.serviceId;
    data['garage'] = this.garage;
    data['service_name'] = this.serviceName;
    data['is_listed'] = this.isListed;
    data['hidden'] = this.hidden;
    data['reactions'] = this.reactions;
    if (this.garageServiceImages != null) {
      data['garage_service_images'] = this.garageServiceImages!.toJson();
    }
    return data;
  }
}

class GarageServiceImages {
  int? id;
  int? garageService;
  String? image;

  GarageServiceImages({this.id, this.garageService, this.image});

  GarageServiceImages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    garageService = json['garage_service'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['garage_service'] = this.garageService;
    data['image'] = this.image;
    return data;
  }
}
