// ignore_for_file: must_be_immutable

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final biggerFontSize = StateProvider<bool>((ref) => false);

class HatimPrayPage extends ConsumerWidget {
  HatimPrayPage({super.key});
  String text = "";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isBiggerFont = ref.watch(biggerFontSize);
    switch (context.deviceLocale.toString().substring(0, 2)) {
      case "tr":
        text = prayTr;
      case "en":
        text = prayEn;
      case "ar":
        text = prayAr;
      case "fr":
        text = prayAr;
        break;
      default:
        text = prayAr;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("duam".tr()),
        actions: [
          TextButton(
              onPressed: () {
                ref.read(biggerFontSize.notifier).state = !isBiggerFont;
              },
              child: const Text(
                "aA",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
            child: Text(
          text,
          style: TextStyle(fontSize: isBiggerFont ? 30 : 20),
        )),
      ),
    );
  }

  final String prayTr =
      """Âlemlerin Rabbi olan Allah’a hamd olsun. İyi sonuç müttakilerindir. Düşmanlık ancak zalimler içindir. Peygamberimiz Hz. Muhammed (a.s)’e, onun bütün ehl-i beytine ve ashâbına salât ve selâm olsun.

Ey Rabbimiz! Bizden ibadetlerimizi kabul buyur! Şüphesiz ki sen her şeyi işiten ve her şeyi bilensin.

Ey Mevlamız! Bizim tövbelerimizi kabul eyle!. Şüphesiz ki sen tövbeleri çok çok kabul eden ve merhametli olansın. Bize hidâyet ver! Hak yola ve sırat-ı müstakime ulaşmayı bizi muvaffak eyle!. Yüce Kur’ân’ın hürmetine, âlemlere rahmet olarak gönderdiğin Peygamber hürmetine.

Ey Kerim olan Allah! Bizi bağışla. Ey Rahim olan Allah! Bizi bağışla. Ey ikram edenlerin en keremlisi olan Allah! Lütfunla ve ihsanınla bizim günahlarımızı bağışla.

Allah’ım! Bizi Kur’ân süsü ile süsle. Kur’ân ile bize lütfet! Kur’ân ile bizi şereflendir. Kur’ân elbisesini bize giydir. Kur’ân hürmetine bizi cennetine koy. Kur’ân hürmetine dünyadaki belalardan ve âhiret azabından bizi koru. Ey Rahim, Ey Rahman! Ümmet-i Muhammed’in tamamına merhamet et.

Allah’ım! Kur’ân’ı bize dünyada yoldaş eyle. O’nu bize kabirde dost eyle. Kıyamet günü onu bize şefaatçi kıl, sırat köprüsü üzerinde onu bize nur eyle. Cennette onu bize yoldaş eyle. Cehennem ateşine karşı onu bize perde ve engel kıl. İhsanın, cömertliğin ve keremin ile tüm hayırlı yollar için onu bize önder kıl.

Kur’ân hidâyeti ile bizi hidâyete eriştir. Kur’ân’ın hürmetine bizi ateşten koru. Kur’ân hürmetine bizim derecemizi yükselt. Okunan Kur’ân hürmetine günahlarımızı bağışla. Ey Lütuf ve ihsan sahibi!.

Allah’ım! Kalplerimizi temizle. Kusurlarımızı ört. Hastalarımıza şifa ver. Borçlarımızı ödemeye yardım et. Yüzümüzü aydınlat. Derecemizi yükselt. Babalarımıza merhamet et. Annelerimizi bağışla. Din ve dünya işlerimizi islâh et. Düşmanlarımızın bize saldırısını bertaraf eyle. Ailemizi, mallarımızı, memleketimizi her türlü afetlerden, hastalıklardan ve belalardan koru. Ayaklarımızı sabit eyle, kâfir toplumlara karşı bize yardım et. Yüce Kur’ân hürmetine.

Allah’ım! Okuduğumuz ve tilavet ettiğimiz Kur’ân’ın sevabını ve nurunu Efendimiz Hz. Muhammed (a.s)’in ruhuna ulaştır. Ve onun kardeşleri olan tüm peygamberlerin (a.s) ruhlarına ulaştır. Ve Peygamberimiz (a.s)’in ehlinin, çocuklarının, hanımlarının, ashabının, tabiinin ve bütün zürriyetinin ruhlarına ulaştır.

Hayatta olan veya vefat etmiş olan babalarımızın, annelerimizin, kardeşlerimizin, evladımızın, akrabalarımızın, sevdiklerimizin, dostlarımızın, hocalarımızın, üzerimizde hakkı olan herkesin ve Müslüman olan bütün kadın ve erkeğin ruhlarına ulaştır.

Ey ihtiyaçları gideren Allah! Ey dualara icabet eden Allah! Ey merhametlilerin en merhametlisi! Dualarımızı kabul et. Tüm peygamberlere salât ve selam olsun.

Senin Rabbin; kudret ve şeref sahibi olan Rab, onların nitelendirdiği şeylerden uzaktır, yücedir. Peygamberlere selam olsun. alemlerin Rabbi olan Allah’a hamdolsun.

Fatiha denir ve Kur’an’ın birinci suresi (Fatiha) okunur.

""";

  final String prayEn =
      """O Allah I have recited that which Thou commands from Thy Book Thou revealed to Thy truthful Prophet, blessings of Allah be on him and on his children. (All) praise be to our Lord.

O Allah let me be one of those who take to the lawful and keep from the unlawful, accept and show submission to its clear as well as similar commands,

let (this recitation) be my companion in my grave and at the time of Resurrection,

and let me be one of those whom Thou shall raise and exalt, on account of this recitation, on the highest pedestal in the Paradise. Be it so O the Lord of the worlds.

O Allah: (please) expand my breast through the Qur’an

And use my body for the Qur’an

And enlighten my sight by the Qur’an

And make my tongue eloquent by the Qur’an

And help me carry out its duty as long as You keep me alive,

For there is neither power nor might save with You.

O Allah let me be one of those who take to the lawful and keep from the unlawful, accept and show submission to its clear as well as similar commands,

let (this recitation) be my companion in my grave and at the time of Resurrection,

and let me be one of those whom Thou shall raise and exalt, on account of this recitation, on the highest pedestal in the Paradise. Be it so O the Lord of the worlds.

 O Allah, divert my restlessness in the grave into peace. O Allah! let me receive Your mercy by means of the Noble Qur’an and make it my guide as well as a source of light, guidance, and grace for me. 

 O Allah! revive my memory of whatever I was made to forget from the Noble Qur’an, grant me understanding of whatever part I know not, enable me to recite it during hours of day and night and make it my main argumentative support (in all matters), O Lord of the worlds.
""";

  final String prayAr = """ 
أَلْحَمْدُ لِلَّٰهِ رَبِّ الْعَالَم۪ينَ ﴿﴾ وَالْعَاقِـبَـةُ لِلْمُـتَّـق۪ينَ ﴿﴾ وَلَا عُدْوَانَ إِلَّا عَلَي الظَّالِم۪ينَ ﴿﴾ وَالصَّلٰاةُ وَالسَّلٰامُ عَلٰى رَسُولِـنَا مُحَمَّدٍ وَأٰلِه۪ وَصَحْبِه۪ٓ أَجْمَع۪ينَ ﴿﴾ أَللَّٰـهُمَّ رَبَّـنَا يَا رَبَّـنَا تَـقَـبَّـلْ مِنَّا إِنَّكَ أَنْتَ السَّم۪يعُ الْعَل۪يمُ ﴿﴾ وَتُبْ عَلَيْنَا يَا مَوْلٰــنَآ إِنَّكَ أَنْتَ التَّــوَّابُ الرَّح۪يمُ ﴿﴾ وَاهْدِنَا وَوَفِّقْـنَآ إِلَى الْحَقِّ وَإِلٰى طَر۪يقٍ مُسْتَـق۪يمٍ ﴿﴾ بِـبَـرَكَـةِ الْقُرْأٰنِ الْعَظ۪يمِ ﴿﴾ وَبِحُرْمَـةِ مَنْ أَرْسَلْـتَـهُ رَحْمَةً لِلْعَالَم۪ينَ ﴿﴾ وَاعْفُ عَـنَّا يَا كَر۪يمُ ﴿﴾ وَاعْفُ عَـنَّا يَا رَح۪يمُ ﴿﴾ وَاغْفِرْ لَـنَا ذُنُـوبَـنَا بِفَضْلِكَ وَجُودِكَ وَكَرَمِكَ يَآأَكْرَمَ الْاَكْرَم۪ينَ ﴿﴾ أَللَّٰـهُمَّ زَيِّـنَّا بِز۪يـنَـةِ الْقُرْأٰنِ ﴿﴾ وَأَكْرِمْنَا بِكَرَامَةِ الْقُرْأٰنِ ﴿﴾ وَشَرِّفْـنَا بِشَرَافَةِ الْقُرْأٰنِ ﴿﴾ وَأَلْبِسْنَا بِـخِلْعَةِ الْقُرْأٰنِ ﴿﴾ وَأَدْخِـلْـنَا الْجَـنَّـةَ بِشَفَاعَةِ الْقُرْأٰنِ ﴿﴾ وَعَافِـنَا مِنْ كُلِّ بَلٰٓاءِ الدُّنْـيَا وَعَذَابِ الْاٰخِرَةِ بِحُرْمَةِ الْقُرْأٰنِ ﴿﴾ وَارْحَمْ جَم۪يعَ أُمَّـةِ مُحَمَّدٍ يَا رَح۪يمُ يَا رَحْمٰنُ ﴿﴾ أَللَّٰـهُمَّ اجْعَلِ الْقُرْأٰنَ لَـنَا فِي الدُّنْـيَا قَر۪ينًا ﴿﴾ وَفِي الْقَـبْـرِ مُونِسًا ﴿﴾ وَفِي الْقِيَامَـةِ شَف۪يعًا ﴿﴾ وَعَلَى الصِّرَاطِ نُـورًا ﴿﴾ وَفِي الْجَـنَّـةِ رَف۪يقًا ﴿﴾ وَمِنَ النَّارِ سِتْـرًا وَحِجَابًا ﴿﴾ وَإِلىَ الْخَـيْـرَاتِ كُـلِّـهَا دَل۪يلًا وَإِمَامًا ﴿﴾ بِفَضْلِكَ وَجُودِكَ وَكَرَمِكَ يَآ أَكْرَمَ الْاَكْرَم۪ينَ وَيَآ أَرْحَمَ الرَّاحِم۪ينَ. أَللَّٰـهُمَّ اهْدِنَا بِـهِدَايَـةِ الْقُرْأٰنِ ﴿﴾ وَنَـجِّـنَا مِنَ النّ۪ـيرَانِ بِكَرَامَةِ الْقُرْأٰنِ ﴿﴾ وَارْفَعْ دَرَجَاتِـنَا بِفَض۪يلَـةِ الْقُرْأٰنِ ﴿﴾ وَكَفِّرْ عَـنَّا سَيِّأٰتِـنَا بِـتِـلٰاوَةِ الْقُرْأٰنِ ﴿﴾ يَا ذَا الْفَضْلِ وَالْاِحْسَانِ ﴿﴾ أَللَّٰـهُمَّ طَهِّرْ قُـلوُبَـنَا ﴿﴾ وَاسْتُرْ عُيوُبَـنَا ﴿﴾ وَاشْفِ مَرْضَانَا ﴿﴾ وَاقْضِ دُيُـونَـنَا ﴿﴾ وَارْفَعْ دَرَجَاتِـنَا ﴿﴾ وَارْحَمْ أٰبَآءَنَا ﴿﴾ وَاغْفِرْ أُمَّـهَاتِـنَا ﴿﴾ وَأَصْلِحْ د۪يـنَـنَا وَدُنْـيَانَا ﴿﴾ وَشَتِّتْ شَمْلَ أَعْدَآئِـنَا ﴿﴾ وَاحْفَظْ أَهْلَـنَا وَأَمْوَالَـنَا وَبِلَادَنَا مِنْ جِم۪يعِ الْاٰفَاتِ وَالْاَمْرَاضِ وَالْـبَـلٰايَا ﴿﴾ وَثَـبِّتْ أَقْدَامَنَا وَانْصُرْنَا عَلَى الْقَوْمِ الْكَافِر۪ينَ ﴿﴾ بِحُرْمَةِ الْقُرْأٰنِ الْعَظ۪يمِ ﴿﴾

أَللَّٰـهُمَّ بَـلِّـغْ ثَــوَابَ مَا قَرَأْنَاهُ ، وَنُـورَ مَا تَـلَوْنَاهُ ، إِلٰى رُوحِ سَيِّـدِنَا وَنَـبِـيِّـنَا مُحَمَّدٍ صَلَّى اللّٰهُ تَـعَالٰى عَلَـيْـهِ وَسَلَّمَ ﴿﴾ وَإِلٰٓى أَرْوَاحِ جَم۪يعِ الْاَنْبِـيَـآءِ وَالْمُرْسَل۪ينَ ، صَلَوَاتُ اللّٰهِ وَسَلٰامُهُ عَلَـيْهِمْ أَجْمَع۪ينَ ﴿﴾وَإِلٰٓى أَرْوَاحِ أٰلِه۪، وَأَوْلٰادِه۪ ، وَأَزْوَاجِه۪، وَأَصْحَابِـه۪، أَتْـبَاعِه۪، وَجَم۪يعِ ذُرِّيَّاتِـه۪ رِضْوَانُ اللّٰهِ تَعَالٰى عَلَـيْـهِمْ أَجْمَع۪ينَ ﴿﴾ وَإِلٰٓى أَرْوَاحِ أٰ بَآئِـنَا، وَأُمَّـهَاتِـنَا، وَإِخْوَانِـنَا وَأَخَوَاتِـنَا، وَأَوْلَادِنَا، وَأَقْرِبَآئِـنَا، وَأَحِبَّآئِـنَا، وَأَصْدِقَآئِـنَا، وَأَسَات۪يذِنَا، وَمَشَايِـخِـنَا، وَلِمَنْ كَانَ لَهُ حَقٌّ عَلَـيْـنَا ﴿﴾ وَإِلٰي أَرْوَاحِ جَم۪يعِ الْمُؤْمِن۪ينَ وَالْمُؤْمِنَاتِ، وَالْمُسْلِم۪ينَ وَالْمُسْلِمَاتِ، أَلْاَحْـيَآءِ مِـنْـهُمْ وَالْاَمْوَاتِ ﴿﴾ يَا قَاضِيَ الْحَاجَاتِ وَيَا مُج۪يبَ الدَّعَـوَاتِ ﴿﴾ رَبَّـنَآ أٰتِـنَا فِي الدُّنْـيَا حَسَنَةً وَفِي الْاٰخِرَةِ حَسَنَةً وَقِنَا عَذَابَ النَّارِ ﴿﴾ أَللَّٰـهُمَّ رَبَّـنَا اغْفِرْ ل۪ي وَلِـوَالِدَيَّ وَلِلْمُؤْمِن۪ينَ يَوْمَ يَقُومُ الْحِسَابُ """;
}
