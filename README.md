# Harry Potter Character Viewer

Bu proje, **Harry Potter karakterlerinin verilerini çekmek** için **hp-api.onrender.com** API'sini kullanarak bir mobil uygulama geliştirmeyi amaçlamaktadır. API'den alınan karakter verileri, uygulama arayüzünde listelenmektedir.

## Değerlendirme Kriterlerine Uygunluk

### 1. HTTP Paket Kullanımı:
API'ye yapılan isteklerde **Dio** paketini kullandım. Dio, HTTP istekleri için güçlü ve verimli bir kütüphanedir. API'den gelen veriler doğru şekilde alınarak işlenmiştir. Hata durumlarında uygun hata mesajları kullanıcıya gösterilmektedir.

### 2. State Yönetimi:
Veri yönetimi için **Riverpod** kullanılmıştır. Riverpod, uygulamanın veri akışını düzgün ve etkili bir şekilde yönetmemi sağlamıştır. Karakter verilerinin API'den alınıp arayüzde düzgün bir şekilde listelenmesi sağlanmıştır. Ayrıca veri yönetimi ve UI'nin uyumlu çalışması için gerekli olan durumlar (veri yükleniyor, hata, başarı) başarıyla yönetilmiştir.

### 3. Flutter UI Tasarımı:
Arayüz tasarımında sade ve **responsive** bir yapı hedeflenmiştir. Uygulama, farklı ekran boyutlarına uyum sağlayacak şekilde tasarlanmış olup, karakter verileri düzgün bir şekilde listelenmektedir. Karakterlerin detaylarına rahatça ulaşılabilmesi için tıklanabilir kartlar kullanılmıştır.

### 4. Basit Hata Yönetimi:
API isteklerinde hata durumları kullanıcıya uygun şekilde gösterilmektedir. API'den veri alınırken bir hata oluşursa, kullanıcıya açık ve anlaşılır bir hata mesajı sunulmaktadır.

## Diğer Teknolojiler ve Araştırmalar

- **Flutter Hooks** ve **Freezed** hakkında araştırmalar yaparak bu teknolojilerin potansiyelini değerlendirdim. **Flutter Hooks**, uygulamanın durumunu daha basit bir şekilde yönetmek için güzel bir alternatif sunmaktadır. Ancak, Hooks ile henüz yeterince tecrübe kazanmadığım için biraz alışma süreci gerekmektedir. Bu yüzden, şu an için **Riverpod**'u tercih ettim. **Freezed** ise immutability ve model yönetimi konusunda faydalı olabilecek bir kütüphane olup, gelecekte daha detaylı kullanmayı planlıyorum.


## Teknolojiler
- Flutter
- Riverpod
- Dio
- Font Awesome
- Google Fonts
  

### Açıklamalar:
- **Ekran Görüntüleri** kısmında, `ss1`, `ss2` ve `color_palette` dosya isimlerini uygun şekilde **assets/screenshots** klasöründe bulunan resimlere bağladım.
- Fotoğrafların doğru şekilde yüklendiğinden ve **`assets/screenshots/`** dizininde yer aldığından emin olun. Eğer dizinde yer almazlarsa, GitHub sayfasında görünmezler.

### Notlar:
1. **GitHub Assets Yolu**: `assets/screenshots/` klasöründe resimlerinizin bulunduğundan emin olun ve `pubspec.yaml` dosyasındaki `assets` bölümünde de bu yolu belirttiğinizden emin olun.
   Örnek `pubspec.yaml`:

   ```yaml
   flutter:
     assets:
       - assets/screenshots/


## Kurulum
Projenin kurulumunu yapmak için aşağıdaki adımları izleyebilirsiniz:

1. GitHub reposunu klonlayın:
  ```bash
  https://github.com/MustafaOzkaya1/harrypotterapp
flutter pub get
flutter run
