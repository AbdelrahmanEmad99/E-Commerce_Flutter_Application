import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Navigation.dart';
import 'SignUpScreen.dart';
import 'package:lottie/lottie.dart';

import 'HomeScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Icon _iconPassword = const Icon(Icons.visibility);

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final _loginformkey = GlobalKey<FormState>();

  FocusNode _passwordFocusNode = FocusNode();

  final _emailcontroller = TextEditingController(text: '');
  final _passwordcontroller = TextEditingController(text: '');

  bool _isloading = false;
  bool _obscureText = true;

  void SignIn() async {
    final isvalid = _loginformkey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isvalid) {
      setState(() {
        _isloading = true;
      });
      try {
        await _auth.signInWithEmailAndPassword(
            email: _emailcontroller.text.toLowerCase().trim(),
            password: _passwordcontroller.text.trim());
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => App(),
            ));
      } catch (e) {
        setState(() {
          _isloading = false;
        });
        _ShowerrorDialog(e);
      }
    } else {
      print('form isn\'t valided');
    }
    setState(() {
      _isloading = false;
    });
  }
/*

Future SignIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailcontroller.text.trim(),
        password: _passwordcontroller.text.trim());
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen()));
  }

*/

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
    _passwordFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //image
                Lottie.asset('assets/images/animation_lm42o0xa.json',
                    height: 200)
                //title
                ,
                Text(
                  "SIGN IN",
                  style: GoogleFonts.robotoCondensed(
                      fontSize: 35, fontWeight: FontWeight.bold),
                ),
                //subtitle
                Text(
                  "Welcome back , Nice to see you again :-)",
                  style: GoogleFonts.robotoCondensed(
                    fontSize: 18,
                  ),
                ),

                //Email textfield
                const SizedBox(height: 50),
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 25),
                //   child: Container(
                //     decoration: BoxDecoration(
                //       color: Colors.white,
                //       borderRadius: BorderRadius.circular(12),
                //     ),
                //     child: Padding(
                //       padding: EdgeInsets.symmetric(horizontal: 20),
                //       child: TextField(
                //         controller: _emailcontroller,
                //         decoration: InputDecoration(
                //             border: InputBorder.none, hintText: "Email"),
                //       ),
                //     ),
                //   ),
                // ),

                Form(
                  key: _loginformkey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: TextFormField(
                              validator: (value) {
                                if (value!.isEmpty || !value.contains('@')) {
                                  return 'please enter a valid Email address';
                                }
                                return null;
                              },
                              onEditingComplete: () => FocusScope.of(context)
                                  .requestFocus(_passwordFocusNode),
                              textInputAction: TextInputAction.next,
                              controller: _emailcontroller,
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                  hintText: 'Email',
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  errorBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.red))),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: TextFormField(
                              validator: (value) {
                                if (value!.isEmpty || value.length < 7) {
                                  return 'please enter a password';
                                }
                                return null;
                              },
                              onEditingComplete: SignIn,
                              textInputAction: TextInputAction.go,
                              obscureText: _obscureText,
                              cursorColor: Colors.white,
                              controller: _passwordcontroller,
                              keyboardType: TextInputType.visiblePassword,
                              decoration: InputDecoration(
                                  suffixIcon: GestureDetector(
                                    child: Icon(
                                        _obscureText
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: Colors.black45),
                                    onTap: () {
                                      setState(() {
                                        _obscureText = !_obscureText;
                                      });
                                    },
                                  ),
                                  hintText: 'Password',
                                  enabledBorder: const UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  focusedBorder: const UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  errorBorder: const UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.red))),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),
                //password textfield
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 25),
                //   child: Container(
                //     decoration: BoxDecoration(
                //       color: Colors.white,
                //       borderRadius: BorderRadius.circular(12),
                //     ),
                //     child: Padding(
                //       padding: const EdgeInsets.symmetric(horizontal: 20),
                //       child: TextField(
                //         controller: _passwordcontroller,
                //         obscureText: true,
                //         decoration: const InputDecoration(
                //           border: InputBorder.none,
                //           hintText: "Password",
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                //Sign in button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: _isloading
                      ? Center(
                          child: Container(
                              width: 35,
                              height: 35,
                              child: CircularProgressIndicator(
                                color: Colors.amber[900],
                              )),
                        )
                      : GestureDetector(
                          onTap: SignIn,
                          child: Container(
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                                color: Colors.amber[900],
                                borderRadius: BorderRadius.circular(12)),
                            child: Center(
                                child: Text(
                              "SIGN In",
                              style: GoogleFonts.robotoCondensed(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )),
                          ),
                        ),
                ),
                //sign up text
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Not yet a member?',
                      style: GoogleFonts.robotoCondensed(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => const SignUpScreen()));
                        },
                        child: Text(
                          'SIGN Up',
                          style: GoogleFonts.robotoCondensed(
                              color: Colors.amber[900],
                              fontWeight: FontWeight.bold),
                        )),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _ShowerrorDialog(Error) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(
              children: [
                const Icon(Icons.error_outline),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Error Occured',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.amber[900],
                        fontSize: 18),
                  ),
                )
              ],
            ),
            content:
                Text('${Error}', style: const TextStyle(color: Colors.black)),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.canPop(context) ? Navigator.pop(context) : null;
                  },
                  child: Text(
                    'OK',
                    style: TextStyle(color: Colors.red.shade600),
                  ))
            ],
          );
        });
  }
}
