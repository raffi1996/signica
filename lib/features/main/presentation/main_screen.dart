import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signica/core/di/app_di.dart';
import 'package:signica/core/theme/themes.dart';
import 'package:signica/features/main/presentation/bloc/main_bloc.dart';
import 'package:signica/features/main/presentation/widgets/signica_app_bar.dart';
import 'package:signica/features/main/presentation/widgets/signica_more_button.dart';
import 'package:signica/features/main/presentation/widgets/signica_rounded_body.dart';

@RoutePage()
class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt.get<MainBloc>(),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Scaffold(
            backgroundColor: Palette.appBarColor,
            appBar: const SignicaAppBar(),
            body: SignicaRoundedBody(
              child: BlocBuilder<MainBloc, MainState>(
                builder: (context, state) {
                  if (state.status.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return const Center(child: Text('Main'));
                },
              ),
            ),
          ),
          Positioned(
            top: SignicaMoreButton.topForToolbar(context),
            right: marginSizeMedium,
            child: const SignicaMoreButton(),
          ),
        ],
      ),
    );
  }
}
