#ifndef FLUTTER_PLUGIN_JSON_FORM_BUILDER_PLUGIN_H_
#define FLUTTER_PLUGIN_JSON_FORM_BUILDER_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace json_form_builder {

class JsonFormBuilderPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  JsonFormBuilderPlugin();

  virtual ~JsonFormBuilderPlugin();

  // Disallow copy and assign.
  JsonFormBuilderPlugin(const JsonFormBuilderPlugin&) = delete;
  JsonFormBuilderPlugin& operator=(const JsonFormBuilderPlugin&) = delete;

 private:
  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace json_form_builder

#endif  // FLUTTER_PLUGIN_JSON_FORM_BUILDER_PLUGIN_H_
