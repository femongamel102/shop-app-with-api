import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_with_api/layout/shop_app/cubit/cubit.dart';
import 'package:shop_app_with_api/layout/shop_app/cubit/states.dart';
import 'package:shop_app_with_api/models/categories_model.dart';
import 'package:shop_app_with_api/shared/components/components.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return ListView.separated(
            itemBuilder: (context, index) => buildCatItem(
                ShopCubit.get(context).categoriesModel!.data!.data![index]),
            separatorBuilder: (context, index) => myDivider(),
            itemCount:
                ShopCubit.get(context).categoriesModel!.data!.data!.length);
      },
    );
  }

  Widget buildCatItem(DataModel model) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Image(
              image: NetworkImage(
                model.image!,
              ),
              width: 120,
              height: 120,
              fit: BoxFit.fill,
            ),
            const SizedBox(
              width: 20,
            ),
            Text(
              model.name!,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios)
          ],
        ),
      );
}
