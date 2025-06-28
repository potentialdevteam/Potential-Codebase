import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:potential/app/theme.dart';
import 'package:potential/features/arena/cubit/bold_admirers_cubit.dart';
import 'package:potential/features/arena/cubit/chosen_few_cubit.dart';
import 'package:potential/features/auth/cubits/auth.dart';
import 'package:potential/features/onboarding/cubit/create_account_cubit.dart';
import 'package:potential/features/auth/cubits/signin_cubit.dart';
import 'package:potential/features/onboarding/views/welcome_landing.dart';
import 'package:potential/features/profile/cubit/question_progress_cubit.dart';
import 'package:potential/features/profile/cubit/updatable_fields.dart';
import 'package:potential/features/profile/cubit/user_questions_cubit.dart';
import 'package:potential/firebase_options.dart';
import 'package:potential/features/splash/views/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final storage = await HydratedStorage.build(
    storageDirectory: HydratedStorageDirectory(
      (await getApplicationDocumentsDirectory()).path,
    ),
  );
  HydratedBloc.storage = storage;

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SigninCubit()),
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(create: (context) => CreateAccountCubit()),
        BlocProvider(create: (context) => UserQuestionsCubit()),
        BlocProvider(create: (context) => ChosenFewCubit()),
        BlocProvider(create: (context) => BoldAdmirersCubit()),
        BlocProvider(create: (context) => UpdatableFieldsCubit()),
        BlocProvider(create: (context) => QuestionProgressCubit()),
      ],
      child: MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaler: TextScaler.noScaling),
        child: MaterialApp(
          routes: {"/welcome": (context) => WelcomeLanding()},
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: ThemeMode.light,
          home: const SplashScreen(),
        ),
      ),
    );
  }
}
