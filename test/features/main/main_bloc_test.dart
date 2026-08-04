import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:signica/core/base/bloc_state_status.dart';
import 'package:signica/core/exceptions/result.dart';
import 'package:signica/features/main/domain/interactors/main_interactor.dart';
import 'package:signica/features/main/presentation/bloc/main_bloc.dart';

class _MockMainInteractor extends Mock implements MainInteractor {}

void main() {
  late _MockMainInteractor interactor;

  setUp(() {
    interactor = _MockMainInteractor();
  });

  group('MainBloc', () {
    blocTest<MainBloc, MainState>(
      'emits [loading, success] when initial data loads',
      setUp: () {
        when(interactor.loadInitialData).thenAnswer((_) async => Result.successVoid());
      },
      build: () => MainBloc(interactor),
      expect: () => const [
        MainState(status: BlocStateStatus.loading),
        MainState(status: BlocStateStatus.success),
      ],
    );

    blocTest<MainBloc, MainState>(
      'emits [loading, error] when initial data fails',
      setUp: () {
        when(interactor.loadInitialData).thenAnswer(
          (_) async => Result.errorString('failure'),
        );
      },
      build: () => MainBloc(interactor),
      expect: () => [
        const MainState(status: BlocStateStatus.loading),
        isA<MainState>().having((s) => s.status, 'status', BlocStateStatus.error),
      ],
    );
  });
}
