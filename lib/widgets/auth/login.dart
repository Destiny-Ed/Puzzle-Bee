import 'package:flutter/material.dart';
import 'package:flutter_puzzle/provider/auth_provider.dart';
import 'package:flutter_puzzle/utils/router.dart';
import 'package:flutter_puzzle/widgets/auth/signup.dart';
import 'package:provider/provider.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  late String email, pwd;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Row(
                    children: const [
                      Flexible(child: Text("Enter your credentials to login")),
                    ],
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Email',
                              hintText: '',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                  borderSide: BorderSide(color: Colors.grey)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                  borderSide: BorderSide(color: Colors.blue)),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            //obscureText: true,
                            validator: (val) =>
                                val!.isEmpty ? 'email is required' : null,
                            onChanged: (val) {
                              setState(() => email = val);
                            }),
                        const SizedBox(height: 20),
                        TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Password',
                              hintText: "",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                  borderSide: BorderSide(color: Colors.grey)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                  borderSide: BorderSide(color: Colors.blue)),
                            ),
                            keyboardType: TextInputType.text,
                            obscureText: true,
                            validator: (val) =>
                                val!.isEmpty ? 'password is required' : null,
                            onChanged: (val) {
                              setState(() => pwd = val);
                            }),
                        const SizedBox(height: 40),
                        Consumer<AuthenticationProvider>(
                            builder: (context, auth, child) {
                          WidgetsBinding.instance!.addPostFrameCallback((_) {
                            if (auth.getMsg != '') {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(auth.getMsg)));

                              auth.clearMessage();
                            }
                          });
                          return ElevatedButton(
                            child: Text(auth.getStatus == true
                                ? 'PLEASE WAIT...'
                                : 'LOGIN'),
                            onPressed: auth.getStatus == true
                                ? null
                                : () async {
                                    // var _phno = '+91$phno';
                                    if (_formKey.currentState!.validate()) {
                                      auth.loginUser(
                                          email: email,
                                          password: pwd,
                                          ctx: context);
                                    }
                                  },
                          );
                        }),
                      ],
                    ),
                  ),
                  TextButton(
                    child: const Text(
                      'Don\'t have an account?',
                      style: TextStyle(color: Colors.blue),
                    ),
                    onPressed: () async {
                      PageRouter(context).pushPage(const SignUp());
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
