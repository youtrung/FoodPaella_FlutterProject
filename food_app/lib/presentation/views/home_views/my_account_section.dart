
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/bloc/login_bloc.dart';
import 'package:food_app/bloc/user_bloc.dart';
import 'package:food_app/constant/list_title_widget.dart';
import 'package:food_app/constant/route_strings.dart';
import 'package:food_app/models/customer_model.dart';

class MyAccountSection extends StatefulWidget {
  MyAccountSection({Key? key}) : super(key: key);

  @override
  State<MyAccountSection> createState() => _MyAccountSectionState();
}

class _MyAccountSectionState extends State<MyAccountSection> {

  @override
  Widget build(BuildContext context) {
    CustomerModel? customer=BlocProvider.of<LoginBloc>(context).customerModel;
    return  ListView(
      children: ListTile.divideTiles(
          context: context,
          tiles:[
            SizedBox(height: 10,),
            ListTileWidget(title:customer == null ? "Ho va ten" :customer.name, routeStr: PROFILE_ROUTE,args: customer,),
            SizedBox(height: 10,),
            ListTileWidget(title:"Address", routeStr: ADDRESS_ROUTE,args: customer,urlStr: "https://images.unsplash.com/photo-1527377667-83c6c76f963f?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1935&q=80",),
            ListTile(
              trailing: Icon(Icons.arrow_forward_ios_outlined),
              leading: CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage("https://media.istockphoto.com/photos/disconnect-picture-id172207624"),
              ),
              title: Text("Logout",style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),),
              onTap: () {
                BlocProvider.of<UserBloc>(context).add(LogoutEvent());
                Navigator.of(context).pushReplacementNamed(LANDING_ROUTE);
              },
            )
          ]).toList(),
    );

  }
}
