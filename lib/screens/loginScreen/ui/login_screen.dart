import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:inventory_management/config/session_manager.dart';
import 'package:inventory_management/navigator/my_routes.dart';
import 'package:inventory_management/screens/loginScreen/bloc/login_screen_bloc.dart';
import 'package:inventory_management/widgets/my_primary_button.dart';
import 'package:inventory_management/widgets/my_primary_textfield.dart';
import 'package:inventory_management/widgets/otp_field_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: BlocConsumer<LoginScreenBloc, LoginScreenState>(
                listener: (context, state)async {
                  if (state is LoginSuccess) {
                    await SessionManager.instance.setLoggedIn(true).then((_){
                      context.go(MyRoutes.home);
                    });
                  }
                },
                builder: (context, state) {
                   if(state is LoginLoader) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                            child: Image.asset(
                          "assets/homeAssets/apnibus-logo.png",
                          width: 200,
                        )),
                        SizedBox(
                          height: 40,
                        ),
                        Text(
                          'Login!',
                          style: theme.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Enter your phone number to receive an OTP',
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Form
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              MyPrimaryTextField(
                                controller: _usernameController,
                                hintText: "Enter User Number",
                                keyboardType: TextInputType.phone,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your phone number';
                                  } else if (value.length != 10) {
                                    return 'Enter a valid 10-digit number';
                                  }
                                  return null;
                                },
                                prefixIcon: Icons.person,
                              ),
                              SizedBox(height: 10,),
                              MyPrimaryTextField(
                                controller: _passwordController,
                                hintText: "Enter Password",
                                keyboardType: TextInputType.phone,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Enter a correct password';
                                  } else if (value.length != 5) {
                                    return 'Enter a correct password';
                                  }
                                  return null;
                                },
                                prefixIcon:Icons.remove_red_eye,
                              ),
                              const SizedBox(height: 20),
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      height: 50, // same height as your button
                                      decoration: BoxDecoration(
                                        color: Colors.green.shade800,
                                        borderRadius: BorderRadius.circular(
                                            8), // optional, match button style
                                      ),
                                      child: const Center(
                                        child: CircularProgressIndicator(
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                  Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 40),
                      ],
                    );
                  }else {
                     return Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Center(
                             child: Image.asset(
                               "assets/homeAssets/apnibus-logo.png",
                               width: 200,
                             )),
                         SizedBox(
                           height: 40,
                         ),
                         Text(
                           'Login!',
                           style: theme.textTheme.headlineSmall?.copyWith(
                             fontWeight: FontWeight.bold,
                             color: Colors.black87,
                           ),
                         ),
                         const SizedBox(height: 8),
                         Text(
                           'Enter your phone number to receive an OTP',
                           textAlign: TextAlign.center,
                           style: theme.textTheme.bodyMedium?.copyWith(
                             color: Colors.grey[600],
                           ),
                         ),
                         const SizedBox(height: 20),

                         // Form
                         Form(
                           key: _formKey,
                           child: Column(
                             children: [
                               MyPrimaryTextField(
                                 controller: _usernameController,
                                 hintText: "Enter User Number",
                                 keyboardType: TextInputType.name,
                                 validator: (value) {
                                   if (value == null || value.isEmpty) {
                                     return 'Please enter your phone number';
                                   } else if (value.length != 10) {
                                     return 'Enter a valid 10-digit number';
                                   }
                                   return null;
                                 },
                                 prefixIcon: Icons.person,
                               ),
                               SizedBox(height: 10,),
                               MyPrimaryTextField(
                                 controller: _passwordController,
                                 hintText: "Enter Password",
                                 keyboardType: TextInputType.phone,
                                 validator: (value) {
                                   if (value == null || value.isEmpty) {
                                     return 'Enter a correct password';
                                   } else if (value.length != 5) {
                                     return 'Enter a correct password';
                                   }
                                   return null;
                                 },
                                 prefixIcon:Icons.remove_red_eye,
                               ),
                               const SizedBox(height: 20),
                               MyPrimaryButton(
                                 width: double.infinity,
                                 backgroundColor: Colors.green.shade800,
                                 onPressed: () {
                                   if (_passwordController.text.isNotEmpty&& _usernameController.text.isNotEmpty) {
                                     print(_passwordController.text);
                                     context
                                         .read<LoginScreenBloc>()
                                         .add(SendOtpEvent(
                                         _usernameController.text,
                                         _passwordController.text
                                     ));
                                   }
                                 },
                                 text: "Send OTP",
                               ),
                             ],
                           ),
                         ),
                         const SizedBox(height: 40),
                       ],
                     );
                   }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
