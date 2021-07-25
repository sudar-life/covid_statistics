import 'package:xml/xml.dart';

class XmlUtils {
  static String searchResultString(XmlElement xml, String key) {
    return xml.findAllElements(key).map((e) => e.text).isEmpty
        ? ''
        : xml.findAllElements(key).map((e) => e.text).first;
  }

  static double searchResultDouble(XmlElement xml, String key) {
    return xml.findAllElements(key).map((e) => e.text).isEmpty
        ? 0.0
        : double.parse(xml.findAllElements(key).map((e) => e.text).first);
  }
}
