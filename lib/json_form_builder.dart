
import 'json_form_builder_platform_interface.dart';

class JsonFormBuilder {
  Future<String?> getPlatformVersion() {
    return JsonFormBuilderPlatform.instance.getPlatformVersion();
  }
}
