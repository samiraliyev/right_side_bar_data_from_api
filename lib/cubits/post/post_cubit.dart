import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/data/services/post_service.dart';
part 'post_state.dart';

class PostCubit extends Cubit<PostState> {
  PostCubit() : super(PostInitial());
  void getPost() async {
    try {
      emit(PostLoading());
      final result = await PostService.getPost();
      emit(PostLoaded());
    } on SocketException {
      emit(PostError());
    } catch (e) {
      emit(PostFailure());
    }
  }
}
