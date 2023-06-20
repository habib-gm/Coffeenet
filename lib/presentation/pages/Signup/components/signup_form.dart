// ignore_for_file: prefer_const_constructors
import 'imports.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    Key? key,
  }) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  bool showPass = true;
  bool showConfirmPass = true;
  bool agreed = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _psdController = TextEditingController();
  final TextEditingController _confirmPsdController = TextEditingController();
  // Find the ScaffoldMessenger in the widget tree
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterationBloc, RegisterStates>(
        listener: (context, st) {
      if (st is RegisterSuccessState) {
        showDialog<String>(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) => Dialog(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.done, color: Colors.green, size: 60),
                  Text(
                      "Registration Successfull, \nPlease login to your account.",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.green, fontSize: 18)),
                  const SizedBox(height: 15),
                  TextButton(
                    onPressed: () {
                      // Navigator.pop(context);
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: ((context) => LoginScreen())));
                    },
                    child: Container(
                      color: Colors.blue,
                      padding: EdgeInsets.all(5),
                      margin: EdgeInsets.all(5),
                      child: const Text('Login',
                          style: TextStyle(color: Colors.white, fontSize: 24)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }
    }, builder: (context, st) {
      return Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: TextFormField(
                controller: _nameController,
                cursorColor: kPrimaryColor,
                onSaved: (name) {},
                validator: (name) {
                  return Validators().isNameValid(name!);
                },
                decoration: InputDecoration(
                  hintText: "Fullname",
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(defaultPadding),
                    child: Icon(Icons.person),
                  ),
                ),
              ),
            ),
            const SizedBox(height: defaultPadding / 2),
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              cursorColor: kPrimaryColor,
              onSaved: (email) {},
              validator: (email) {
                return Validators().isEmailValid(email!);
              },
              decoration: InputDecoration(
                hintText: "Email",
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.mail),
                ),
              ),
            ),
            const SizedBox(height: defaultPadding / 2),
            TextFormField(
              controller: _psdController,
              textInputAction: TextInputAction.done,
              obscureText: showPass,
              cursorColor: kPrimaryColor,
              validator: (psd) {
                return Validators().isPasswordValid(psd);
              },
              decoration: InputDecoration(
                  hintText: "password",
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(defaultPadding),
                    child: Icon(Icons.lock),
                  ),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.all(defaultPadding),
                    child: GestureDetector(
                        onTap: () {
                          setState(() {
                            showPass = !showPass;
                          });
                        },
                        child: showPass
                            ? Icon(Icons.visibility)
                            : Icon(Icons.visibility_off)),
                  )),
            ),
            const SizedBox(height: defaultPadding),
            TextFormField(
              controller: _confirmPsdController,
              textInputAction: TextInputAction.done,
              obscureText: showConfirmPass,
              cursorColor: kPrimaryColor,
              validator: (confirmpsd) {
                String psd = _psdController.text;
                if (confirmpsd == '' || confirmpsd == null) {
                  return 'confirm passord is required';
                }
                if (psd != confirmpsd) {
                  return 'password and confirm password does not match, \n please choose the same password for both.';
                }
                return null;
              },
              decoration: InputDecoration(
                  hintText: "confirm password",
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(defaultPadding),
                    child: Icon(Icons.lock),
                  ),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        showConfirmPass = !showConfirmPass;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(defaultPadding),
                      child: showConfirmPass
                          ? Icon(Icons.visibility)
                          : Icon(Icons.visibility_off),
                    ),
                  )),
            ),
            const SizedBox(height: defaultPadding / 2),
            const SizedBox(height: defaultPadding),
            BlocBuilder<RegisterationBloc, RegisterStates>(
                builder: (context, state) {
              return ElevatedButton(
                onPressed: agreed &&
                        (state is RegisterFailedState ||
                            state is RegisterationInitialState)
                    ? () {
                        if (_formKey.currentState!.validate()) {
                          // Valid form, perform submission
                          // _submitForm();
                          BlocProvider.of<RegisterationBloc>(context).add(
                              StartRegistionEvent(_nameController.text,
                                  _emailController.text, _psdController.text));
                        }
                      }
                    : null,
                child: state is RegisterLoadingState
                    ? CircularProgressIndicator()
                    : Text("Sign Up".toUpperCase()),
              );
            }),
            const SizedBox(height: defaultPadding),
            AlreadyHaveAnAccountCheck(
              login: false,
              press: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      );
    });
  }
}
