import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/routes/route_names.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../shared/widgets/app_background.dart';

class RecoverAccountScreen extends StatefulWidget {
  const RecoverAccountScreen({super.key});

  @override
  State<RecoverAccountScreen> createState() => _RecoverAccountScreenState();
}

class _RecoverAccountScreenState extends State<RecoverAccountScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _handleContinue() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      // TODO: Implement actual recovery logic
      await Future.delayed(const Duration(seconds: 1));

      if (mounted) {
        setState(() => _isLoading = false);
        // Navigate to OTP verification screen
        context.push(
          '${RouteNames.otpVerification}?email=${Uri.encodeComponent(_emailController.text)}&isRegistration=false',
        );
      }
    }
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
          child: Stack(
            children: [
              // Back button
              // Positioned(
              //   top: Responsive.spacing(context, 10),
              //   left: Responsive.spacing(context, 20),
              //   child: IconButton(
              //     icon: const Icon(
              //       Icons.arrow_back,
              //       color: Color.fromRGBO(255, 255, 255, 1.0),
              //     ),
              //     onPressed: () {
              //       context.pop();
              //     },
              //   ),
              // ),
              SingleChildScrollView(
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

                      // Recover account text - CENTERED
                      Text(
                        "Recover account",
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

                      // Enter your email for recovering the account subtitle - CENTERED
                      Text(
                        "Enter your email for recovering\nthe account",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: Responsive.fontSize(context, 13),
                          color: const Color.fromRGBO(255, 255, 255, 0.9),
                          height: 1.4,
                          letterSpacing: 0.3,
                        ),
                      ),

                      // Spacing to input field - MATCH LOGIN SCREEN
                      SizedBox(height: Responsive.spacing(context, 33)),

                        // Form
                        Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Email/Phone input field
                              _buildEmailField(context),

                              // Spacing to Continue button - MATCH LOGIN SCREEN SPACING PATTERN
                              SizedBox(height: Responsive.spacing(context, 100)),

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
                                      color: const Color.fromRGBO(
                                          19, 166, 222, 1.0),
                                      borderRadius: BorderRadius.circular(
                                        Responsive.size(context, 10),
                                      ),
                                    ),
                                    padding: EdgeInsets.all(
                                        Responsive.spacing(context, 10)),
                                    child: Center(
                                      child: _isLoading
                                          ? SizedBox(
                                              width:
                                                  Responsive.size(context, 20),
                                              height:
                                                  Responsive.size(context, 20),
                                              child:
                                                  const CircularProgressIndicator(
                                                strokeWidth: 2,
                                                valueColor:
                                                    AlwaysStoppedAnimation<
                                                        Color>(
                                                  Color.fromRGBO(
                                                      255, 255, 255, 1.0),
                                                ),
                                              ),
                                            )
                                          : Text(
                                              "Continue",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: Responsive.fontSize(
                                                    context, 15),
                                                color: const Color.fromRGBO(
                                                    255, 255, 255, 1.0),
                                                letterSpacing: 0.5,
                                              ),
                                            ),
                                    ),
                                  ),
                                ),
                              ),

                              // Spacing to Create Account - MATCH LOGIN SCREEN
                              SizedBox(height: Responsive.spacing(context, 305)),

                              // Don't have an Account? Create Account - CENTERED
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Don't have an Account? ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize:
                                          Responsive.fontSize(context, 12),
                                      color: const Color.fromRGBO(
                                          255, 255, 255, 1.0),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      context.push(RouteNames.register);
                                    },
                                    child: Opacity(
                                      opacity: 0.75,
                                      child: Text(
                                        "Create Account",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize:
                                              Responsive.fontSize(context, 12),
                                          color: const Color.fromRGBO(
                                              19, 166, 222, 1.0),
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
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmailField(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          Responsive.size(context, 10),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Label
          Padding(
            padding: EdgeInsets.only(
              bottom: Responsive.spacing(context, 9),
            ),
            child: Text(
              "Enter email or phone",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: Responsive.fontSize(context, 13),
                color: const Color.fromRGBO(255, 255, 255, 1.0),
              ),
            ),
          ),
          // Input field
          Container(
            width: double.infinity,
            height: Responsive.size(context, 46),
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color.fromRGBO(255, 255, 255, 1.0),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(
                Responsive.size(context, 10),
              ),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: Responsive.spacing(context, 20),
            ),
            child: TextFormField(
              controller: _emailController,
              textAlignVertical: TextAlignVertical.center,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: Responsive.fontSize(context, 11),
                color: const Color.fromRGBO(255, 255, 255, 1.0),
              ),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return AppStrings.emailRequired;
                }
                return null;
              },
              decoration: InputDecoration(
                hintText: "example@gmail.com",
                hintStyle: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: Responsive.fontSize(context, 10),
                  color: const Color.fromARGB(221, 255, 254, 254),
                ),
                filled: false,
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  vertical: Responsive.spacing(context, 15),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
