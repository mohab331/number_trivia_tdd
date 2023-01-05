import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:test_driven/core/index.dart';
import 'package:test_driven/domain/index.dart';
import 'package:test_driven/presentation/pages/home/cubit/index.dart';

class MessageDisplayWidget extends StatelessWidget {
  const MessageDisplayWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        if (state is HomeErrorState) {
          Fluttertoast.showToast(
            msg: state.errorMessage,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red,
            textColor: Colors.black,
          );
        }
      },
      builder: (context, state) {
        TriviaResponseEntity? numberTrivia =
            HomeCubit.get(context).triviaResponseEntity;
        String? content = numberTrivia != null
            ? numberTrivia.description
            : AppStrings.startSearching;
        return state is HomeLoadingState
            ? Center(
                child: CircularProgressIndicator(
                  color: Colors.green,
                ),
              )
            : Text(
                content ?? '',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              );
      },
    );
  }
}
