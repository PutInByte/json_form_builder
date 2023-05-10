//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <json_field_builder/json_field_builder_plugin.h>
#include <json_form_builder/json_form_builder_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) json_field_builder_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "JsonFieldBuilderPlugin");
  json_field_builder_plugin_register_with_registrar(json_field_builder_registrar);
  g_autoptr(FlPluginRegistrar) json_form_builder_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "JsonFormBuilderPlugin");
  json_form_builder_plugin_register_with_registrar(json_form_builder_registrar);
}
