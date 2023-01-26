import 'package:edeli/src/models/vendor.dart';

import 'product_details2.dart';
import '../helpers/custom_trace.dart';

class SearchISResult {
  List<ItemDetails> item;
  List<Vendor> vendor;

  SearchISResult();

  SearchISResult.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      item = jsonMap['item'] != null
          ? List.from(jsonMap['item'])
              .map((element) => ItemDetails.fromJSON(element))
              .toList()
          : [];
      vendor = jsonMap['vendor'] != null
          ? List.from(jsonMap['vendor'])
              .map((element) => Vendor.fromJSON(element))
              .toList()
          : [];
    } catch (e) {
      print(CustomTrace(StackTrace.current, message: e));
    }
  }
}

class ItemDetails {
  List<ProductDetails2> productList = [];
  String shopId;
  String shopName;
  String subtitle;
  String shopTypeID;
  String latitude;
  String longitude;
  String focusId;
  String logo;
  String distance;
  String timing;

  ItemDetails();

  ItemDetails.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      shopId = jsonMap['shopId'] != null ? jsonMap['shopId'] : '';
      shopName = jsonMap['shopName'] != null ? jsonMap['shopName'] : '';
      subtitle = jsonMap['subtitle'] != null ? jsonMap['subtitle'] : '';
      shopTypeID = jsonMap['shopTypeID'] != null ? jsonMap['shopTypeID'] : '';
      latitude = jsonMap['latitude'] != null ? jsonMap['latitude'] : '';
      longitude = jsonMap['longitude'] != null ? jsonMap['longitude'] : '';
      focusId = jsonMap['focusId'] != null ? jsonMap['focusId'] : '';
      distance = jsonMap['distance'] != null ? jsonMap['distance'] : '';
      timing = jsonMap['timing'] != null ? jsonMap['timing'] : '';
      productList = jsonMap['productList'] != null
          ? List.from(jsonMap['productList'])
              .map((element) => ProductDetails2.fromJSON(element))
              .toList()
          : [];
      logo = jsonMap['logo'] != null ? jsonMap['logo'] : '';
    } catch (e) {
      print(e);
      print(CustomTrace(StackTrace.current, message: e));
    }
  }
}
