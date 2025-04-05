import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_looks/screens/admin/product_model.dart';
import '../../../constants/colors.dart';
import '../../../widgets/AssetImages.dart';
import '../../product_details/porduct_detail_screen.dart';

class FeaturedProduct extends StatelessWidget {
  const FeaturedProduct({super.key, required this.featuredProducts});
  final List<ProductModel> featuredProducts;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 230, // Set a fixed height
      child: Obx(()=>
        ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: featuredProducts.length > 10 ? 10 : featuredProducts.length,
          itemBuilder: (context, index) {
            var obj = featuredProducts[index];
            return GestureDetector(
              onTap: (){
                Get.to(() => ProductDetailScreen(productId: obj.productId));
              },
              child: Container(
                margin: EdgeInsets.only(right:10,left:index == 0 ? 16 : 0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Color(0xff000000))
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.only(topRight: Radius.circular(10),topLeft: Radius.circular(10)),
                        child: Image.network(
                          obj.image??'',
                          height: 170,
                          width: 110,
                          fit: BoxFit.cover,
                        )),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            obj.productName??'',
                            style: TextStyle(
                              color: CustomColor.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            "${obj.currency} ${obj.price}",
                            style: TextStyle(
                              color: CustomColor.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 12,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
