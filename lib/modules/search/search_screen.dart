import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_with_api/modules/search/cubit/cubit.dart';
import 'package:shop_app_with_api/modules/search/cubit/states.dart';
import 'package:shop_app_with_api/shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var formKey = GlobalKey<FormState>();
    var searchController = TextEditingController();
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    defaultTextFormField(
                        controller: searchController,
                        keyboardType: TextInputType.text,
                        validator: (value){
                          if(value!.isEmpty){
                            return 'enter text to search';
                          }
                          return null;
                        },
                        labelText: 'Search',
                      onSubmit: (text){
                          SearchCubit.get(context).search(text);
                      },
                        prefixIcon: Icons.search,

                    ),
                    SizedBox(height: 10,),
                    if(state is SearchLoadingState)
                    LinearProgressIndicator(),
                    SizedBox(height: 10,),
                    if(state is SearchSuccessState)
                    Expanded(
                      child: ListView.separated(
                          itemBuilder: (context, index) => buildListProducts(
                              SearchCubit.get(context).model.data!.data![index],context,isOldPrice: false
                          ),
                          separatorBuilder: (context, index) => myDivider(),
                          itemCount:
                          SearchCubit.get(context).model.data!.data!.length),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
