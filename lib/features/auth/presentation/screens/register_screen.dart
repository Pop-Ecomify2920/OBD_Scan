import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/routes/route_names.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../shared/widgets/app_background.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  bool _isLoading = false;
  bool _agreeToTerms = false;
  bool _hasValidated = false;

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _handleSignUp() async {
    setState(() => _hasValidated = true);
    if (_formKey.currentState!.validate() && _agreeToTerms) {
      setState(() => _isLoading = true);
      
      // TODO: Implement actual registration logic
      await Future.delayed(const Duration(seconds: 1));
      
      if (mounted) {
        setState(() => _isLoading = false);
        // Navigate to Verification screen after sign up
        context.push(RouteNames.verification);
      }
    } else if (!_agreeToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please agree to Terms & Conditions and Privacy Policy'),
          duration: Duration(seconds: 2),
        ),
      );
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
                  
                  // Register text - CENTERED
                  Text(
                    "Register",
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
                  
                  // Create your new account subtitle - CENTERED
                  Text(
                    "Create your new account",
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
                        // Full Name input field
                        _buildFullNameField(context),
                        
                        // Spacing to Email field - MATCH LOGIN SCREEN PATTERN
                        SizedBox(height: Responsive.spacing(context, 15)),
                        
                        // Email input field
                        _buildEmailField(context),
                        
                        // Spacing to Phone field - MATCH LOGIN SCREEN PATTERN
                        SizedBox(height: Responsive.spacing(context, 15)),
                        
                        // Phone Number input field
                        _buildPhoneField(context),
                        
                        // Spacing to Terms & Conditions
                        SizedBox(height: Responsive.spacing(context, 15)),
                        
                        // Terms & Conditions checkbox
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: Responsive.size(context, 20),
                              height: Responsive.size(context, 20),
                              child: Checkbox(
                                value: _agreeToTerms,
                                onChanged: (value) {
                                  setState(() {
                                    _agreeToTerms = value ?? false;
                                  });
                                },
                                activeColor: const Color.fromRGBO(19, 166, 222, 1.0),
                                checkColor: Colors.white,
                                side: const BorderSide(
                                  color: Color.fromRGBO(255, 255, 255, 1),
                                  width: 1.5,
                                ),
                                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(3),
                                ),
                              ),
                            ),
                            SizedBox(width: Responsive.spacing(context, 8)),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  // TODO: Navigate to Terms & Conditions
                                },
                                child: RichText(
                                  text: TextSpan(
                                    text: "By signing up you agree to our",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: Responsive.fontSize(context, 12),
                                      color: const Color.fromRGBO(255, 255, 255, 1.0),
                                    ),
                                    children: [
                                      TextSpan(
                                        text: " Terms & Conditions",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: Responsive.fontSize(context, 12),
                                          color: const Color.fromRGBO(19, 166, 222, 1.0),
                                        ),
                                      ),
                                      const TextSpan(
                                        text: " and ",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12,
                                          color: Color.fromRGBO(255, 255, 255, 1.0),
                                        ),
                                      ),
                                      TextSpan(
                                        text: "Privacy Policy.",
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
                            ),
                          ],
                        ),
                        
                        // Spacing to Sign Up button - MATCH LOGIN SCREEN PATTERN
                        SizedBox(height: Responsive.spacing(context, 35)),
                        
                        // Sign Up button - CENTERED
                        SizedBox(
                          width: double.infinity,
                          child: InkWell(
                            onTap: _isLoading ? null : _handleSignUp,
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
                                        "Sign Up",
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
                        
                        // Spacing to OR divider - MATCH LOGIN SCREEN PATTERN
                        SizedBox(height: Responsive.spacing(context, 30)),
                        
                        // OR divider - CENTERED
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                color: const Color.fromRGBO(19, 166, 222, 1.0),
                                height: 1,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: Responsive.spacing(context, 20),
                              ),
                              child: Text(
                                "OR",
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: Responsive.fontSize(context, 11),
                                  color: const Color.fromRGBO(255, 255, 255, 1.0),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                color: const Color.fromRGBO(19, 166, 222, 1.0),
                                height: 1,
                              ),
                            ),
                          ],
                        ),
                        
                        // Spacing to social login buttons - MATCH LOGIN SCREEN PATTERN
                        SizedBox(height: Responsive.spacing(context, 30)),
                        
                        // Social login buttons - CENTERED
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Google button
                            _SocialLoginButton(
                              imagePath: 'assets/images/flat-color-icons_google.png',
                              onTap: () {
                                // TODO: Implement Google sign in
                              },
                              size: Responsive.size(context, 33),
                            ),
                            SizedBox(width: Responsive.spacing(context, 27)),
                            // Facebook button
                            _SocialLoginButton(
                              imagePath: 'assets/images/flat-color-icons_facebook.png',
                              onTap: () {
                                // TODO: Implement Facebook sign in
                              },
                              size: Responsive.size(context, 31),
                            ),
                            SizedBox(width: Responsive.spacing(context, 27)),
                            // Apple button
                            _SocialLoginButton(
                              icon: Icons.apple,
                              iconColor: Colors.white,
                              onTap: () {
                                // TODO: Implement Apple sign in
                              },
                              size: Responsive.size(context, 33),
                            ),
                          ],
                        ),
                        
                        // Spacing to Sign In - MATCH LOGIN SCREEN
                        SizedBox(height: Responsive.spacing(context, 60)),
                        
                        // Have an Account? Sign In - CENTERED
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Have an Account? ",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: Responsive.fontSize(context, 12),
                                color: const Color.fromRGBO(255, 255, 255, 1.0),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                context.push(RouteNames.login);
                              },
                              child: Opacity(
                                opacity: 0.75,
                                child: Text(
                                  "Sign In",
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

  Widget _buildFullNameField(BuildContext context) {
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
              "Full Name",
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
            child: Align(
              alignment: Alignment.centerLeft,
              child: TextFormField(
                controller: _fullNameController,
                textAlignVertical: TextAlignVertical.center,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: Responsive.fontSize(context, 11),
                  color: const Color.fromRGBO(255, 255, 255, 1.0),
                  height: 1.0, // Ensure consistent line height
                ),
                keyboardType: TextInputType.name,
                validator: Validators.validateName,
                decoration: InputDecoration(
                  hintText: "Abcxyz",
                  hintStyle: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: Responsive.fontSize(context, 10),
                    color: const Color.fromARGB(221, 255, 254, 254),
                    height: 1.0, // Ensure consistent line height
                  ),
                  filled: false,
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  focusedErrorBorder: InputBorder.none,
                  errorText: null, // Prevent default error display
                  errorStyle: const TextStyle(height: 0, fontSize: 0), // Hide error text completely
                  contentPadding: EdgeInsets.symmetric(
                    vertical: Responsive.size(context, 46) / 2.2 - Responsive.fontSize(context, 11) / 2,
                  ),
                  isDense: false, // Allow proper centering
                ),
              ),
            ),
          ),
          // Reserved space for error message (always present to prevent layout shift)
          SizedBox(
            height: Responsive.spacing(context, 20),
            child: _hasValidated
                ? (_fullNameController.text.isEmpty
                    ? Padding(
                        padding: EdgeInsets.only(
                          top: Responsive.spacing(context, 4),
                             left: Responsive.spacing(context, 5),
                        ),
                        child: Text(
                          'Name is required',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: Responsive.fontSize(context, 11),
                            color: const Color.fromRGBO(255, 0, 0, 1.0),
                          ),
                        ),
                      )
                    : (_fullNameController.text.length < 2 && _fullNameController.text.isNotEmpty
                        ? Padding(
                            padding: EdgeInsets.only(
                              top: Responsive.spacing(context, 4),
                            ),
                            child: Text(
                              'Name must be at least 2 characters',
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: Responsive.fontSize(context, 11),
                                color: const Color.fromRGBO(255, 0, 0, 1.0),
                              ),
                            ),
                          )
                        : const SizedBox.shrink()))
                : const SizedBox.shrink(),
          ),
        ],
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
              "Enter Email",
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
            child: Align(
              alignment: Alignment.centerLeft,
              child: TextFormField(
                controller: _emailController,
                textAlignVertical: TextAlignVertical.center,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: Responsive.fontSize(context, 11),
                  color: const Color.fromRGBO(255, 255, 255, 1.0),
                  height: 1.0, // Ensure consistent line height
                ),
                keyboardType: TextInputType.emailAddress,
                validator: Validators.validateEmail,
                decoration: InputDecoration(
                  hintText: "example@gmail.com",
                  hintStyle: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: Responsive.fontSize(context, 10),
                    color: const Color.fromARGB(221, 255, 254, 254),
                    height: 1.0, // Ensure consistent line height
                  ),
                  filled: false,
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  focusedErrorBorder: InputBorder.none,
                  errorText: null, // Prevent default error display
                  errorStyle: const TextStyle(height: 0, fontSize: 0), // Hide error text completely
                  contentPadding: EdgeInsets.symmetric(
                    vertical: Responsive.size(context, 46) / 2.2 - Responsive.fontSize(context, 11) / 2,
                  ),
                  isDense: false, // Allow proper centering
                ),
              ),
            ),
          ),
          // Reserved space for error message (always present to prevent layout shift)
          SizedBox(
            height: Responsive.spacing(context, 20),
            child: _hasValidated && _emailController.text.isEmpty
                ? Padding(
                    padding: EdgeInsets.only(
                      top: Responsive.spacing(context, 7),
                         left: Responsive.spacing(context, 5),
                    ),
                    child: Text(
                      'Email is required',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: Responsive.fontSize(context, 11),
                        color: const Color.fromRGBO(255, 0, 0, 1.0),
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  Widget _buildPhoneField(BuildContext context) {
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
              "Enter Phone Number",
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
            child: Align(
              alignment: Alignment.centerLeft,
              child: TextFormField(
                controller: _phoneController,
                textAlignVertical: TextAlignVertical.center,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: Responsive.fontSize(context, 11),
                  color: const Color.fromRGBO(255, 255, 255, 1.0),
                  height: 1.0, // Ensure consistent line height
                ),
                keyboardType: TextInputType.phone,
                validator: Validators.validatePhone,
                decoration: InputDecoration(
                  hintText: "+1234567890",
                  hintStyle: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: Responsive.fontSize(context, 10),
                    color: const Color.fromARGB(221, 255, 254, 254),
                    height: 1.0, // Ensure consistent line height
                  ),
                  filled: false,
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  focusedErrorBorder: InputBorder.none,
                  errorText: null, // Prevent default error display
                  errorStyle: const TextStyle(height: 0, fontSize: 0), // Hide error text completely
                  contentPadding: EdgeInsets.symmetric(
                    vertical: Responsive.size(context, 46) / 2.3 - Responsive.fontSize(context, 11) / 2,
                  ),
                  isDense: false, // Allow proper centering
                ),
              ),
            ),
          ),
          // Reserved space for error message (always present to prevent layout shift)
          SizedBox(
            height: Responsive.spacing(context, 20),
            child: _hasValidated
                ? (_phoneController.text.isEmpty
                    ? Padding(
                        padding: EdgeInsets.only(
                          top: Responsive.spacing(context, 4),
                                 left: Responsive.spacing(context, 5),

                        ),
                        child: Text(
                          'Phone number is required',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: Responsive.fontSize(context, 11),
                            color: const Color.fromRGBO(255, 0, 0, 1.0),
                          ),
                        ),
                      )
                    : (_phoneController.text.length < 10 && _phoneController.text.isNotEmpty
                        ? Padding(
                            padding: EdgeInsets.only(
                              top: Responsive.spacing(context, 4),
                                 left: Responsive.spacing(context, 5),

                            ),
                            child: Text(
                              'Please enter a valid phone number',
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: Responsive.fontSize(context, 11),
                                color: const Color.fromRGBO(255, 0, 0, 1.0),
                              ),
                            ),
                          )
                        : const SizedBox.shrink()))
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}

// Social Login Button Widget (same as login screen)
class _SocialLoginButton extends StatelessWidget {
  final IconData? icon;
  final Color? iconColor;
  final String? imagePath;
  final VoidCallback onTap;
  final double size;

  const _SocialLoginButton({
    this.icon,
    this.iconColor,
    this.imagePath,
    required this.onTap,
    required this.size,
  }) : assert(
          (icon != null && iconColor != null) || imagePath != null,
          'Either icon/iconColor or imagePath must be provided',
        );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          // color: const Color.fromRGBO(30, 30, 30, 1.0),
          // shape: BoxShape.circle,
        ),
        child: imagePath != null
            ? ClipOval(
                child: Image.asset(
                  imagePath!,
                  // width: size,
                  // height: size,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    // Fallback to icon if image fails to load
                    return Container(
                      width: size,
                      height: size,
                      decoration: const BoxDecoration(
                        color: Color.fromRGBO(30, 30, 30, 1.0),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.error_outline,
                        color: Colors.white,
                        size: size * 1,
                      ),
                    );
                  },
                ),
              )
            : Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(30, 30, 30, 1.0),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: iconColor,
                  size: size * 1,
                ),
              ),
      ),
    );
  }
}
