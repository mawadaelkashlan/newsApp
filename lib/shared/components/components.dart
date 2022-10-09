import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:news_app/modules/web_view/web_view_screen.dart';
class DefaultFormField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType type;
  late  String? validate;
  ValueChanged<String>? onSubmit;
  ValueChanged<String>? onChange;
  GestureTapCallback? onTap;
  final String label;
  final IconData prefix;
  bool? isPassword = false;
  IconData? suffix;
  VoidCallback? suffixPressed;
  bool? isClickable = true;

  DefaultFormField({
    required this.controller,
    required this.type,
    this.validate,
    this.onSubmit,
    this.onChange,
    required this.label,
    required this.prefix,
    this.isPassword,
    this.suffix,
    this.suffixPressed,
    this.onTap,
    this.isClickable,
  });
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: type,
      validator: (value){
        if (value == null || value.isEmpty) {
          return '${validate}';
        }
        return null;
      },
      onTap: onTap,
      obscureText: isPassword??false,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      controller: controller,
      cursorColor: Colors.pinkAccent,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: Colors.pinkAccent
            )
        ),
        border: OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide( color: Colors.white,)
        ),
        labelText: label,
        prefixIcon: Icon(prefix),
        suffixIcon: suffix!=null ? IconButton(icon: Icon(suffix), onPressed: suffixPressed,) : null ,
      ),
    );

  }
}

void navigateTo (context , widget) => Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => widget
    )
);

Widget buildArticleItem (article , context) => InkWell(
  onTap: (){
    navigateTo(context, WebViewScreen(article['url']));
  },
  child:   Padding(

    padding: const EdgeInsets.all(20.0),

    child: Row(

      children: [

        Container(

          width: 120.0,

          height: 120.0,

          decoration: BoxDecoration(

              borderRadius: BorderRadius.circular(10.0),

              image: DecorationImage(

                image: NetworkImage(

                    "${article['urlToImage']}"),

                fit: BoxFit.cover,

              )),

        ),

        SizedBox(

          width: 15.0,

        ),

        Expanded(

          child: Container(

            height: 120.0,

            child: Column(

              mainAxisAlignment: MainAxisAlignment.start,

              crossAxisAlignment: CrossAxisAlignment.start,

              children: [

                Text(

                  '${article['title']}',

                  style: Theme.of(context).textTheme.bodyText1,

                  maxLines: 3,

                  overflow: TextOverflow.ellipsis,

                ),

                SizedBox(height: 15.0),

                Text(

                  '${article['publishedAt']}',

                  style: TextStyle(

                    fontSize: 15.0,

                    color: Colors.grey,

                  ),



                ),

              ],

            ),

          ),

        ),

      ],

    ),

  ),
);

Widget myDivider () => Padding(
  padding: const EdgeInsets.symmetric(
      horizontal: 10.0),
  child: Container(
    height: 1,
    color: Colors.redAccent[100],
  ),
);

Widget articalBuilder(list , context,{isSearch= false}) => ConditionalBuilder(
    condition: list.length > 0,
    builder: (context) => ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) => buildArticleItem(list[index], context),
        separatorBuilder: (context, index) => myDivider(),
        itemCount: 10),
    fallback: (context) => isSearch? Container() : Center(
      child: CircularProgressIndicator(),
    ));

