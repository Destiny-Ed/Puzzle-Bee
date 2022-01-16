import 'package:flutter/material.dart';
import 'package:flutter_puzzle/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class OTPConf extends StatefulWidget {
  const OTPConf({Key? key, required this.email}) : super(key: key);

  final String email;

  @override
  _OTPConfState createState() => _OTPConfState();
}

class _OTPConfState extends State<OTPConf> {
  final _formKey = GlobalKey<FormState>();
  late String verCode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Verification')),
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
                      Flexible(
                          child: Text(
                              "Enter verification code sent to your email")),
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
                              labelText: 'Verification code',
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
                            obscureText: true,
                            validator: (val) =>
                                val!.isEmpty ? 'code cannot be empty' : null,
                            onChanged: (val) {
                              setState(() => verCode = val);
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
                                : 'VERIFY'),
                            onPressed: auth.getStatus == true
                                ? null
                                : () async {
                                    // var _phno = '+91$phno';
                                    if (_formKey.currentState!.validate()) {
                                      auth.verifyEmail(
                                          email: widget.email,
                                          code: verCode,
                                          ctx: context);
                                    }
                                  },
                          );
                        }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
