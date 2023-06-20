import 'imports.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _psdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthStates>(listener: (context, state) {
      if (state is LoggedInState) {
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) {
            return const MainScreen();
          },
        ));
      }

      if (state is LoginFailedState) {
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => Dialog(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Icon(Icons.error, color: Colors.red, size: 60),
                  const Text("Error, Please try again!",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.red, fontSize: 18)),
                  const SizedBox(height: 15),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      color: Colors.blue,
                      padding: const EdgeInsets.all(5),
                      margin: const EdgeInsets.all(5),
                      child: const Text('Retry',
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
            // BlocBuilder<AuthBloc, AuthStates>(
            //   builder: (context, state) {
            //     return Text;
            //   }
            // ),
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              cursorColor: kPrimaryColor,
              onSaved: (email) {},
              validator: (email) {
                return Validators().isEmailValid(email);
              },
              decoration: const InputDecoration(
                hintText: "Your email",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.person),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: defaultPadding),
              child: TextFormField(
                controller: _psdController,
                textInputAction: TextInputAction.done,
                obscureText: true,
                validator: (psd) {
                  return Validators().isPasswordValid(psd);
                },
                cursorColor: kPrimaryColor,
                decoration: const InputDecoration(
                  hintText: "Your password",
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(defaultPadding),
                    child: Icon(Icons.lock),
                  ),
                ),
              ),
            ),
            ForgetPasswordCheck(
              press: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const ForgetPassword();
                    },
                  ),
                );
              },
            ),
            const SizedBox(height: defaultPadding / 2),
            BlocBuilder<AuthBloc, AuthStates>(builder: (context, st) {
              return ElevatedButton(
                onPressed: st is LoginFailedState || st is LoggingInitialState
                    ? () {
                        // if (_formKey.currentState!.validate()) {
                        // Valid form, perform submission
                        // _submitForm();
                        BlocProvider.of<AuthBloc>(context).add(LoginEvent(
                            _emailController.text, _psdController.text));
                        // }
                      }
                    : null,
                child: st is LoggingInState
                    ? const CircularProgressIndicator()
                    : Text(
                        "Login".toUpperCase(),
                      ),
              );
            }),
            const SizedBox(height: defaultPadding),
            AlreadyHaveAnAccountCheck(
              press: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const SignUpScreen();
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
