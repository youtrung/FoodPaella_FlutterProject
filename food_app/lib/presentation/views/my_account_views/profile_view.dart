import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/bloc/login_bloc.dart';
import 'package:food_app/bloc/user_bloc.dart';
import 'package:food_app/constant/circular_loading.dart';
import 'package:food_app/constant/colors.dart';
import 'package:food_app/models/customer_model.dart';

class ProfileView extends StatefulWidget {
  ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    CustomerModel? customer=BlocProvider.of<LoginBloc>(context).customerModel;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.yellow,
        title: Text("Profile"),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: Align(
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: () => context.read<UserBloc>().add(UserChangedEvent(customerModel:customer)),
                  child: Text("UPDATE",style: TextStyle(color: Colors.blue,fontSize: 16),)
              ),
            ),
          )
        ],
      ),
      body: BlocBuilder<UserBloc,UserState>(
        builder: (context,userState) => userState is UserLoadingState ? CircularLoading():
          Form(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20,),
                TextFormField(
                  initialValue: customer == null ? null:customer.phone,
                  onChanged: (value)  {
                    setState(() {
                      customer!.phone=value;
                    });
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: "Mobile phone",
                  ),
                ),
                Divider(height:20,color: Colors.grey.shade300,thickness: 5,),
                TextFormField(
                  initialValue: customer == null ? null:customer.name,
                  onChanged: (value)  {
                    setState(() {
                      customer!.name=value;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: "Name",
                  ),
                ),
                TextFormField(
                  initialValue: customer== null ? "":customer.email,
                  onChanged: (value)  {
                    setState(() {
                      customer!.email=value;
                    });
                  },
                  decoration: InputDecoration(
                      labelText: "Email",
                      border: InputBorder.none,
                  ),
                ),
              ],
            ),
          ),

        ),
      ),
    );
  }
}
