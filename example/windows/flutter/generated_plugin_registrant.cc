//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <json_field_builder/json_field_builder_plugin_c_api.h>
#include <json_form_builder/json_form_builder_plugin.h>

void RegisterPlugins(flutter::PluginRegistry* registry) {
  JsonFieldBuilderPluginCApiRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("JsonFieldBuilderPluginCApi"));
  JsonFormBuilderPluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("JsonFormBuilderPlugin"));
}
