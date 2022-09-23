import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_with_api/layout/shop_app/cubit/cubit.dart';
import 'package:shop_app_with_api/layout/shop_app/cubit/states.dart';
import 'package:shop_app_with_api/shared/components/components.dart';
import 'package:shop_app_with_api/shared/components/constants.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({Key? key}) : super(key: key);

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        final model = ShopCubit.get(context).userModel;
        nameController.text = model!.data!.name!;
        emailController.text = model.data!.email!;
        phoneController.text = model.data!.phone!;

        return ConditionalBuilder(
          condition: ShopCubit.get(context).userModel != null,
          builder: (context) => Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                defaultTextFormField(
                  controller: nameController,
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'name must not be empty';
                    }
                    return null;
                  },
                  prefixIcon: Icons.person,
                  labelText: 'Name',
                ),
                const SizedBox(
                  height: 20,
                ),
                defaultTextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'email must not be empty';
                    }
                    return null;
                  },
                  prefixIcon: Icons.email,
                  labelText: 'Email Address',
                ),
                const SizedBox(
                  height: 20,
                ),
                defaultTextFormField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'phone must not be empty';
                    }
                    return null;
                  },
                  prefixIcon: Icons.phone,
                  labelText: 'Phone',
                ),
                const SizedBox(
                  height: 20,
                ),
                defaultButton(
                    onPressed: () {
                      signOut(context);
                    },
                    text: 'Logout'),
              ],
            ),
          ),
          fallback: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
