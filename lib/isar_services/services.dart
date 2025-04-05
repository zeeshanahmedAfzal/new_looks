import 'package:isar/isar.dart';
import 'package:new_looks/constants/utiles.dart';
import 'package:new_looks/model/UserModel.dart';
import 'package:new_looks/screens/admin/product_model.dart';
import 'package:path_provider/path_provider.dart';
import '../collection/cart_list.dart';

class IsarService {
  late Future<Isar> db;

  IsarService(){
    db = openDB();
  }

  Future<Isar> openDB() async {
    if (Isar.instanceNames.isEmpty) {
      final directory = await getApplicationDocumentsDirectory();
      return await Isar.open(
        [CartListSchema],
        directory: directory.path,
        inspector: true
      );
    }
    return await Future.value(Isar.getInstance());
  }

  storeCartData(ProductModel? product,int count) async {
    final isar = await db;
    UserModel userModel = await showUserDetails();
    final cart = CartList()
      ..productName = product?.productName
    ..userId = userModel.id
    ..documentId = product?.documentId
    ..image = product?.image
    ..imageAssetId = product?.imageAssetId
    ..imagePublicId = product?.imagePublicId
    ..price = product?.price
    ..category = product?.category
    ..currency = product?.currency
    ..offerValue = product?.offerValue
    .. sizes = product?.sizes
    .. colors = product?.colors
    ..description = product?.description
    ..productId = product?.productId
    ..isFeatured = product?.isFeatured
    ..sellerId = product?.sellerId
      ..count = count
    ..isStock = product?.isStock;

    await isar.writeTxn(() async {
      await isar.cartLists.put(cart); // insert & update
    });
  }


  Future<List<ProductModel>> getCartData() async {
    var isar = await db;
    var datas = await isar.cartLists.where().findAll();
    List<ProductModel> products = [];
    for(var data in datas){
     var model = ProductModel(
       isarId: data.id,
        image: data.image,
        currency: data.currency,
        productId: data.productId,
        productName: data.productName,
        price: data.price,
        offerValue: data.offerValue,
        isStock: data.isStock,
        imageAssetId: data.imageAssetId,
       count: data.count
      );
     print("isar count data : ${data.count}");
     products.add(model);
    }
    return products;
  }



  closeIsar()async{
    var isar = await db;
    // await isar.close();
    await isar.clear();
  }

  decreaseCount(String productId) async {
    var isar = await db;

    await isar.writeTxn(() async {
      // Find the product by productId
      final cartItem = await isar.cartLists.filter().productIdEqualTo(productId).findFirst();

      if (cartItem != null && (cartItem.count ?? 0) > 0) {
        cartItem.count = (cartItem.count ?? 0) - 1; // Decrease count

        await isar.cartLists.put(cartItem); // Save updated data
      }
    });
  }

  increaseCount(String productId) async {
    var isar = await db;

    await isar.writeTxn(() async {
      // Find the product by productId
      final cartItem = await isar.cartLists.filter().productIdEqualTo(productId).findFirst();

      if (cartItem != null) {
        cartItem.count = (cartItem.count ?? 0) + 1; // Increase count

        await isar.cartLists.put(cartItem); // Save updated data
      }
    });
  }


  deleteProduct(String productId) async {
    var isar = await db;

    await isar.writeTxn(() async {
      // Find the product by productId
      final cartItem = await isar.cartLists.filter().productIdEqualTo(productId).findFirst();

      if (cartItem != null) {
        await isar.cartLists.delete(cartItem.id??0); // Delete the item from Isar
      }
    });
  }


}
