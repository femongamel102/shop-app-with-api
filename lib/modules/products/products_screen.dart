import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_with_api/layout/shop_app/cubit/cubit.dart';
import 'package:shop_app_with_api/layout/shop_app/cubit/states.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shop_app_with_api/models/home_model.dart';
import 'package:shop_app_with_api/shared/styles/colors.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: ShopCubit.get(context).homeModel != null,
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
          builder: (context) =>
              productsBuilder(ShopCubit.get(context).homeModel!),
        );
      },
    );
  }

  Widget productsBuilder(HomeModel model) => SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            CarouselSlider(
                items: model.data!.banners!
                    .map((e) => Image(
                          image: NetworkImage(e.image!),
                          width: double.infinity,
                          fit: BoxFit.fill,
                        ))
                    .toList(),
                options: CarouselOptions(
                  height: 250,
                  initialPage: 0,
                  viewportFraction: 1, // flex = 1
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 3), // time to jump
                  autoPlayAnimationDuration:
                      const Duration(seconds: 1), //time in jump
                  autoPlayCurve: Curves.fastOutSlowIn,
                  scrollDirection: Axis.horizontal,
                )),
            const SizedBox(
              height: 10,
            ),
            Container(
              color: Colors.grey[300],
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 1,
                crossAxisSpacing: 1,
                childAspectRatio: 1 / 1.58,
                children: List.generate(
                  model.data!.products!.length,
                  (index) => buildGridProduct(model.data!.products![index]),
                ),
              ),
            )
          ],
        ),
      );
  Widget buildGridProduct(ProductModel model) => Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(model.image!),
                  width: double.infinity,
                  height: 200,
                ),
                if (model.discount != 0)
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.red.withOpacity(.7),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                    child: const Text(
                      'DISCOUNT',
                      style: TextStyle(fontSize: 8, color: Colors.white),
                    ),
                  )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 14, height: 1.3),
                  ),
                  Row(
                    children: [
                      Text(
                        model.price!.toString(),
                        style:
                            const TextStyle(fontSize: 12, color: defaultColor),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      if (model.discount != 0)
                        Text(
                          model.oldPrice!.toString(),
                          style: const TextStyle(
                              fontSize: 10,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough),
                        ),
                      const Spacer(),
                      IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {},
                          icon: const Icon(Icons.favorite_border,size: 14,))
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      );
}
