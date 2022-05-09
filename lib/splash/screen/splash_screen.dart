import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ping_pong/app/bloc/app_bloc.dart';


class SplashScreen extends StatelessWidget {

  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(height: 70),
            Container(
              margin: const EdgeInsets.only(right: 28.0),
              child: Image.asset(
                'assets/login_logo.png',
                height: 0.6*MediaQuery.of(context).size.height,
              ),
            ),
            const SizedBox(height: 30),
            _ContinueButton()
          ],
        ),
      ),
    );
  }
}

class _ContinueButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        const color = Color(0xFFf3722c);
        final width = MediaQuery.of(context).size.width;
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            primary: color,
            minimumSize: Size(0.8*width, 45),
          ),
          key: const Key('continueButton_splashScreen_flatButton'),
          child: const Text(
            'CONTINUE',
            style: TextStyle(color: Colors.white),
            textScaleFactor: 1.3,
          ),
          onPressed: state.status == AppStatus.authenticated
              ? () => GoRouter.of(context).go('/usernamecheck')
              : () => GoRouter.of(context).go('/login'),
        );
      },
    );
  }

}