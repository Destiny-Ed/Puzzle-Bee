import 'package:flutter/material.dart';
import 'package:flutter_puzzle/utils/router.dart';
import 'package:flutter_puzzle/widgets/auth/login.dart';

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
                                prefixIcon:
                                    Icon(Icons.person, color: Colors.blue),
                                labelText: 'first and last name',
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
                          const SizedBox(height: 20),
                          TextFormField(
                              decoration: const InputDecoration(
                                prefixIcon:
                                    Icon(Icons.phone, color: Colors.blue),
                                labelText: 'phone number',
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
                              keyboardType: TextInputType.number,
                              onChanged: (val) {
                                setState(() => phno = val);
                              }),
                          const SizedBox(height: 40),
                          ElevatedButton(
                            child: const Text('REGISTER'),
                            onPressed: () async {
                              // var _phno = '+91$phno';
                            },
                          ),
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
