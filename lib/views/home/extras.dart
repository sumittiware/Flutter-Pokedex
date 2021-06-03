import 'package:share/share.dart';
import 'package:store_redirect/store_redirect.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> share() async {
  await Share.share(
      "If you are also a Pokemon fan this app is just for you https://play.google.com/store/apps/details?id=com.sgttodolist",
      subject: "Share this amazing app!!");
}

//functio to redirect user to app page
void rateUs() {
  StoreRedirect.redirect(
    androidAppId: "com.sgttodolist",
  );
}

//function for about us functionality
void aboutMe() async {
  const url = 'https://www.instagram.com/sumit_tiware_';
  if (await canLaunch(url)) {
    await launch(url);
  } else {}
}
