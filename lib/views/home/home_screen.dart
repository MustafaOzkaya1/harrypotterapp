import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:harrypotterapp/core/theme/appcolors.dart';
import 'package:harrypotterapp/models/character_model.dart';
import 'package:harrypotterapp/core/services/service.dart';
import 'package:harrypotterapp/views/detailpage/character_detail_screen.dart';

// Karakterleri çekmek için bir provider oluşturuyoruz
final characterProvider = FutureProvider<List<CharacterModel>>((ref) async {
  final service = Service();
  return service.getCharacterInfo();  // Karakter verilerini alıyoruz
});

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Karakter verilerini almak için provider'ı izliyoruz
    final characterAsyncValue = ref.watch(characterProvider);

    // Ekranın genişliğini ve yüksekliğini alarak responsive bir tasarım yapıyoruz
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,  // Arka plan rengini belirledik
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text(
          'Harry Potter Characters',
          style: TextStyle(color: AppColors.greyLightColor, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: characterAsyncValue.when(
        // Veriler başarılı bir şekilde geldiyse
        data: (data) {
          return SingleChildScrollView(  // Ekranın kaymasını sağlıyoruz
            child: GridView.builder(
              physics: NeverScrollableScrollPhysics(), // GridView'in kendi kaymasını engelliyoruz, tek bir scroll olsun
              padding: EdgeInsets.all(15),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: screenWidth > 600 ? 3 : 2, // Mobilde 2, tablette 3 kart gösteriyoruz
                crossAxisSpacing: 15, // Kartlar arasındaki yatay boşluk
                mainAxisSpacing: 15, // Kartlar arasındaki dikey boşluk
                childAspectRatio: 0.7, // Kartların boyut oranını ayarlıyoruz
              ),
              itemCount: data.length,
              shrinkWrap: true,  // İçeriğin ekranı kaplayabilmesi için bu özelliği açıyoruz
              itemBuilder: (context, index) {
                final character = data[index];
                return GestureDetector(
                  onTap: () {
                    // Karaktere tıklayınca detay sayfasına yönlendireceğiz
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CharacterDetailPage(
                          character: character,  // Karakter verisini detay sayfasına gönderiyoruz
                        ),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),  // Kartların köşelerini yuvarlıyoruz
                    ),
                    color: AppColors.whiteColor,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Eğer karakterin resmi varsa göster, yoksa '?' simgesi göster
                        character.image != null && character.image!.isNotEmpty
                            ? ClipRRect(
                                borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                                child: Image.network(
                                  character.image!,
                                  fit: BoxFit.cover,
                                  height: screenHeight * 0.13, // Resmin yüksekliğini ekranın yüksekliğine göre ayarlıyoruz
                                  width: double.infinity,
                                ),
                              )
                            : Center(
                                child: Text(
                                  '?',  // Resim yoksa '?' yazıyoruz
                                  style: TextStyle(
                                    fontSize: 75,
                                    color: AppColors.greyTextColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            character.name ?? 'No Name',  // Eğer karakter ismi yoksa 'No Name' yazıyoruz
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.blackTextColor),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            'Gender: ${character.gender ?? 'Unknown'}',  // Cinsiyet bilgisini ekliyoruz
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.greyTextColor,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            'Species: ${character.species ?? 'Unknown'}',  // Tür bilgisini ekliyoruz
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.greyTextColor,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            character.alive == true ? 'Live' : 'Dead',  // Yaşayan ya da ölü olduğu bilgisini yazıyoruz
                            style: TextStyle(
                              color: character.alive == true
                                  ? Colors.green
                                  : Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
        // Veriler yükleniyor
        loading: () => Center(
          child: CircularProgressIndicator(color: AppColors.primaryLightColor),
        ),
        // Eğer bir hata oluşursa
        error: (error, stack) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, color: Colors.red, size: 50),
                SizedBox(height: 10),
                Text(
                  'Bir hata oluştu: $error',  // Hata mesajını yazıyoruz
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
