import 'package:isar/isar.dart';

part 'cart_list.g.dart';

@collection
class CartList{
  Id? id = Isar.autoIncrement;
  String? userId;
  String? documentId;
  String? image;
  String? imageAssetId;
  String? imagePublicId;
  String? productName;
  String? price;
  String? category;
  String? currency;
  String? offerValue;
  List<String>? sizes;
  List<String>? colors;
  String? description;
  String? productId;
  bool? isFeatured;
  String? sellerId;
  bool? isStock;
  int? count;
}