import 'package:url_launcher/url_launcher.dart';

void launchPhoneCall(String phoneNumber) async {
  final url = 'tel:$phoneNumber';
  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(Uri(scheme: 'tel', path: phoneNumber));
  } else {
    throw Exception('Could not launch $url');
  }
}
