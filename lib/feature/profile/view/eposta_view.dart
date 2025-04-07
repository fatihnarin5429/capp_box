import 'package:capp_box/feature/package/widgets/custom_text_field.dart';
import 'package:capp_box/feature/profile/bloc/profile_bloc.dart';
import 'package:capp_box/feature/profile/view/email_otp_view.dart';
import 'package:capp_box/product/widgets/background_gradient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EpostaView extends StatefulWidget {
  const EpostaView({super.key});

  @override
  State<EpostaView> createState() => _EpostaViewState();
}

class _EpostaViewState extends State<EpostaView> {
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        const BackgroundGradient(),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: Column(
              children: [
                _buildHeader(context),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Text(
                      'E-Posta Adresi',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: 'Urbanist',
                        fontWeight: FontWeight.w500,
                        height: 1.40,
                      ),
                    ),
                  ),
                ),
                CustomTextField(
                  controller: _emailController,
                  hintText: "E-posta adresiniz",
                  onChanged: (value) {},
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 24),
                      child: _buildEditButton(context),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ));
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/icons/ellipse.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: const Center(
              child: Padding(
                padding: EdgeInsets.only(left: 8),
                child:
                    Icon(Icons.arrow_back_ios, color: Colors.white, size: 18),
              ),
            ),
          ),
        ),
        const Expanded(
          child: Padding(
            padding: EdgeInsets.only(right: 40),
            child: Text(
              'E-Posta',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'Urbanist',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEditButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EmailOtpView(email: _emailController.text),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          padding: EdgeInsets.zero,
        ),
        child: Ink(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment(1.00, 0.00),
              end: Alignment(-1, 0),
              colors: [Color(0xFFB224EF), Color(0xFF7579FF)],
            ),
            borderRadius: BorderRadius.circular(100),
          ),
          child: const Center(
            child: Text(
              'Düzenle',
              style: TextStyle(
                color: Color(0xFFE5E5E5),
                fontSize: 14,
                fontFamily: 'Urbanist',
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
