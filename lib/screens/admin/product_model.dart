class ProductModel {
  final String? documentId;
  final String? image;
  int? count;
  int? isarId;
  final String? imageAssetId;
  final String? imagePublicId;
  final String? productName;
  final String? price;
  final String? category;
  final String? currency;
  final String? offerValue;
  final List<String>? sizes;
  final List<String>? colors;
  final String? description;
  final String? productId;
  final bool? isFeatured;
  final String? sellerId;
  final bool? isStock;

  ProductModel({
    this.count,
    this.isarId,
    this.documentId,
    this.image,
    this.imageAssetId,
    this.productName,
    this.price,
    this.category,
    this.currency,
    this.offerValue,
    this.sizes,
    this.colors,
    this.description,
    this.productId,
    this.sellerId,
    this.isFeatured,
    this.isStock,
    this.imagePublicId
  });

  factory ProductModel.fromMap(Map<String, dynamic> data, String id) {
    return ProductModel(
      sellerId: data['seller_id'],
      image: data['image'],
      productName: data['product_name'],
      price: data['price'],
      category: data['category'],
      currency: data['currency'],
      offerValue: data['offer_value'],
      sizes: (data['sizes'] as List<dynamic>).cast<String>(),
      colors: (data['colors'] as List<dynamic>).cast<String>(),
      description: data['description'],
      productId: data['product_id'], // Assigning the `id` parameter
      documentId: id,
      isFeatured: data['is_featured'],
        isStock: data['is_stock'],
      imagePublicId: data['image_public_id'],
      imageAssetId: data['assetId']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "seller_id": sellerId,
      "product_id": productId,
      "image": image,
      "product_name": productName,
      "price": price,
      "currency": currency,
      "category": category,
      "offer_value": offerValue,
      "sizes": sizes,
      "colors": colors,
      "is_featured": isFeatured,
      "description": description,
      "is_stock" : isStock,
      'image_public_id':imagePublicId,
      'assetId':imageAssetId
    };
  }
}
