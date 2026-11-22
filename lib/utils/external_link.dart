import 'package:url_launcher/url_launcher.dart';

/// Opens a supported external URL without allowing malformed links or
/// platform/plugin failures to crash the portfolio UI.
Future<bool> launchExternalUrl(String value) async {
  final uri = Uri.tryParse(value.trim());
  if (uri == null || !uri.hasScheme) return false;

  const supportedSchemes = {'https', 'mailto', 'tel'};
  if (!supportedSchemes.contains(uri.scheme.toLowerCase())) return false;

  try {
    return await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    );
  } catch (_) {
    return false;
  }
}
