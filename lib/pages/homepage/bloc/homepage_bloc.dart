import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:instagram_clone/pages/homepage/homepage_pages/profile/bloc/profile_bloc.dart';
import 'package:meta/meta.dart';

part 'homepage_event.dart';
part 'homepage_state.dart';

class HomepageBloc extends Bloc<HomepageEvent, HomepageState> {
  HomepageBloc() : super(const HomepageInitial(0)) {
    on<TabChange>((event, emit) => emit(TabChanged(event.index)));
  }

  // final ProfileBloc profileBloc;
  late final StreamSubscription profileBlocSubscription;
}
