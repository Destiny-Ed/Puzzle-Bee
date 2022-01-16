import 'package:flutter/material.dart';

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
      appBar: AppBar(title: const Text('Verify Email')),
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
                  Row(
                    children: const [
                      Text(
                        'Verification',
                        style: TextStyle(fontSize: 22.0),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5.0,
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
                              labelText: 'verification code',
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
                        ElevatedButton(
                          child: const Text('VERIFY'),
                          onPressed: () async {
                            print(verCode);
                          },
                        ),
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
