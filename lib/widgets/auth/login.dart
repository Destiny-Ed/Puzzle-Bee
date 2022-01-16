import 'package:flutter/material.dart';
import 'package:flutter_puzzle/utils/router.dart';
import 'package:flutter_puzzle/widgets/auth/signup.dart';

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
                      Text(
                        'Sign In',
                        style: TextStyle(fontSize: 22.0),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5.0,
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
                              prefixIcon: Icon(Icons.alternate_email,
                                  color: Colors.blue),
                              labelText: 'email id',
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
                              prefixIcon:
                                  Icon(Icons.vpn_key, color: Colors.blue),
                              labelText: 'password',
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
                        ElevatedButton(
                          child: const Text('LOGIN'),
                          onPressed: () async {},
                        ),
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
