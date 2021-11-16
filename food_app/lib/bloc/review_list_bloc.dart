import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/models/customer_model.dart';
import 'package:food_app/models/store_model.dart';
import 'package:food_app/repositories/customer_repository.dart';
import 'package:food_app/services/api_services.dart';

class ReviewEvent {}
class EventGetReviewUserById extends ReviewEvent {
  String? customerId;
  EventGetReviewUserById({this.customerId});
}
class ReviewState {}
class ReviewFailedState extends ReviewState  {
  String? error;
  ReviewFailedState({this.error});
}
class ReviewLoadingState extends ReviewState  {}
class ReviewUsersState extends ReviewState {
  List<CustomerModel>? users=[];
  ReviewUsersState({this.users});
}
class ReviewBloc extends Bloc<ReviewEvent,ReviewState> {
  List<CustomerModel>? users=[];
  ReviewBloc() : super(ReviewState()) {
    on<EventGetReviewUserById> ((event,emit) async {
      try {
        emit(ReviewLoadingState());
        await Future.delayed(const Duration(seconds: 2));
          CustomerModel? data=await APIWeb().get(CustomerRepository.getCustomerById(event.customerId ??""));
          if (data != null) {
            users!.add(data);
          }else {
            CustomerModel user =new CustomerModel(id:event.customerId,name: "anonymous");
            users!.add(user);
          }
        emit(ReviewUsersState(users:users));
      }catch (e) {
        emit(ReviewFailedState(error: e.toString()));
      }
    }
    );
  }

}