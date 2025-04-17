import 'package:capp_box/feature/create_capsul/widgets/back_button_widget.dart';
import 'package:capp_box/feature/create_capsul/widgets/page_title.dart'
    show PageTitle;
import 'package:capp_box/product/widgets/background_gradient.dart';
import 'package:flutter/material.dart';

class HelpView extends StatefulWidget {
  const HelpView({super.key});

  @override
  State<HelpView> createState() => _HelpViewState();
}

class _HelpViewState extends State<HelpView> {
  final List<Map<String, String>> helpItems = [
    {
      'title': 'Capp Box nedir?',
      'description':
          'Capp Box, dijital kapsüller oluşturmanıza ve bunları sevdiklerinizle paylaşmanıza olanak tanıyan yenilikçi bir uygulamadır. Fotoğraflar, videolar, mesajlar ve daha fazlasını içeren özel kapsüller oluşturabilir, bunları belirlediğiniz tarihte açılacak şekilde ayarlayabilirsiniz.'
    },
    {
      'title': 'Capp Box nasıl çalışır?',
      'description':
          '1. Yeni bir kapsül oluşturun\n2. İçeriğinizi ekleyin (fotoğraf, video, mesaj)\n3. Açılma tarihini belirleyin\n4. Alıcıları seçin\n5. Kapsülünüz hazır! Belirlenen tarihte alıcılar kapsülünüzü görebilecek.'
    },
    {
      'title': 'İletişim',
      'description':
          'Bize ulaşmak için:\n\nE-posta: support@cappbox.com\nTelefon: +90 555 123 4567\nAdres: İstanbul, Türkiye\n\nÇalışma saatleri: Hafta içi 09:00 - 18:00'
    },
    {
      'title': 'Gizlilik Politikası',
      'description':
          'Capp Box olarak gizliliğinize önem veriyoruz. Kişisel verileriniz 6698 sayılı KVKK kapsamında korunmaktadır. Verileriniz sadece hizmet kalitemizi artırmak ve size daha iyi deneyim sunmak için kullanılmaktadır. Detaylı bilgi için gizlilik politikamızı inceleyebilirsiniz.'
    },
    {
      'title': 'Hesap',
      'description':
          'Hesabınızı yönetmek için:\n\n1. Profilim\n2. Ayarlar\n3. Çıkış Yap'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BackgroundGradient(),
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Stack(
                      alignment: Alignment.center,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: BackButtonWidget(),
                        ),
                        PageTitle(title: 'Yardım'),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24),
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: helpItems.length,
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 10,
                        ),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Container(
                              decoration: ShapeDecoration(
                                color: const Color(0xFF24223D),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                              ),
                              child: Theme(
                                data: Theme.of(context).copyWith(
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                ),
                                child: ExpansionTile(
                                  initiallyExpanded: false,
                                  maintainState: true,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  collapsedShape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  title: Text(
                                    helpItems[index]['title']!,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontFamily: 'Urbanist',
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.all(16),
                                      decoration: ShapeDecoration(
                                        color: const Color(0xFF24223D)
                                            .withOpacity(0.5),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                      ),
                                      child: Text(
                                        helpItems[index]['description']!,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontFamily: 'Urbanist',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
