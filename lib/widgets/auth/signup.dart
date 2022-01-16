import 'package:flutter/material.dart';
import 'package:flutter_puzzle/provider/auth_provider.dart';
import 'package:flutter_puzzle/utils/router.dart';
import 'package:flutter_puzzle/widgets/auth/login.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  late String uname, email, pwd, phno;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Register'),
        ),
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
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
                          'Sign Up',
                          style: TextStyle(fontSize: 22.0),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Row(
                      children: const [
                        Flexible(child: Text("Let's create your account")),
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
                                labelText: 'FullName',
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
                              keyboardType: TextInputType.text,
                              //obscureText: true,
                              validator: (val) =>
                                  val!.isEmpty ? 'name is required' : null,
                              onChanged: (val) {
                                setState(() => uname = val);
                              }),
                          const SizedBox(height: 20),
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
                          const SizedBox(height: 20),
                          TextFormField(
                              decoration: const InputDecoration(
                                labelText:
                                    'Phone number with phone code e.g +233820193843',
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
                              onChanged: (val) {
                                setState(() => phno = val);
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
                                  : 'REGISTER'),
                              onPressed: auth.getStatus == true
                                  ? null
                                  : () async {
                                      // var _phno = '+91$phno';
                                      if (_formKey.currentState!.validate()) {
                                        auth.createAccount(
                                            email: email,
                                            password: pwd,
                                            phone: phno,
                                            username: uname,
                                            ctx: context);
                                      }
                                    },
                            );
                          }),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextButton(
                      child: const Text(
                        'Have an account?',
                        style: TextStyle(color: Colors.blue),
                      ),
                      onPressed: () {
                        PageRouter(context).pushPageAndRemove(const SignIn());
                      },
                    )
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
