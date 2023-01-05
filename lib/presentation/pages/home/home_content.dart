import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:test_driven/core/index.dart';
import 'package:test_driven/presentation/reusable_widgets/index.dart';
import 'package:test_driven/utilities/index.dart';

import 'cubit/index.dart';

class HomeContent extends HookWidget {
  HomeContent({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final numberTextEditingController = useTextEditingController();
    return Container(
      alignment: Alignment.center,
      height: context.height,
      padding: const EdgeInsets.symmetric(
        vertical: 20.0,
        horizontal: 20.0,
      ),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MessageDisplayWidget(),
              SizedBox(
                height: context.height * 0.1,
              ),
              CustomTextFormField(
                textEditingController: numberTextEditingController,
                cursorColor: Colors.green,
                autoValidateMode: AutovalidateMode.onUserInteraction,
                labelText: AppStrings.numberLabel,
                keyBoardType: TextInputType.number,
                validate: (String? value) => value.validateNumber(),
              ),
              SizedBox(
                height: context.height * 0.04,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomButton(
                    buttonColor: Colors.green,
                    isLoading: context.watch<HomeCubit>().state.runtimeType ==
                            HomeLoadingState
                        ? true
                        : false,
                    onButtonPressed: () async => _onSearchButtonPressed(
                      _formKey,
                      number: numberTextEditingController.value.text
                          .parseStringToInt(),
                      context: context,
                    ),
                    buttonLabel: AppStrings.searchButtonLabel,
                  ),
                  SizedBox(
                    width: context.width * 0.06,
                  ),
                  CustomButton(
                    buttonColor: Colors.grey,
                    onButtonPressed: () async =>
                        _onGetRandomTriviaButtonPressed(
                      context: context,
                    ),
                    isLoading: context.watch<HomeCubit>().state.runtimeType ==
                            HomeLoadingState
                        ? true
                        : false,
                    buttonLabel: AppStrings.getRandomTriviaButtonLabel,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _onSearchButtonPressed(
    GlobalKey<FormState> formKey, {
    required BuildContext context,
    required int? number,
  }) async {
    if (number != null && _validateAndSaveForm(formKey: formKey)) {
      await HomeCubit.get(context).getConcreteNumberTrivia(number: number);
    }
  }

  Future<void> _onGetRandomTriviaButtonPressed({
    required BuildContext context,
  }) async {
    await HomeCubit.get(context).getRandomNumberTrivia();
  }

  bool _validateAndSaveForm({
    required GlobalKey<FormState> formKey,
  }) {
    if ((formKey.currentState?.validate() ?? false)) {
      formKey.currentState?.save();
      return true;
    }
    return false;
  }
}
