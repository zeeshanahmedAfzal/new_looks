import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_looks/screens/admin/product_model.dart';
import 'package:new_looks/screens/product_details/porduct_detail_screen.dart';

import '../../../constants/colors.dart';
import '../../../widgets/AssetImages.dart';

class Recommended extends StatelessWidget {
  const Recommended({super.key, required this.recommendedProducts});
  final List<ProductModel> recommendedProducts;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: ListView.builder(
        itemCount: recommendedProducts.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          var obj = recommendedProducts[index];
          return GestureDetector(
            onTap: (){
              Get.to(() => ProductDetailScreen(productId: obj.productId));
            },
            child: Container(
              margin: EdgeInsets.only(right:10,left:index == 0 ? 16 : 0),
              height: 70,
              width: 210,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Color(0xff000000))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      bottomLeft: Radius.circular(8),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          bottomLeft: Radius.circular(8),
                        ),
                      ),
                      child: Image(
                        image: NetworkImage(obj.image ?? ''),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Container(
                      padding: EdgeInsets.all(2),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            obj.productName??'',
                            style: TextStyle(
                              color: Color(0xff1D1F22),
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text("${obj.currency} ${obj.price}",
                              style: TextStyle(
                                color: CustomColor.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                              )),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
