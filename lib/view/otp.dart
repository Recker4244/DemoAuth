// import 'package:firebase_phone_auth_handler/firebase_phone_auth_handler.dart';
// import 'package:flutter/material.dart';

// class OTP extends StatefulWidget {
//   final int? number;
//   const OTP({Key? key,this.number}) : super(key: key);

//   @override
//   State<OTP> createState() => _OTPState();
// }

// class _OTPState extends State<OTP> {
//   @override
//   Widget build(BuildContext context) {
    
//     return FirebasePhoneAuthHandler(
//     phoneNumber: "+919777139671",
//     // If true, the user is signed out before the onLoginSuccess callback is fired when the OTP is verified successfully.
//     signOutOnSuccessfulVerification: false,
    
//     linkWithExistingUser: false,
//     builder: (context, controller) {
//       return SizedBox.shrink();
//     },
//     onLoginSuccess: (userCredential, autoVerified) {
//       debugPrint("autoVerified: $autoVerified");
//       debugPrint("Login success UID: ${userCredential.user?.uid}");
//     },
//     onLoginFailed: (authException, stackTrace) {
//       debugPrint("An error occurred: ${authException.message}");
//     },
//     onError: (error, stackTrace) {},
// );
    
//     return Scaffold(body: Column(children: [Text("Enter OTP"),
//     Text("A five-digit OTP has been sent to +91${widget.number}"),
//     Row(children: [
//       Text("Incorrect Number?"),
//       GestureDetector(child: Text("Change"),)
//     ],)
//     ],),);
//   }
// }

import 'dart:async';
import 'dart:developer';

import 'package:firebase_phone_auth_handler/firebase_phone_auth_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pinput/pinput.dart';

enum OTPState {
  sent,
  verified,
  timerExpired,
  waitingForRetrieval
}
class VerifyPhoneNumberScreen extends StatefulWidget {
  static const id = 'VerifyPhoneNumberScreen';

  final String phoneNumber;

  const VerifyPhoneNumberScreen({
    Key? key,
    required this.phoneNumber,
  }) : super(key: key);

  @override
  State<VerifyPhoneNumberScreen> createState() =>
      _VerifyPhoneNumberScreenState();
}

class _VerifyPhoneNumberScreenState extends State<VerifyPhoneNumberScreen>
    with WidgetsBindingObserver {
      late OTPState _state;
  bool isKeyboardVisible = false;

  late final ScrollController scrollController;

  @override
  void initState() {
    scrollController = ScrollController();
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    scrollController.dispose();
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    final bottomViewInsets = WidgetsBinding.instance.window.viewInsets.bottom;
    isKeyboardVisible = bottomViewInsets > 0;
  }

  // scroll to bottom of screen, when pin input field is in focus.
  Future<void> _scrollToBottomOnKeyboardOpen() async {
    while (!isKeyboardVisible) {
      await Future.delayed(const Duration(milliseconds: 50));
    }

    await Future.delayed(const Duration(milliseconds: 250));

    await scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeIn,
    );
  }
void showSnackBar(
  String text, {
  Duration duration = const Duration(seconds: 2),
}) {
 ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(text), duration: duration),
    );
}
 final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      
      decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 2, color: Colors.grey))),
    );

    

    late Timer _timer;
int _start = 30;

void startTimer() {
  const oneSec = const Duration(seconds: 1);
  _timer = new Timer.periodic(
    oneSec,
    (Timer timer) {
      if (_start == 0) {
        setState(() {
          timer.cancel();
        });
      } else {
        setState(() {
          _start--;
        });
      }
    },
  );
}
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FirebasePhoneAuthHandler(
        phoneNumber: widget.phoneNumber,
        signOutOnSuccessfulVerification: false,
        linkWithExistingUser: false,
        autoRetrievalTimeOutDuration: const Duration(seconds: 60),
        otpExpirationDuration: const Duration(seconds: 60),
        onCodeSent: () {
          setState(() {
            _state=OTPState.sent;
          });
         startTimer();
        },
        onLoginSuccess: (userCredential, autoVerified) async {
          setState(() {
            _state=OTPState.verified;
            _start=0;
            _timer.cancel();
          });
          Navigator.of(context).pop();
          showSnackBar('OTP verified successfully');

          

        },
        onLoginFailed: (authException, stackTrace) {
          log(
            VerifyPhoneNumberScreen.id,
            name: authException.message!,
            error: authException,
            stackTrace: stackTrace,
          );

          switch (authException.code) {
            case 'invalid-phone-number':
              // invalid phone number
              return showSnackBar('Invalid phone number!');
            case 'invalid-verification-code':
              // invalid otp entered
              return showSnackBar('The entered OTP is invalid!');
            // handle other error codes
            default:
              showSnackBar('Something went wrong!');
            // handle error further if needed
          }
        },
        onError: (error, stackTrace) {
          log(
            VerifyPhoneNumberScreen.id,
            error: error,
            stackTrace: stackTrace,
          );

          showSnackBar('An error occurred!');
        },
        builder: (context, controller) {
          return SafeArea(
            child: Scaffold(
          
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                // leadingWidth: 0,
                // leading: const SizedBox.shrink(),
                // title: const Text('Verify Phone Number'),
                // actions: [
                
                //   const SizedBox(width: 5),
                // ],
              ),
              body: controller.isSendingCode
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircularProgressIndicator.adaptive(
              valueColor: AlwaysStoppedAnimation<Color>(
                Theme.of(context).colorScheme.secondary,
              ),
            ),
                        SizedBox(height: 50),
                        Center(
                          child: Text(
                            'Sending OTP',
                            style: TextStyle(fontSize: 25),
                          ),
                        ),
                      ],
                    )
                  : ListView(
                      padding: const EdgeInsets.all(20),
                      controller: scrollController,
                      children: [
                        const Text(
                          'Enter OTP',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "A five-digit code has been sent to ${widget.phoneNumber}",
                          style: const TextStyle(fontSize: 16),
                        ),
                        _state==OTPState.sent?Row(children: [
                Text("Incorrect Number?  "),
                GestureDetector(child: Text("Change",style: TextStyle(color:Color.fromRGBO(191, 251, 98, 1) ),),onTap: ()async{
                  
                },)
              ],):Container(),
                        const SizedBox(height: 10),
                        const Divider(),
            //             if (controller.isListeningForOtpAutoRetrieve)
            //               Column(
            //                 children: [
            //                   CircularProgressIndicator.adaptive(
            //   valueColor: AlwaysStoppedAnimation<Color>(
            //     Theme.of(context).colorScheme.secondary,
            //   ),
            // ),
            //                   SizedBox(height: 50),
            //                   Text(
            //                     'Listening for OTP',
            //                     textAlign: TextAlign.center,
            //                     style: TextStyle(
            //                       fontSize: 25,
            //                       fontWeight: FontWeight.w600,
            //                     ),
            //                   ),
                              
            //                 ],
            //               ),
                        const SizedBox(height: 15),
                        
                        const SizedBox(height: 15),
                        Pinput(
                          onSubmitted: (enteredOtp) async {
                            final verified =
                                await controller.verifyOtp(enteredOtp);
                            if (verified) {
                              // number verify success
                              
                            } else {
                              // phone verification failed
                              // will call onLoginFailed or onError callbacks with the error
                            }
                          },
                  length: 6,
                  defaultPinTheme: defaultPinTheme,
                  focusedPinTheme: defaultPinTheme.copyWith(
                   
            decoration: defaultPinTheme.decoration!.copyWith(
              border: Border.all(color: Theme.of(context).colorScheme.secondary),
            ),
                  ),
                  errorPinTheme: defaultPinTheme.copyWith(
            decoration: BoxDecoration(
              color: Theme.of(context).errorColor,
              borderRadius: BorderRadius.circular(8),
            ),
                  ),
                 
                  pinAnimationType: PinAnimationType.scale,
                  // submittedFieldDecoration: _pinPutDecoration,
                  // selectedFieldDecoration: _pinPutDecoration,
                  // followingFieldDecoration: _pinPutDecoration,
                  // textStyle: const TextStyle(
                  //   color: Colors.black,
                  //   fontSize: 20.0,
                  //   fontWeight: FontWeight.w600,
                  // ),
                ),
                SizedBox(height: 50,),
                  (controller.codeSent&&_start==0)?
                    Center(
            child: GestureDetector(
                        onTap: () async{
                         await controller.sendOTP();
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
                              children: [
                            //     Image(
                            //   image: AssetImage('assets/icons/googleicon.png'),
                            // ),
                            //SizedBox(width: 20,),
                            Text("Resend OTP",style: TextStyle(fontSize: 20),),
                            //Text("Google",style: TextStyle(fontWeight: FontWeight.bold),)
                            ],)
                            ,
                            
                          ),
                        ),
                      ),

                  ):Center(
            child: GestureDetector(
                        onTap: () async{
                        // await controller.sendOTP();
                        },
                        child: Container(
                          width: 300,
                          height: 50,
                          decoration: BoxDecoration(
                            border: Border.all(color: Color.fromRGBO(226, 226, 226, 1)),
                            color: Color.fromARGB(255, 246, 255, 244),
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(11),
                            child: 
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                            //     Image(
                            //   image: AssetImage('assets/icons/googleicon.png'),
                            // ),
                            //SizedBox(width: 20,),
                            Text("Resend OTP",style: TextStyle(fontSize: 20),),
                            //Text("Google",style: TextStyle(fontWeight: FontWeight.bold),)
                            ],)
                            ,
                            
                          ),
                        ),
                      ),

                  ),
                  if(_start>0)
                  Center(child: Text("Resend OTP in $_start",style: TextStyle(fontSize: 16),)),
                      ],
                    ),
            ),
          );
        },
      ),
    );
  }
}