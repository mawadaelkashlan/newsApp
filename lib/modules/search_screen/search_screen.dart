import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/cubit/cubit.dart';
import 'package:news_app/layout/cubit/states.dart';
import 'package:news_app/shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit , NewsStates>(
      listener: (context,state){},
      builder: (context, state) {
        var list = AppCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(),
          body: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: DefaultFormField(
                    controller: searchController,
                    onChange: (value) {
                      AppCubit.get(context).getSearchData(value);
                    },
                    type: TextInputType.text,
                    label: 'Search',
                    prefix: Icons.search,
                    validate: 'search is empty',
                    isPassword: false,
                  ),
                ),
                Expanded(child: articalBuilder(list, context , isSearch : true)),
              ],
            ),
          ),
        );
      },
    );
  }
}
