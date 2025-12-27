import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/routes/route_names.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../shared/widgets/app_background.dart';

class OTPVerificationScreen extends StatefulWidget {
  final String email;
  final bool isRegistration;
  
  const OTPVerificationScreen({
    super.key,
    required this.email,
    required this.isRegistration,
  });

  @override
  State<OTPVerificationScreen> createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
  final _otpController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  void _handleContinue() async {
    if (_otpController.text.length == 4) {
      setState(() => _isLoading = true);
      
      // TODO: Implement actual OTP verification logic
      await Future.delayed(const Duration(seconds: 1));
      
      if (mounted) {
        setState(() => _isLoading = false);
        // Navigate to password screen
        context.push(
          '${RouteNames.password}?email=${Uri.encodeComponent(widget.email)}&isRegistration=${widget.isRegistration}',
        );
      }
    }
  }

  void _handleResendOTP() {
    // TODO: Implement resend OTP logic
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('OTP has been resent to your email'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    
    // Calculate responsive horizontal padding (45px on base 430px = ~10.5%)
    final horizontalPadding = Responsive.widthPercent(context, 10.5);

    return Scaffold(
      body: AppBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Container(
              width: screenWidth,
              constraints: BoxConstraints(
                minHeight: screenHeight - 
                    MediaQuery.of(context).padding.top - 
                    MediaQuery.of(context).padding.bottom,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Top spacing - MATCH LOGIN SCREEN
                  SizedBox(height: Responsive.spacing(context, 79)),
                  
                  // OTP Verification text - CENTERED
                  Text(
                    "OTP Verification",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: Responsive.fontSize(context, 30),
                      fontWeight: FontWeight.w600,
                      color: const Color.fromRGBO(255, 255, 255, 1.0),
                      letterSpacing: 0.5,
                    ),
                  ),
                  
                  // Spacing between title and subtitle - MATCH LOGIN SCREEN
                  SizedBox(height: Responsive.spacing(context, 8)),
                  
                  // Enter 4 digit code subtitle - CENTERED
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Responsive.widthPercent(context, 2),
                    ),
                    child: Text(
                      "Enter 4 digit code that has been sent on your email ${widget.email}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: Responsive.fontSize(context, 13),
                        color: const Color.fromRGBO(255, 255, 255, 0.9),
                        height: 1.4,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ),
                  
                  // Spacing to OTP fields - MATCH LOGIN SCREEN PATTERN
                  SizedBox(height: Responsive.spacing(context, 33)),
                  
                  // OTP Input Fields
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Responsive.spacing(context, 30),
                    ),
                    child: PinCodeTextField(
                      appContext: context,
                      length: 4,
                      controller: _otpController,
                      obscureText: false,
                      animationType: AnimationType.fade,
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(
                          Responsive.size(context, 10),
                        ),
                        fieldHeight: Responsive.size(context, 50),
                        fieldWidth: Responsive.size(context, 50),
                        activeFillColor: const Color.fromRGBO(255, 255, 255, 1.0),
                        inactiveFillColor: const Color.fromRGBO(255, 255, 255, 1.0),
                        selectedFillColor: const Color.fromRGBO(255, 255, 255, 1.0),
                        activeColor: const Color.fromRGBO(255, 255, 255, 1.0),
                        inactiveColor: const Color.fromRGBO(255, 255, 255, 1.0),
                        selectedColor: const Color.fromRGBO(19, 166, 222, 1.0),
                        borderWidth: 0,
                      ),
                      enableActiveFill: true,
                      keyboardType: TextInputType.number,
                      textStyle: TextStyle(
                        fontSize: Responsive.fontSize(context, 20),
                        fontWeight: FontWeight.w600,
                        color: const Color.fromRGBO(0, 0, 0, 1.0),
                      ),
                      onCompleted: (value) {
                        _handleContinue();
                      },
                      onChanged: (value) {
                        setState(() {});
                      },
                    ),
                  ),
                  
                  // Spacing to Resend OTP
                  SizedBox(height: Responsive.spacing(context, 10)),
                  
                  // Didn't receive? Resend OTP - CENTERED
                  GestureDetector(
                    onTap: _handleResendOTP,
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: "Didn't receive?",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: Responsive.fontSize(context, 12),
                          color: const Color.fromRGBO(255, 255, 255, 1.0),
                        ),
                        children: [
                          TextSpan(
                            text: " Resend OTP",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: Responsive.fontSize(context, 12),
                              color: const Color.fromRGBO(19, 166, 222, 1.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  // Spacing to Continue button - MATCH LOGIN SCREEN PATTERN
                  SizedBox(height: Responsive.spacing(context, 70)),
                  
                  // Continue button - CENTERED
                  SizedBox(
                    width: double.infinity,
                    child: InkWell(
                      onTap: _isLoading ? null : _handleContinue,
                      borderRadius: BorderRadius.circular(
                        Responsive.size(context, 10),
                      ),
                      child: Container(
                        width: double.infinity,
                        height: Responsive.size(context, 48),
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(19, 166, 222, 1.0),
                          borderRadius: BorderRadius.circular(
                            Responsive.size(context, 10),
                          ),
                        ),
                        padding: EdgeInsets.all(Responsive.spacing(context, 10)),
                        child: Center(
                          child: _isLoading
                              ? SizedBox(
                                  width: Responsive.size(context, 20),
                                  height: Responsive.size(context, 20),
                                  child: const CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Color.fromRGBO(255, 255, 255, 1.0),
                                    ),
                                  ),
                                )
                              : Text(
                                  "Continue",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: Responsive.fontSize(context, 15),
                                    color: const Color.fromRGBO(255, 255, 255, 1.0),
                                    letterSpacing: 0.5,
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ),
                  
                        // Spacing to Sign In - MATCH LOGIN SCREEN
                        SizedBox(height: Responsive.spacing(context, 320)),
                        
                        // Have an Account? Sign In - CENTERED (for registration flow)
                        // Don't have an Account? Create Account - CENTERED (for recovery flow)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              widget.isRegistration
                                  ? "Have an Account? "
                                  : "Don't have an Account? ",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: Responsive.fontSize(context, 12),
                                color: const Color.fromRGBO(255, 255, 255, 1.0),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                if (widget.isRegistration) {
                                  context.push(RouteNames.login);
                                } else {
                                  context.push(RouteNames.register);
                                }
                              },
                              child: Opacity(
                                opacity: 0.75,
                                child: Text(
                                  widget.isRegistration ? "Sign In" : "Create Account",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: Responsive.fontSize(context, 12),
                                    color: const Color.fromRGBO(19, 166, 222, 1.0),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                  
                  // Bottom spacing - MATCH LOGIN SCREEN
                  SizedBox(height: Responsive.heightPercent(context, 5)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
