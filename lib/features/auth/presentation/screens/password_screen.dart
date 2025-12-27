import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/routes/route_names.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../shared/widgets/app_background.dart';

class PasswordScreen extends StatefulWidget {
  final String email;
  final bool isRegistration;
  
  const PasswordScreen({
    super.key,
    required this.email,
    required this.isRegistration,
  });

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleCreateAccount() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      
      // TODO: Implement actual account creation logic
      await Future.delayed(const Duration(seconds: 1));
      
      if (mounted) {
        setState(() => _isLoading = false);
        // Navigate to login screen after successful registration
        context.go(RouteNames.login);
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
                  
                  // Password text - CENTERED
                  Text(
                    "Password",
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
                  
                  // Please set your password subtitle - CENTERED
                  Text(
                    "Please set your password",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: Responsive.fontSize(context, 13),
                      color: const Color.fromRGBO(255, 255, 255, 0.9),
                      letterSpacing: 0.3,
                    ),
                  ),
                  
                  // Spacing to first input field - MATCH LOGIN SCREEN
                  SizedBox(height: Responsive.spacing(context, 33)),
                  
                  // Form
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Enter Password input field
                        _buildPasswordField(context),
                        
                        // Spacing to Confirm Password field - MATCH LOGIN SCREEN PATTERN
                        SizedBox(height: Responsive.spacing(context, 15)),
                        
                        // Confirm Password input field
                        _buildConfirmPasswordField(context),
                        
                        // Spacing to Create Account button - MATCH LOGIN SCREEN PATTERN
                        SizedBox(height: Responsive.spacing(context, 80)),
                        
                        // Create Account button - CENTERED
                        SizedBox(
                          width: double.infinity,
                          child: InkWell(
                            onTap: _isLoading ? null : _handleCreateAccount,
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
                                        "Create Account",
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
                        SizedBox(height: Responsive.spacing(context, 255)),
                        
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField(BuildContext context) {
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
              "Enter Password",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: Responsive.fontSize(context, 13),
                color: const Color.fromRGBO(255, 255, 255, 1.0),
              ),
            ),
          ),
          // Input field with eye icon
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    textAlignVertical: TextAlignVertical.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: Responsive.fontSize(context, 11),
                      color: const Color.fromRGBO(255, 255, 255, 1.0),
                    ),
                    validator: Validators.validatePassword,
                    decoration: InputDecoration(
                      hintText: "********",
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: Responsive.fontSize(context, 10),
                        color: const Color.fromARGB(190, 255, 255, 255),
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
                      isDense: true,
                    ),
                  ),
                ),
                // Eye icon
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                  child: Container(
                    width: Responsive.size(context, 24),
                    height: Responsive.size(context, 24),
                    alignment: Alignment.center,
                    child: Icon(
                      _obscurePassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: const Color.fromRGBO(255, 255, 255, 0.7),
                      size: Responsive.size(context, 20),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConfirmPasswordField(BuildContext context) {
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
              "Confirm Password",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: Responsive.fontSize(context, 13),
                color: const Color.fromRGBO(255, 255, 255, 1.0),
              ),
            ),
          ),
          // Input field with eye icon
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _confirmPasswordController,
                    obscureText: _obscureConfirmPassword,
                    textAlignVertical: TextAlignVertical.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: Responsive.fontSize(context, 11),
                      color: const Color.fromRGBO(255, 255, 255, 1.0),
                    ),
                    validator: (value) => Validators.validateConfirmPassword(
                      _passwordController.text,
                      value,
                    ),
                    decoration: InputDecoration(
                      hintText: "********",
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: Responsive.fontSize(context, 10),
                        color: const Color.fromARGB(190, 255, 255, 255),
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
                      isDense: true,
                    ),
                  ),
                ),
                // Eye icon
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _obscureConfirmPassword = !_obscureConfirmPassword;
                    });
                  },
                  child: Container(
                    width: Responsive.size(context, 24),
                    height: Responsive.size(context, 24),
                    alignment: Alignment.center,
                    child: Icon(
                      _obscureConfirmPassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: const Color.fromRGBO(255, 255, 255, 0.7),
                      size: Responsive.size(context, 20),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
