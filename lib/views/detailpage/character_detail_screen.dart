import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:harrypotterapp/models/character_model.dart';
import 'package:harrypotterapp/core/theme/appcolors.dart';

class CharacterDetailPage extends StatelessWidget {
  final CharacterModel character;

  // Karakter verisini alıp, bu sayfaya aktarmak için constructor
  const CharacterDetailPage({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor, // Arka plan rengini belirliyoruz
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text(
          character.name ?? 'Character Details', // Eğer karakterin adı varsa gösteriyoruz, yoksa 'Character Details' yazıyoruz
          style: GoogleFonts.poppins(color: AppColors.whiteColor),
        ),
        centerTitle: true,
        elevation: 0,
        // Geri butonunun rengini beyaz yapıyoruz
        iconTheme: IconThemeData(color: AppColors.whiteColor),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Genel padding ekliyoruz
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Sol tarafa hizalıyoruz
          children: [
            // Karakterin resmini gösterecek container
            Container(
              width: double.infinity,
              height: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15), // Resmin köşelerini yuvarlıyoruz
                color: AppColors.greyLightColor,
                image: DecorationImage(
                  image: character.image != null && character.image!.isNotEmpty
                      ? NetworkImage(character.image!) // Eğer karakterin resmi varsa, onu yükle
                      : AssetImage('assets/images/default_image.png') as ImageProvider, // Yoksa varsayılan bir resim göster
                  fit: BoxFit.cover,
                ),
              ),
              child: character.image == null || character.image!.isEmpty
                  ? Center(
                      child: Text(
                        '?', // Eğer resim yoksa '?' gösteriyoruz
                        style: TextStyle(
                          fontSize: 100,
                          color: AppColors.greyTextColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  : null,
            ),
            SizedBox(height: 20), // Resim ile bilgi arasına boşluk ekliyoruz
            
            // Karakterin bilgilerini içeren container
            Container(
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(15), // Köşeleri yuvarlıyoruz
                boxShadow: [
                  BoxShadow(
                    color: AppColors.greyLightColor,
                    blurRadius: 10, // Gölgeyi biraz yumuşatıyoruz
                    offset: Offset(0, 4), // Gölgeyi hafif aşağıya kaydırıyoruz
                  ),
                ],
              ),
              padding: const EdgeInsets.all(16.0), // İçeriğe padding ekliyoruz
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, // Sol tarafa hizalıyoruz
                children: [
                  // İsim kısmı ve ikon
                  _buildInfoRow(
                    'Name',
                    character.name ?? "Unknown", // Karakterin adı, yoksa 'Unknown' yazıyoruz
                    FontAwesomeIcons.person, // İkon olarak kişi ikonunu kullanıyoruz
                    AppColors.primaryColor, // Rengi belirliyoruz
                  ),
                  SizedBox(height: 10),
                  // Tür kısmı ve ikon
                  _buildInfoRow(
                    'Species',
                    character.species ?? "Unknown", // Tür, yoksa 'Unknown' yazıyoruz
                    FontAwesomeIcons.leaf, // İkon olarak yaprak ikonunu kullanıyoruz
                    AppColors.blueColor, // Rengi belirliyoruz
                  ),
                  SizedBox(height: 10),
                  // Cinsiyet kısmı ve ikon
                  _buildInfoRow(
                    'Gender',
                    character.gender ?? "Unknown", // Cinsiyet, yoksa 'Unknown' yazıyoruz
                    FontAwesomeIcons.genderless, // İkon olarak cinsiyet ikonunu kullanıyoruz
                    AppColors.lightBlueColor, // Rengi belirliyoruz
                  ),
                  SizedBox(height: 10),
                  // Ev kısmı ve ikon
                  _buildInfoRow(
                    'House',
                    character.house ?? "Unknown", // Ev, yoksa 'Unknown' yazıyoruz
                    FontAwesomeIcons.home, // İkon olarak ev ikonunu kullanıyoruz
                    AppColors.primaryLightColor, // Rengi belirliyoruz
                  ),
                  SizedBox(height: 10),
                  // Doğum tarihi kısmı ve ikon
                  _buildInfoRow(
                    'Date of Birth',
                    character.dateOfBirth ?? "Unknown", // Doğum tarihi, yoksa 'Unknown' yazıyoruz
                    FontAwesomeIcons.atlassian, // İkon olarak takvim ikonunu kullanıyoruz
                    AppColors.blueColor, // Rengi belirliyoruz
                  ),
                  SizedBox(height: 10),
                  // Soy ağacı kısmı ve ikon
                  _buildInfoRow(
                    'Ancestry',
                    character.ancestry ?? "Unknown", // Soy ağacı, yoksa 'Unknown' yazıyoruz
                    FontAwesomeIcons.calendar, // İkon olarak takvim ikonunu kullanıyoruz
                    AppColors.primaryColor, // Rengi belirliyoruz
                  ),
                  SizedBox(height: 10),
                  // Patronus kısmı ve ikon
                  _buildInfoRow(
                    'Patronus',
                    character.patronus ?? "Unknown", // Patronus, yoksa 'Unknown' yazıyoruz
                    FontAwesomeIcons.unlock, // İkon olarak anahtar ikonunu kullanıyoruz
                    AppColors.lightBlueColor, // Rengi belirliyoruz
                  ),
                  SizedBox(height: 10),
                  // Hayatta olup olmadığı kısmı ve ikon
                  _buildInfoRow(
                    'Alive',
                    character.alive == true ? "Yes" : "No", // Eğer hayatta ise 'Yes', değilse 'No' yazıyoruz
                    FontAwesomeIcons.a, // İkon olarak A harfini kullanıyoruz
                    character.alive == true ? Colors.green : Colors.red, // Hayatta ise yeşil, değilse kırmızı renkte gösteriyoruz
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Karakterin bilgilerini satır satır göstermek için yardımcı fonksiyon
  Widget _buildInfoRow(String title, String value, IconData icon, Color iconColor) {
    return Row(
      children: [
        Icon(icon, color: iconColor, size: 24), // İkonu burada ekliyoruz
        SizedBox(width: 10), // İkon ile metin arasına boşluk koyuyoruz
        Text(
          '$title: $value', // Başlık ve değeri birleştirip metni gösteriyoruz
          style: GoogleFonts.poppins(fontSize: 16, color: AppColors.blackTextColor),
        ),
      ],
    );
  }
}
