import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:juniors_on_map/src/screens/home/home.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  static const routeName = "/login";
  final _userNameController = TextEditingController();
  final _passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 200),
                  height: 400,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(300),
                      ),
                      color: Colors.blue
                      // image: DecorationImage(image: Image.asset("assets/images/login.webp").image,fit: BoxFit.cover,)
                      ),
                  alignment: Alignment.center,
                  child: Text(
                    AppLocalizations.of(context)!.login,
                    style: const TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                                color: Color.fromRGBO(143, 148, 251, 0.2),
                                blurRadius: 20,
                                offset: Offset(0, 10))
                          ],
                        ),
                        child: Column(
                          children: [
                            Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    border: Border(
                                  bottom: BorderSide(color: Colors.grey[100]!),
                                )),
                                child: TextField(
                                  controller: _userNameController,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: AppLocalizations.of(context)!
                                          .userName,
                                      helperStyle:
                                          TextStyle(color: Colors.grey[400])),
                                )),
                            Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    border: Border(
                                  bottom: BorderSide(color: Colors.grey[100]!),
                                )),
                                child: TextField(
                                  controller: _passController,
                                  onSubmitted: (v) =>login(context),

                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: AppLocalizations.of(context)!
                                          .password,
                                      helperStyle:
                                          TextStyle(color: Colors.grey[400])),
                                )),
                            const SizedBox(
                              height: 30,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: MaterialButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: () =>login(context),
                                  child: Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        gradient: LinearGradient(colors: [
                                          Colors.blue,
                                          Colors.blue.withOpacity(0.6),
                                        ])),
                                    child: Center(
                                      child: Text(
                                        AppLocalizations.of(context)!.login,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 70,
                            ),
                            Text(
                              AppLocalizations.of(context)!.forgotPassword,
                              style: const TextStyle(color: Colors.blue),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void login(BuildContext context) async {
    if (_userNameController.text == "name" && _passController.text == "1234") {
      Navigator.pushReplacementNamed(context, Home.routeName);
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(AppLocalizations.of(context)!.wrong),
          content:
              Text(AppLocalizations.of(context)!.pleasCheckUserNameOrPassword),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(AppLocalizations.of(context)!.ok))
          ],
        ),
      );
    }
  }
}
