#include "include/json_form_builder/json_form_builder_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "json_form_builder_plugin.h"

void JsonFormBuilderPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  json_form_builder::JsonFormBuilderPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
