import 'package:auth_flow/view/otp.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:google_fonts/google_fonts.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            bottom: new PreferredSize(
              preferredSize: new Size(200.0, 50.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0) + EdgeInsets.only(left: 20),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(35),
                          topRight: Radius.circular(35),
                          bottomLeft: Radius.circular(35),
                          bottomRight: Radius.circular(35),
                        ),
                        border: Border.all(
                          color: Color.fromRGBO(226, 226, 226, 1),
                          width: 1,
                        ),
                      ),
                      width: 200,
                      child: TabBar(
                        labelColor: Colors.black,
                        unselectedLabelColor: Colors.black,
                        labelStyle: TextStyle(color: Colors.black),
                        indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color.fromRGBO(191, 251, 98, 1),
                        ),
                        tabs: [
                          Tab(
                            text: "Sign In",
                          ),
                          Tab(
                            text: "Sign Up",
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            elevation: 0,
            backgroundColor: Colors.white,
          ),
          body: TabBarView(children: [
            SignInPage(),
            SignUpPage(),
          ])),
    );
  }
}

class SignInPage extends StatefulWidget {
  const SignInPage({
    Key? key,
  }) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {

late String phoneNumber;
    String? validateMobile(String? value) {
String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
RegExp regExp = new RegExp(patttern);
if (value!.length == 0) {
      return 'Please enter mobile number';
}
else if (!regExp.hasMatch(value)) {
      return 'Please enter valid mobile number';
}
return "";
}
  @override
  Widget build(BuildContext context) {
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Welcome Back!!", style: GoogleFonts.lora(fontWeight:FontWeight.w600,fontSize: 24)),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Please login with your phone number",style: GoogleFonts.lato()),
        ),
        // Figma Flutter Generator Frame34418Widget - FRAME - HORIZONTAL
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            validator: validateMobile,
                        onChanged: (value) {
                          setState(() {
                            phoneNumber=value;
                          });
                        },
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)

                        ),
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              InkWell(
                                onTap: () async {
                                  
                                },
                                child: Row(
                                  children: [
                                   
                                    const SizedBox(
                                      width: 1,
                                    ),
                                    Container(
                                        child: Text(
                                       "+91",
                                      style: TextStyle(fontSize: 16.0,color: Colors.grey),
                                    )),
                                    
                                    Container(
                                        child: Text(
                                       "|",
                                      style: TextStyle(fontSize: 30.0,color: Colors.grey),
                                    )),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        hintStyle: TextStyle(fontSize: 16.0,color: Colors.grey),
                        hintText: 'Phone Number',
                      ),
                      
                    ),
        ),
        GestureDetector(
          onTap: (() {
           Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => VerifyPhoneNumberScreen(phoneNumber: "+91${phoneNumber}")),
  );
          }),
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35),
                  topRight: Radius.circular(35),
                  bottomLeft: Radius.circular(35),
                  bottomRight: Radius.circular(35),
                ),
                boxShadow: [
                  BoxShadow(
                      color: Color.fromRGBO(153, 153, 153, 0.10000000149011612),
                      offset: Offset(0, 5),
                      blurRadius: 10)
                ],
                color: Color.fromRGBO(191, 251, 98, 1),
              ),
              padding: EdgeInsets.symmetric(horizontal: 135, vertical: 20),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    'Continue',
                    textAlign: TextAlign.center,
                    style:
                    GoogleFonts.alef(fontSize: 17)
                     
                  ),
                ],
              ),
            ),
          ),
        ),
        
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: Transform.rotate(
                  angle: -180 * (math.pi / 180),
                  child: Divider(
                      color: Color.fromARGB(225, 214, 214, 214), thickness: 1),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                    'OR',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color.fromRGBO(44, 49, 52, 1),
                        //fontFamily: 'Cera Pro',
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                        height: 1.5 /*PERCENT not supported*/
                        ),
                  ),
              ),
              Expanded(
                child: Divider(
                    color: Color.fromARGB(225, 214, 214, 214), thickness: 1),
              )
            ],
          ),
        ),
        Center(
          child: GestureDetector(
                      onTap: () {
                       
                      },
                      child: Container(
                        width: 300,
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(color: Color.fromRGBO(226, 226, 226, 1)),
                          color: Color.fromRGBO(245, 255, 243, 1),
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(11),
                          child: 
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [Image(
                            image: AssetImage('assets/icons/metamask.png'),
                          ),
                          SizedBox(width: 20,),
                          Text("Connect to "),
                          Text("Metamask",style: TextStyle(fontWeight: FontWeight.bold),)
                          ],)
                          ,
                        ),
                      ),
                    ),
        ),
        Center(
          child: GestureDetector(
                      onTap: () {
                       
                      },
                      child: Container(
                        width: 300,
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(color: Color.fromRGBO(226, 226, 226, 1)),
                          color: Color.fromRGBO(245, 255, 243, 1),
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(11),
                          child: 
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [Image(
                            image: AssetImage('assets/icons/googleicon.png'),
                          ),
                          SizedBox(width: 20,),
                          Text("Connect to "),
                          Text("Google",style: TextStyle(fontWeight: FontWeight.bold),)
                          ],)
                          ,
                        ),
                      ),
                    ),
        ),
        Center(
          child: GestureDetector(
                      onTap: () {
                       
                      },
                      child: Container(
                        width: 300,
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(color: Color.fromRGBO(226, 226, 226, 1)),
                          color: Colors.black,
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(11),
                          child: 
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [Image(
                            image: AssetImage('assets/icons/apple.png'),
                          ),
                          SizedBox(width: 20,),
                          Text("Connect to ",style: TextStyle(color:Colors.white)),
                          Text("Apple",style: TextStyle(fontWeight: FontWeight.bold,color:Colors.white))
                          ],)
                          ,
                        ),
                      ),
                    ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Don’t have an account?  ',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Cera Pro',
                  fontSize: 14,
                  letterSpacing:
                      0 /*percentages not used in flutter. defaulting to zero*/,
                  fontWeight: FontWeight.normal,
                  height: 1.5 /*PERCENT not supported*/
                  ),
            ),
            GestureDetector(
              onTap: (){
                DefaultTabController.of(context)!.animateTo(1);
              },
              child: Text("Signup",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color.fromRGBO(191, 251, 98, 1),
                      fontFamily: 'Cera Pro',
                      fontSize: 14,
                      letterSpacing:
                          0 /*percentages not used in flutter. defaulting to zero*/,
                      fontWeight: FontWeight.normal,
                      height: 1.5)),
            )
          ],
        )
      ],
    );
  }


}

class SignUpPage extends StatefulWidget {
  const SignUpPage({
    Key? key,
  }) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
 late String phoneNumber;
    String? validateMobile(String? value) {
String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
RegExp regExp = new RegExp(patttern);
if (value!.length == 0) {
      return 'Please enter mobile number';
}
else if (!regExp.hasMatch(value)) {
      return 'Please enter valid mobile number';
}
return "";
}
  @override
  Widget build(BuildContext context) {
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Welcome to App", style: GoogleFonts.lora(fontWeight:FontWeight.w600,fontSize: 24)),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Please signup with your phone number to get registered",style: GoogleFonts.lato()),
        ),
        // Figma Flutter Generator Frame34418Widget - FRAME - HORIZONTAL
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            validator: validateMobile,
                        onChanged: (value) {
                          setState(() {
                            phoneNumber=value;
                          });
                        },
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)

                        ),
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              InkWell(
                                onTap: () async {
                                  
                                },
                                child: Row(
                                  children: [
                                   
                                    const SizedBox(
                                      width: 1,
                                    ),
                                    Container(
                                        child: Text(
                                       "+91",
                                      style: TextStyle(fontSize: 16.0,color: Colors.grey),
                                    )),
                                    
                                    Container(
                                        child: Text(
                                       "|",
                                      style: TextStyle(fontSize: 30.0,color: Colors.grey),
                                    )),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        hintStyle: TextStyle(fontSize: 16.0,color: Colors.grey),
                        hintText: 'Phone Number',
                      ),
                      
                    ),
        ),
        GestureDetector(
          onTap: (() {
           Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => VerifyPhoneNumberScreen(phoneNumber: "+91${phoneNumber}")),
  );
          }),
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35),
                  topRight: Radius.circular(35),
                  bottomLeft: Radius.circular(35),
                  bottomRight: Radius.circular(35),
                ),
                boxShadow: [
                  BoxShadow(
                      color: Color.fromRGBO(153, 153, 153, 0.10000000149011612),
                      offset: Offset(0, 5),
                      blurRadius: 10)
                ],
                color: Color.fromRGBO(191, 251, 98, 1),
              ),
              padding: EdgeInsets.symmetric(horizontal: 135, vertical: 20),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    'Continue',
                    textAlign: TextAlign.center,
                    style:
                    GoogleFonts.alef(fontSize: 17)
                     
                  ),
                ],
              ),
            ),
          ),
        ),
        
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: Transform.rotate(
                  angle: -180 * (math.pi / 180),
                  child: Divider(
                      color: Color.fromARGB(225, 214, 214, 214), thickness: 1),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                    'OR',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color.fromRGBO(44, 49, 52, 1),
                        //fontFamily: 'Cera Pro',
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                        height: 1.5 /*PERCENT not supported*/
                        ),
                  ),
              ),
              Expanded(
                child: Divider(
                    color: Color.fromARGB(225, 214, 214, 214), thickness: 1),
              )
            ],
          ),
        ),
        Center(
          child: GestureDetector(
                      onTap: () {
                       
                      },
                      child: Container(
                        width: 300,
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(color: Color.fromRGBO(226, 226, 226, 1)),
                          color: Color.fromRGBO(245, 255, 243, 1),
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(11),
                          child: 
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [Image(
                            image: AssetImage('assets/icons/metamask.png'),
                          ),
                          SizedBox(width: 20,),
                          Text("Connect to "),
                          Text("Metamask",style: TextStyle(fontWeight: FontWeight.bold),)
                          ],)
                          ,
                        ),
                      ),
                    ),
        ),
        Center(
          child: GestureDetector(
                      onTap: () {
                       
                      },
                      child: Container(
                        width: 300,
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(color: Color.fromRGBO(226, 226, 226, 1)),
                          color: Color.fromRGBO(245, 255, 243, 1),
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(11),
                          child: 
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [Image(
                            image: AssetImage('assets/icons/googleicon.png'),
                          ),
                          SizedBox(width: 20,),
                          Text("Connect to "),
                          Text("Google",style: TextStyle(fontWeight: FontWeight.bold),)
                          ],)
                          ,
                        ),
                      ),
                    ),
        ),
        Center(
          child: GestureDetector(
                      onTap: () {
                       
                      },
                      child: Container(
                        width: 300,
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(color: Color.fromRGBO(226, 226, 226, 1)),
                          color: Colors.black,
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(11),
                          child: 
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [Image(
                            image: AssetImage('assets/icons/apple.png'),
                          ),
                          SizedBox(width: 20,),
                          Text("Connect to ",style: TextStyle(color:Colors.white)),
                          Text("Apple",style: TextStyle(fontWeight: FontWeight.bold,color:Colors.white))
                          ],)
                          ,
                        ),
                      ),
                    ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Don’t have an account?  ',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Cera Pro',
                  fontSize: 14,
                  letterSpacing:
                      0 /*percentages not used in flutter. defaulting to zero*/,
                  fontWeight: FontWeight.normal,
                  height: 1.5 /*PERCENT not supported*/
                  ),
            ),
            GestureDetector(
              onTap: (){
                DefaultTabController.of(context)!.animateTo(1);
              },
              child: Text("Signup",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color.fromRGBO(191, 251, 98, 1),
                      fontFamily: 'Cera Pro',
                      fontSize: 14,
                      letterSpacing:
                          0 /*percentages not used in flutter. defaulting to zero*/,
                      fontWeight: FontWeight.normal,
                      height: 1.5)),
            )
          ],
        )
      ],
    );
  }


}
