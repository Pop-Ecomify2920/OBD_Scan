import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/routes/route_names.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../shared/widgets/app_background.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _rememberMe = false;
  bool _isLoading = false;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      
      // TODO: Implement actual login logic
      await Future.delayed(const Duration(seconds: 1));
      
      if (mounted) {
        setState(() => _isLoading = false);
        context.go(RouteNames.home);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    
    // Calculate responsive horizontal padding
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
                  // Top spacing
                  SizedBox(height: Responsive.spacing(context, 79)),
                  
                  // Welcome back text - CENTERED
                  Text(
                    "Welcome back",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: Responsive.fontSize(context, 30),
                      fontFamily: 'Poppins.semibold',
                      fontWeight: FontWeight.w600,
                      color: const Color.fromRGBO(255, 255, 255, 1.0),
                      letterSpacing: 0.5,
                    ),
                  ),
                  
                  // Spacing between welcome and subtitle
                  SizedBox(height: Responsive.spacing(context, 8)),
                  
                  // Login to your account subtitle - CENTERED
                  Text(
                    "Login to your account",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: Responsive.fontSize(context, 13),
                      color: const Color.fromRGBO(255, 255, 255, 0.9),
                      letterSpacing: 0.3,
                    ),
                  ),
                  
                  // Spacing to first input field
                  SizedBox(height: Responsive.spacing(context, 33)),
                  
                  // Form
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Email/Phone input field
                        _buildEmailField(context),
                        
                        // Spacing to password field
                        SizedBox(height: Responsive.spacing(context, 15)),
                        
                        // Password input field
                        _buildPasswordField(context),
                        
                        // Spacing to remember me
                        SizedBox(height: Responsive.spacing(context, 15)),
                        
                        // Remember me and Forgot password row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Remember me checkbox
                            Row(
                              children: [
                                // Checkbox
                                SizedBox(
                                  width: Responsive.size(context, 20),
                                  height: Responsive.size(context, 20),
                                  child: Checkbox(
                                    value: _rememberMe,
                                    onChanged: (value) {
                                      setState(() {
                                        _rememberMe = value ?? false;
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
                                Text(
                                  "Remember me",
                                  style: TextStyle(
                                    fontSize: Responsive.fontSize(context, 10),
                                    fontWeight: FontWeight.w500,
                                    color: const Color.fromRGBO(255, 255, 255, 1.0),
                                  ),
                                ),
                              ],
                            ),
                            // Forgot Password link
                            TextButton(
                              onPressed: () {
                                context.push(RouteNames.recoverAccount);
                              },
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize: Size.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              child: Text(
                                "Forgot Password?",
                                style: TextStyle(
                                  fontSize: Responsive.fontSize(context, 11),
                                  fontWeight: FontWeight.w500,
                                  color: const Color.fromRGBO(19, 166, 222, 1.0),
                                ),
                              ),
                            ),
                          ],
                        ),
                        
                        // Spacing to Sign In button
                        SizedBox(height: Responsive.spacing(context, 43)),
                        
                        // Sign In button - CENTERED
                        SizedBox(
                          width: double.infinity,
                          child: InkWell(
                            onTap: _isLoading ? null : _handleLogin,
                            borderRadius: BorderRadius.circular(
                              Responsive.size(context, 10),
                            ),
                            child: Container(
                              width: double.infinity,
                              height: Responsive.size(context, 45),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: const Color.fromRGBO(19, 166, 222, 1.0),
                                  width: 1,
                                ),
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
                                        "Sign In",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: Responsive.fontSize(context, 16),
                                          color: const Color.fromRGBO(255, 255, 255, 1.0),
                                          letterSpacing: 0.5,
                                        ),
                                      ),
                              ),
                            ),
                          ),
                        ),
                        
                        // Spacing to OR divider
                        SizedBox(height: Responsive.spacing(context, 27)),
                        
                        // OR divider - CENTERED
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Left line
                            Container(
                              width: Responsive.size(context, 132),
                              height: 1,
                              color: const Color.fromRGBO(19, 166, 222, 1.0),
                            ),
                            // OR text
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: Responsive.spacing(context, 12),
                              ),
                              child: Text(
                                "OR",
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: Responsive.fontSize(context, 11),
                                  color: const Color.fromRGBO(255, 255, 255, 1.0),
                                  letterSpacing: 1.0,
                                ),
                              ),
                            ),
                            // Right line
                            Container(
                              width: Responsive.size(context, 132),
                              height: 1,
                              color: const Color.fromRGBO(19, 166, 222, 1.0),
                            ),
                          ],
                        ),
                        
                        // Spacing to social buttons
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
                              size: Responsive.size(context, 40),
                            ),
                          ],
                        ),
                        
                        // Spacing to Create Account
                        SizedBox(height: Responsive.spacing(context, 145)),
                        
                        // Don't have an Account? Create Account - CENTERED
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an Account? ",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: Responsive.fontSize(context, 12),
                                color: const Color.fromRGBO(255, 255, 255, 1.0),
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
                                    fontSize: Responsive.fontSize(context, 12),
                                    color: const Color.fromRGBO(19, 166, 222, 1.0),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        
                        // Bottom spacing
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

  Widget _buildEmailField(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        // border: Border.all(
        //   color: const Color.fromRGBO(19, 166, 222, 1.0),
        //   width: 1,
        // ),
        borderRadius: BorderRadius.circular(
          Responsive.size(context, 10),
        ),
      ),
      // padding: EdgeInsets.all(Responsive.spacing(context, 12)),
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
                fontSize: Responsive.fontSize(context, 14),
                color: const Color.fromRGBO(255, 255, 255, 1.0),
              ),
            ),
          ),
          // Input field
          Container(
            width: double.infinity,
            height: Responsive.size(context, 45),
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
                // isDense: true,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordField(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        // border: Border.all(
        //   color: const Color.fromRGBO(19, 166, 222, 1.0),
        //   width: 1,
        // ),
        borderRadius: BorderRadius.circular(
          Responsive.size(context, 10),
        ),
      ),
      // padding: EdgeInsets.all(Responsive.spacing(context, 12)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
            height: Responsive.size(context, 45),
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
                      hintText: "******",
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
}

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
            : Icon(
                icon,
                color: iconColor,
                size: size * 1,
              ),
      ),
    );
  }
}
