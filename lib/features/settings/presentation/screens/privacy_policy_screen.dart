import 'package:flutter/material.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../l10n/app_localizations.dart';

/// Static content, not routed through .arb — this is a legal document, not
/// UI chrome, and keeping the two full-length versions as plain constants
/// avoids bloating the translation files with paragraph-sized entries.
class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isTurkish = Localizations.localeOf(context).languageCode == 'tr';
    return Scaffold(
      appBar: AppBar(title: Text(l10n.settingsPrivacyPolicy)),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.screenMargin),
          child: Text(
            isTurkish ? _trContent : _enContent,
            style: AppTypography.bodyMd,
          ),
        ),
      ),
    );
  }
}

const _lastUpdated = '14 September 2026';

const _enContent = '''
PRIVACY POLICY

THRIVE+
Operated by SilverOak Technologies
Last updated: $_lastUpdated

This Privacy Policy explains what data THRIVE+ ("the App") collects, how it is used, and the choices you have.

1. WHO WE ARE
THRIVE+ is developed and operated by SilverOak Technologies ("we", "us"). Contact: support@silveroaktech.app (Replace with your real support address before publishing.)

2. DATA WE COLLECT
- Account data: email address and authentication identifiers, handled by our backend provider, Supabase.
- Profile data you provide: name, age, height, weight, fitness level, goals.
- Activity data: workout sessions, sets/reps/weights logged, nutrition entries, body-measurement history, weight history.
- AI feature input: text you type for AI meal parsing, and profile/progress data sent to generate AI workout plans — only when you use those features.
- Device/technical data: standard mobile OS and network information needed to operate the app (no advertising identifiers are collected beyond what the ad/analytics SDKs listed below require).

3. HOW WE USE YOUR DATA
- To create and maintain your account and sync your data across devices.
- To generate your workout programs, nutrition targets, and progress charts.
- To power optional AI features (workout generation, meal-text parsing) via Google's Gemini API — the specific text/data you submit for that feature is sent to Google for processing and is not used by Google to train models under their API terms.
- To show ads (if enabled) and process subscription payments (if enabled), via Google AdMob and Google Play Billing / RevenueCat.

4. THIRD-PARTY SERVICES WE USE
- Supabase (database, authentication, file storage) — data is stored on Supabase's infrastructure.
- Google Gemini API (AI features) — only invoked when you use an AI feature.
- Open Food Facts (public food database) — only your search query is sent.
- Google AdMob (advertising) — if ads are enabled in the app.
- RevenueCat / Google Play Billing (subscriptions) — if subscriptions are enabled in the app.

We do not sell your personal data to third parties.

5. DATA RETENTION
Your data is retained as long as your account exists. You can permanently delete your account and all associated data at any time from Settings > Delete Account. This action is immediate and irreversible.

6. YOUR RIGHTS
Depending on your location, you may have rights to access, correct, export, or delete your data. You can exercise deletion directly in the app; for other requests, contact us at the address above.

7. CHILDREN
THRIVE+ is not directed at children under 13 (or the minimum age required by your local law). We do not knowingly collect data from children.

8. SECURITY
We use industry-standard measures (encrypted transport, row-level security on our database) to protect your data, but no method of transmission or storage is 100% secure.

9. CHANGES TO THIS POLICY
We may update this policy from time to time. Material changes will be reflected by updating the "Last updated" date above.

10. CONTACT
Questions about this policy: support@silveroaktech.app
''';

const _trContent = '''
GİZLİLİK POLİTİKASI

THRIVE+
SilverOak Technologies tarafından işletilmektedir
Son güncelleme: $_lastUpdated

Bu Gizlilik Politikası, THRIVE+ ("Uygulama") tarafından hangi verilerin toplandığını, nasıl kullanıldığını ve sahip olduğunuz seçenekleri açıklar.

1. BİZ KİMİZ
THRIVE+, SilverOak Technologies ("biz") tarafından geliştirilmekte ve işletilmektedir. İletişim: support@silveroaktech.app (Yayınlamadan önce gerçek destek adresinizle değiştirin.)

2. TOPLADIĞIMIZ VERİLER
- Hesap verileri: e-posta adresi ve kimlik doğrulama bilgileri, backend sağlayıcımız Supabase üzerinden işlenir.
- Sağladığınız profil verileri: ad, yaş, boy, kilo, fitness seviyesi, hedefler.
- Aktivite verileri: antrenman oturumları, kaydedilen set/tekrar/ağırlık bilgileri, beslenme girişleri, vücut ölçüm geçmişi, kilo geçmişi.
- AI özellik girdisi: AI ile öğün ayrıştırma için yazdığınız metin ve yalnızca bu özellikleri kullandığınızda AI antrenman programı oluşturmak için gönderilen profil/ilerleme verileri.
- Cihaz/teknik veriler: uygulamanın çalışması için gereken standart mobil işletim sistemi ve ağ bilgileri.

3. VERİLERİNİZİ NASIL KULLANIYORUZ
- Hesabınızı oluşturmak, sürdürmek ve verilerinizi cihazlar arasında senkronize etmek için.
- Antrenman programlarınızı, beslenme hedeflerinizi ve ilerleme grafiklerinizi oluşturmak için.
- Opsiyonel AI özelliklerini (antrenman oluşturma, öğün metni ayrıştırma) Google'ın Gemini API'si üzerinden çalıştırmak için — bu özellik için gönderdiğiniz metin/veri Google'a işlenmek üzere gönderilir ve Google'ın API şartlarına göre model eğitiminde kullanılmaz.
- Reklam göstermek (etkinse) ve abonelik ödemelerini işlemek (etkinse), Google AdMob ve Google Play Billing / RevenueCat üzerinden.

4. KULLANDIĞIMIZ ÜÇÜNCÜ TARAF HİZMETLER
- Supabase (veritabanı, kimlik doğrulama, dosya depolama) — verileriniz Supabase altyapısında saklanır.
- Google Gemini API (AI özellikleri) — yalnızca bir AI özelliğini kullandığınızda çağrılır.
- Open Food Facts (herkese açık gıda veritabanı) — yalnızca arama sorgunuz gönderilir.
- Google AdMob (reklam) — uygulamada reklamlar etkinse.
- RevenueCat / Google Play Billing (abonelikler) — uygulamada abonelikler etkinse.

Kişisel verilerinizi üçüncü taraflara satmıyoruz.

5. VERİ SAKLAMA
Verileriniz hesabınız var olduğu sürece saklanır. Hesabınızı ve ilişkili tüm verilerinizi Ayarlar > Hesabı Sil üzerinden istediğiniz zaman kalıcı olarak silebilirsiniz. Bu işlem anında gerçekleşir ve geri alınamaz.

6. HAKLARINIZ
Bulunduğunuz konuma bağlı olarak verilerinize erişme, düzeltme, dışa aktarma veya silme hakkına sahip olabilirsiniz. Silme işlemini doğrudan uygulama üzerinden yapabilirsiniz; diğer talepler için yukarıdaki adresten bizimle iletişime geçin.

7. ÇOCUKLAR
THRIVE+, 13 yaşın altındaki çocuklara (veya bulunduğunuz yerdeki yasal asgari yaşın altındakilere) yönelik değildir. Çocuklardan bilerek veri toplamıyoruz.

8. GÜVENLİK
Verilerinizi korumak için endüstri standardı önlemler (şifreli iletim, veritabanımızda satır düzeyinde güvenlik) kullanıyoruz, ancak hiçbir iletim veya depolama yöntemi %100 güvenli değildir.

9. BU POLİTİKADAKİ DEĞİŞİKLİKLER
Bu politikayı zaman zaman güncelleyebiliriz. Önemli değişiklikler yukarıdaki "Son güncelleme" tarihine yansıtılacaktır.

10. İLETİŞİM
Bu politikayla ilgili sorularınız için: support@silveroaktech.app
''';
