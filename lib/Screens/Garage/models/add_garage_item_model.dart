class AddItemModel {
  String? response;
  Data? data;

  AddItemModel({this.response, this.data});

  AddItemModel.fromJson(Map<String, dynamic> json) {
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
  String? itemId;

  Data({this.itemId});

  Data.fromJson(Map<String, dynamic> json) {
    itemId = json['item_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['item_id'] = this.itemId;
    return data;
  }
}
