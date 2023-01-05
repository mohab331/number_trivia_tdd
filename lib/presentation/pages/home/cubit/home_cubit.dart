import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_driven/core/index.dart';
import 'package:test_driven/domain/index.dart';
import 'package:test_driven/presentation/pages/home/cubit/home_states.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit({
    required this.getConcreteNumberTriviaUseCase,
    required this.getRandomNumberTriviaUseCase,
  }) : super(HomeInitialState());

  final GetConcreteNumberTriviaUseCase getConcreteNumberTriviaUseCase;
  final GetRandomNumberTriviaUseCase getRandomNumberTriviaUseCase;

  static HomeCubit get(context) => BlocProvider.of(context);
  TriviaResponseEntity? triviaResponseEntity;

  Future<void> getConcreteNumberTrivia({required int number}) async {
    emit(HomeLoadingState());
    final response =
        await getConcreteNumberTriviaUseCase.getConcreteNumberTrivia(
      requestTriviaEntity: TriviaRequestEntity(
        numberTrivia: number,
      ),
    );
    response.fold((_) {
      emit(
        HomeErrorState(
          errorMessage: AppStrings.errorGettingData,
        ),
      );
    }, (r) {
      triviaResponseEntity = r;
      emit(
        HomeGetNumberSuccessState(
          triviaResponseEntity: r,
        ),
      );
    });
  }

  Future<void> getRandomNumberTrivia() async {
    emit(HomeLoadingState());
    final response = await getRandomNumberTriviaUseCase.getRandomNumberTrivia();
    response.fold((_) {
      emit(
        HomeErrorState(
          errorMessage: AppStrings.errorGettingData,
        ),
      );
    }, (r) {
      triviaResponseEntity = r;
      emit(
        HomeGetNumberSuccessState(
          triviaResponseEntity: r,
        ),
      );
    });
  }
}
