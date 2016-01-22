/*
  Bu JMC ve Sonia isimli 2 tane processing kütüphanesinin karışık örneği.
  
  JMC Video "http://www.mat.ucsb.edu/~a.forbes/PROCESSING/jmcvideo/jmcvideo.html"
  Sonia "http://sonia.pitaru.com/"
  
  Bu arada Processing de ve diğer çoğu programlama dillerinde geçerli olmak üzere,
  2 adet yorum satırı ekleme yapısı var. Bunları kullanarak açıklamalar yazarız,
  anlatırız kodu vs. Çünkü kod içine normal olarak yazarsak, kod gibi algılanır ve
  uygulama çalışmaz.
  
  Satır tipi yorum: iki tane sağa yatık slash koyarak "//" tek satır olarak yazabileceğin
  yorumlar vardır. Küçük kısa şeylerı yazmak için kullanırız. Aşağıda kodları açıklamak
  için bunlardan kullandım.
  
  Çoklu satır tipi yorum: şuan yazdığım herşey / *   ve  * /  arasında fark ettiysen :)
  Bu da 1 den fazla yorum satırı yazmak isteyince kullanabileceğin birşey, hem de // leri
  kullanmamış oluyoruz her satırın başında
  
  Sen de kendin not alabilirsin böylece bu 2 yöntemle kod arasında.
  
*/

import jmcvideo.*;  // JMC video oynatma kütüphanesi
import processing.opengl.*;  // Video için gerekli processing kütüphanesi

import pitaru.sonia_v2_9.*;  // Ses çalma kütüphanesi

import fullscreen.*;  // Uygulamayı tam ekran yapma kütüphanesi
import japplemenubar.*;  // Tam ekran yapma kütüphanesinin yardımcısı

// tam ekran yapan kütüphaneden bir nesne yaratıyoruz
FullScreen fs;

// video oynatan kütüphaneden bir nesne yaratıyoruz
JMCMovie myMovie;

// ses çalan kütüphaneden bir nesne yaratıyoruz
Sample mySample;

// programımız ilk açıkdığında setup() fonksiyonu çağrılır
// bu fonksiyon içinde ilk baştaki gerekli configurationları yaparız
void setup()
{
  // "movie1.mov" isimli videomuzu yüklüyoruz
  myMovie = movieFromDataPath("movie1.mov");
  // videomuzu loop a sokup devamlı oynatıyoruz
  myMovie.loop();
  
  // Sonia isimli ses çalma kütüphanemisi başlatıyoruz
  Sonia.start(this);
  // kütüphanemize müziğimizi yüklüyoruz.
  // wav ve aiff oynatabiliyor
  mySample = new Sample("music1.aiff");
  // .repeat() diyerek loop a sokuyoruz
  mySample.repeat();
  
  // burda uygulamamızın hangi boyutlarda başlayacağını belirtiyoruz
  // aşağıdaki width ve height her bilgisayara göre otomatik ayarlanıyor
  size(screen.width, screen.height, P2D);
  
  // uygulamamızın frame rate ini belirliyoruz
  frameRate(30);
  
  // full screen kütüphanemizi başlatıyoruz
  fs = new FullScreen(this); 
  
  // full screen kütüphanemize tam ekran moduna girmesini söylüyoruz
  // ve burada artık uygulama tam ekran oluyor
  fs.enter();
}

// bu fonksiyon olabildiğince çok çağrılan
// ekrana birşeyler çizdirmeye yarayan fonksiyondur
void draw()
{
  // myMovie resmini alıp, ekranda x,y 0,0 koordinatlarına bastırıyoruz
  // böylece video sol üstte şuanda kendi boyutunda oynuyor mesela
  //image(myMovie, 0, 0);
  
  // Aşağı da ise videonun boyutunu önemsemeden ekran boyutları kadar
  // genişletiyoruz ama güzel olmuyor, o yüzden yorum satırı içine aldım
  // bu yüzden aşağıdaki satır değil yukarıdaki satır çalışıyor draw() çalışınca
  image(myMovie, 0, 0, screen.width, screen.height);
}

// Bu fonksiyon klavyeden bir tuşa basılınca çağrılıyor
// bunu sesi ıksıp azaltmada kullandım. Klavyeden 0-9 arasina
// göre ses alçalıp azalıyor. BU arada Volume 0-1 arasında değer
// alıyor, o yüzden kapatmak için 0, full ses için 1.0 değeri vermek gerekiyor.
void keyPressed()
{
  switch(key)
  {
    case '0': // eğer 0 a basarsan sesi kapatıyor
      mySample.setVolume(0.0f);
      break;
    case '1': // eğer 1 e basarsan sesi 0.1 yapıyor, yani %10
      mySample.setVolume(0.1f);
      break;
    case '2': // gerisi aynı, 2 ye bastın, sesi %20 yaptı vs. vs.
      mySample.setVolume(0.2f);
      break;
    case '3':
      mySample.setVolume(0.3f);
      break;
    case '4':
      mySample.setVolume(0.4f);
      break;
    case '5':
      mySample.setVolume(0.5f);
      break;
    case '6':
      mySample.setVolume(0.6f);
      break;
    case '7':
      mySample.setVolume(0.7f);
      break;
    case '8':
      mySample.setVolume(0.8f);
      break;
    case '9':
      mySample.setVolume(0.9f);
      break;
    default:
      // "default" ise yukarıdaki tuşlar harici bir tuş basıldığında
      // gelinen yer. 0-9 harici birşeye basınca sesi 1.0 yapıyorum yani %100
      mySample.setVolume(1.0f);
      break;
  }
}

// bu pek önemli değil, program kapandığında ses kütüphenesinin sonlandırılması gerekiyor
public void stop(){
  Sonia.stop();
  super.stop();
}

/*
 bu da video kütüphanemizle kullanmak için bir fonksiyon
 bu kodların çalıştığı yerdeki "data" klasöründen yukarda
 ismini verdiğimiz videoyu yüklüyor
*/
JMCMovie movieFromDataPath(String filename)
{
   return new JMCMovie(this, filename, RGB);
}


