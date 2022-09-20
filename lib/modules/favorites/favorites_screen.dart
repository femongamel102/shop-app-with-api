import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_with_api/layout/shop_app/cubit/cubit.dart';
import 'package:shop_app_with_api/layout/shop_app/cubit/states.dart';
import 'package:shop_app_with_api/models/favorites_model.dart';
import 'package:shop_app_with_api/shared/components/components.dart';
import 'package:shop_app_with_api/shared/styles/colors.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return ConditionalBuilder(
          condition: state is! ShopLoadingGetFavoritesState,
          builder: (context) => ListView.separated(
              itemBuilder: (context, index) => buildFavItem(
                  ShopCubit.get(context).favoritesModel!.data!.data![index],
                  context),
              separatorBuilder: (context, index) => myDivider(),
              itemCount:
              ShopCubit.get(context).favoritesModel!.data!.data!.length),
          fallback: (context) =>const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildFavItem(FavoritesData model, context) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          height: 120,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Image(
                    image: NetworkImage(model.product!.image!),
                    width: 120,
                    height: 120,
                  ),
                  if (model.product!.discount != 0)
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.red.withOpacity(.7),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 3),
                      child: const Text(
                        'DISCOUNT',
                        style: TextStyle(fontSize: 8, color: Colors.white),
                      ),
                    )
                ],
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.product!.name!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 14, height: 1.3),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Text(
                          model.product!.price!.toString(),
                          style: const TextStyle(
                              fontSize: 12, color: defaultColor),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        if (model.product!.discount != 0)
                          Text(
                            model.product!.oldPrice!.toString(),
                            style: const TextStyle(
                                fontSize: 10,
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough),
                          ),
                        const Spacer(),
                        IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              ShopCubit.get(context)
                                  .changeFavorites(model.product!.id!);
                            },
                            icon: CircleAvatar(
                              radius: 15,
                              backgroundColor: ShopCubit.get(context)
                                      .favorites[model.product!.id]!
                                  ? defaultColor
                                  : Colors.grey,
                              child: const Icon(
                                Icons.favorite_border,
                                size: 14,
                                color: Colors.white,
                              ),
                            ))
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
}
