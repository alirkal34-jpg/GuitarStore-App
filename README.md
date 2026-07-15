# Mini Katalog Uygulaması - Guitar Shop

Bu proje, Flutter günlük eğitim programı kapsamında geliştirilmiş bir "Mini Katalog" mobil uygulamasıdır. Başlangıçta temel bir liste ve JSON veri modellemesiyle yola çıkılmış, ardından tamamen "Heavy Metal" konseptine bürünerek özelleştirilmiş, profesyonel bir tasarıma (Guitar Shop) dönüştürülmüştür.

## Eğitim Hedefleri ve Kazanımlar

Bu proje sayesinde aşağıdaki mobil uygulama geliştirme temelleri uygulanmıştır:
- **Widget Ağacı ve UI Mantığı:** Stateless ve Stateful widget kullanımı, temel ekran tasarımları.
- **Flutter Navigasyon (Sayfa Geçişleri):** `Navigator.push` / `pop` metodları ile sayfalar arası geçiş ve veri aktarımı.
- **Katalog ve GridView Mimarisi:** Ürünlerin `GridView.builder` ile kart tabanlı bir yapıda listelenmesi.
- **Veri Modelleme (Simülasyon):** Ürün verilerinin bir JSON formatı üzerinden çekilmesi, model sınıfları (fromJson/toJson vb.) kullanılması.
- **State Yönetimi:** Sepete ekleme ve kaldırma işlemleri için temel state (durum) yönetimi.
- **Tema ve Özelleştirme:** Özel karanlık (Dark) tema, marka ikonları, `BoxFit` kullanılarak görsel yerleşimleri.

## Özellikler

- **Ana Ekran (Home Screen):** Karanlık temalı modern arayüz, arama çubuğu ve ızgara (grid) şeklinde sıralanmış elektro gitarlar.
- **Ürün Detay Sayfası:** İlgili gitarın teknik özellikleri (Specs), etiketleri (Tags), yüksek çözünürlüklü kaydırılabilir resim galerisi ve "Add to Cart" butonu. Ayrıca bazı ürünler için dinamik renk seçimi özelliği.
- **Sepet (Cart Screen):** Seçilen ürünlerin listelendiği, toplam fiyatın hesaplandığı ve statik arka planlı ödeme simülasyon ekranı.

## Ekran Görüntüleri

Uygulamanın yenilenmiş "Heavy Metal" tasarımına ait bazı ekran görüntüleri aşağıdadır:

<div style="display: flex; flex-direction: row; gap: 10px;">
  <img src="https://raw.githubusercontent.com/alirkal34-jpg/GuitarStore-App/main/assets/screenshots/home_screen.png" alt="Home Screen" width="250"/>
  <img src="https://raw.githubusercontent.com/alirkal34-jpg/GuitarStore-App/main/assets/screenshots/detail_screen.png" alt="Detail Screen" width="250"/>
  <img src="https://raw.githubusercontent.com/alirkal34-jpg/GuitarStore-App/main/assets/screenshots/cart_screen.png" alt="Cart Screen" width="250"/>
</div>

> **Not:** Ekran görüntülerini GitHub'da görüntüleyebilmek için lütfen bu görselleri projenizin `assets/screenshots/` klasörüne (home_screen.png, detail_screen.png, cart_screen.png adlarıyla) yükleyip pushladığınızdan emin olun.

## Kullanılan Teknolojiler

- **Flutter Sürümü:** Flutter SDK (material.dart)
- **Dil:** Dart
- **Paketler:** Proje temel Flutter yeteneklerini pekiştirmek amaçlı dış paket kullanılmadan geliştirilmiştir. (Sadece temel kütüphaneler yer almaktadır).

## Çalıştırma Adımları

Bu projeyi yerel bilgisayarınızda çalıştırmak için aşağıdaki adımları izleyebilirsiniz:

1. Bu depoyu klonlayın:
   ```bash
   git clone https://github.com/alirkal34-jpg/GuitarStore-App.git
   ```

2. Proje dizinine gidin:
   ```bash
   cd "mobile application"
   ```

3. Bağımlılıkları yükleyin (Assetlerin indexlenmesi için gereklidir):
   ```bash
   flutter pub get
   ```

4. Uygulamayı bir emülatörde veya bağlı cihazda başlatın:
   ```bash
   flutter run
   ```

## Not
Bu proje eğitim amaçlıdır ve bir e-ticaret altyapısına bağlanmamaktadır. Sepet (Checkout) ve ürün verileri tamamen statik dummy datalar kullanılarak simüle edilmiştir. 
