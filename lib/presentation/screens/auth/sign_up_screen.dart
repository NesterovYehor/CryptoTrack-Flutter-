import 'package:crypto_track/presentation/widgets/app_input_field.dart';
import 'package:crypto_track/presentation/widgets/app_text_btn.dart';
import 'package:crypto_track/presentation/states/authentication_bloc/authentication_bloc.dart';
import 'package:crypto_track/presentation/widgets/logo_image.dart';
import 'package:crypto_track/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController email = TextEditingController();
    final TextEditingController password = TextEditingController();

    return Scaffold(
        body:  Center(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const Spacer(),
                LogoWidget(width: MediaQuery.of(context).size.width * 0.35),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Sign Up", style: headingStyle.copyWith(color: Theme.of(context).colorScheme.primary),)
                  ],
                ),
                const Spacer(),
                AppInputField(controller: email, hint: "Enter your email", title: 'Email', obscureText: false, icon: Icons.email, onChanged: (String ) {  },),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03,),
                AppInputField(controller: password, hint: "Enter Your Password", title: 'Password', obscureText: true, icon: Icons.lock, onChanged: (String ) {  },),
                const Spacer(),
                AppTextBtn(
                  color: Theme.of(context).colorScheme.primary, 
                  lable: "SignUp", 
                  onTap: () => context.read<AuthenticationBloc>().add(AuthEventRegister(email.text, password.text))
                  ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Forgot password ?", style: TextStyle(color: blueclr),)
                  ],
                ),
                const Spacer(),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      child: const Text("Already have an account ? SignUp", style: TextStyle(color: blueclr),),
                      onTap: () => context.go("/logIn")
                    )
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03,)
            ],
          ),
        ),
      ),
    );
  }
}