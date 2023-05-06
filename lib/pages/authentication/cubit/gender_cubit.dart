import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:instagram_clone/pages/authentication/auth_pages/signup_page.dart';

part 'gender_state.dart';

class GenderCubit extends Cubit<GenderState> {
  GenderCubit() : super(const GenderInitial(Gender.other));

  void changeGender(Gender gender) {
    emit(GenderChanged(gender));
  }
}
