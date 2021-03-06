import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/bloc/login_bloc.dart';
import 'package:food_app/bloc/user_bloc.dart';
import 'package:food_app/constant/circular_loading.dart';
import 'package:food_app/constant/colors.dart';
import 'package:food_app/models/customer_model.dart';

class AddressView extends StatefulWidget {
  AddressView({Key? key}) : super(key: key);

  @override
  State<AddressView> createState() => _AddressViewState();
}

class _AddressViewState extends State<AddressView> {
  @override
  Widget build(BuildContext context) {
    CustomerModel? customer=BlocProvider.of<LoginBloc>(context).customerModel;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.yellow,
        title: Text("Address"),
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
      body:   BlocBuilder<UserBloc,UserState>(
        builder: (context,userState) => userState is UserLoadingState ? CircularLoading():
            Form(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20,),
                TextFormField(
                  onChanged: (value)  {
                    setState(() {
                      customer!.address!.district=value;
                    });
                  } ,
                  initialValue:customer == null ? null:customer.address!.district,
                  decoration: InputDecoration(
                    labelText: "District",
                  ),
                ),
                TextFormField(
                  onChanged: (value) {
                    setState(() {
                      customer!.address!.ward=value;
                    });
                  },
                  initialValue: customer == null ? null:customer.address!.ward,
                  decoration: InputDecoration(
                    labelText: "Ward",
                  ),
                ),
                TextFormField(
                  onChanged: (value)  {
                    setState(() {
                      customer!.address!.city=value;
                    });
                  },
                  initialValue: customer == null ? "":customer.address!.city,
                  decoration: InputDecoration(
                    labelText: "City",
                  ),
                ),
                TextFormField(
                  onChanged: (value) {
                    setState(() {
                      customer!.address!.street=value;
                    });
                  },
                  initialValue: customer == null ? "":customer.address!.street,
                  decoration: InputDecoration(
                    labelText: "Street",
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
