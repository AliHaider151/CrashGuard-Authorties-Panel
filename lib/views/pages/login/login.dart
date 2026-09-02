import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fyp_emergency_services_pannel/constants/colors.dart';
import 'package:fyp_emergency_services_pannel/constants/cont.dart';
import 'package:fyp_emergency_services_pannel/providers/login.dart';
import 'package:fyp_emergency_services_pannel/utils/spacing.dart';
import 'package:fyp_emergency_services_pannel/views/widgets/custom_textfield.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: Center(
        child: Container(
          width: 400,
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.shade200, width: 1),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(appLogo, height: 50),
              25.height,
              CustomTextField(
                controller: loginProvider.emailCont,
                label: "Email Address",
              ),
              const SizedBox(height: 12),
              CustomTextField(
                controller: loginProvider.passCont,
                label: "Password",
                obscureText: true,
              ),
              // const SizedBox(height: 12),
              // CustomDropDown(
              //   items: UserRole.values.map((e) => e.name).toList(),
              //   onChanged: (val) {},
              // ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Transform.scale(
                    scale: .8,
                    child: Consumer<LoginProvider>(
                      builder: (context, provider, child) => Checkbox(
                        value: provider.isRememberMe,
                        onChanged: (_) {
                          provider.toggleRememberMe();
                        },
                        checkColor: Colors.white,
                        activeColor: AppColors.primary,
                      ),
                    ),
                  ),
                  Text(
                    "Remember me",
                    style: const TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                ],
              ),
              const SizedBox(height: 50),
              Consumer<LoginProvider>(
                builder: (context, provider, child) {
                  return _SocialButton(
                    label: "Login",
                    onTap: () => provider.login(context),
                    isLoading: provider.loginLoading,
                  );
                },
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () {},
                child: Text(
                  "Forgot Password?",
                  style: TextStyle(color: Colors.grey.shade400, fontSize: 14),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  const _SocialButton({
    required this.onTap,
    required this.label,
    this.isLoading = false,
  });

  final VoidCallback onTap;
  final String label;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 40,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Center(
          child: isLoading
              ? SpinKitFadingCircle(color: Colors.white, size: 35)
              : Text(
                  label,
                  style: textTheme.bodySmall!.copyWith(color: Colors.white),
                ),
        ),
      ),
    );
  }
}
