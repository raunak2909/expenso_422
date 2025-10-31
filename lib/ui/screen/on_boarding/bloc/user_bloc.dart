import 'package:expenso_422/data/local/helper/db_helper.dart';
import 'package:expenso_422/ui/screen/on_boarding/bloc/user_event.dart';
import 'package:expenso_422/ui/screen/on_boarding/bloc/user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class UserBloc extends Bloc<UserEvent, UserState>{
  DBHelper dbHelper;
  UserBloc({required this.dbHelper}) : super(UserInitialState()){

    on<RegisterUserEvent>((event, emit) async{

      emit(UserLoadingState());

      int check = await dbHelper.createUser(newUser: event.mUser);

      if(check==3){
        emit(UserSuccessState());
      } else if(check==2){
        emit(UserFailureState(errorMsg: "User already exists"));
      } else {
        emit(UserFailureState(errorMsg: "Something went wrong"));
      }

    });

    on<LoginUserEvent>((event, emit){

    });

  }

}