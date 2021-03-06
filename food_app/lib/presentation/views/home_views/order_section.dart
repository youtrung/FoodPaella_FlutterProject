import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/bloc/login_bloc.dart';
import 'package:food_app/bloc/payment_bloc.dart';
import 'package:food_app/bloc/shop_cart_bloc.dart';
import 'package:food_app/constant/colors.dart';
import 'package:food_app/models/customer_model.dart';
import 'package:food_app/presentation/views/shopping_cart_views/card_item_widget.dart';
import 'package:food_app/presentation/views/shopping_cart_views/history_order_view.dart';
import 'package:food_app/presentation/views/shopping_cart_views/ongoing_order_view.dart';

class OrderSection extends StatefulWidget {
   OrderSection({Key? key}) : super(key: key);

  @override
  _OrderSectionState createState() => _OrderSectionState();
}

class _OrderSectionState extends State<OrderSection> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    _tabController=TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CustomerModel? customer=BlocProvider.of<LoginBloc>(context).customerModel;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title:   TabBar(

            labelPadding: EdgeInsets.only(bottom:5),
            labelColor: Colors.white,
            indicatorWeight: 1.0,
            unselectedLabelColor: Colors.black,
            labelStyle: TextStyle(
              color: Colors.black,
              fontSize: 20,
            ),
            indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(50), // Creates border
                color: AppColor.yellow
            )
            ,
            controller: _tabController,
            tabs: [
              Text("Ongoing",),
              Text("History",),
              Text("Cart")
            ]
        ),
      ),
        body: TabBarView(
          controller: _tabController,
          children: [
            BlocProvider<PaymentBloc>(
              create: (_)=>PaymentBloc()..add(GetPaymentEvent(userId: customer!.id ?? "")),
                child: OngoingOrderView()
            ),
                BlocProvider<PaymentBloc>(
            create: (_)=>PaymentBloc(),
            child: HistoryView()
            ),
            BlocBuilder<CartBloc, CartState>(
              builder: (context,state)
                => CardItemWidgets()
            ),
          ],

        ),
    );
  }
}
