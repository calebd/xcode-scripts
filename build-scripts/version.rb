#!/usr/bin/env ruby

raise 'Install CFPropertyList' unless require 'cfpropertylist'

def product_path
  File.join(ENV['TARGET_BUILD_DIR'], ENV['FULL_PRODUCT_NAME'])
end

def settings_plist_path
  File.join(product_path, 'Settings.bundle', 'Root.plist')
end

def info_plist_path
  File.join(product_path, 'Info.plist')
end

def application_version
  plist = CFPropertyList::List.new(file: info_plist_path)
  plist_value = CFPropertyList.native_types(plist.value)
  "#{plist_value['CFBundleShortVersionString']} (#{plist_value['CFBundleVersion']})"
end

def set_version_in_settings_plist
  plist = CFPropertyList::List.new(file: settings_plist_path)
  plist_value = CFPropertyList.native_types(plist.value)
  plist_value['PreferenceSpecifiers'][1]['DefaultValue'] = application_version
  plist.value = CFPropertyList.guess(plist_value)
  plist.save
end

set_version_in_settings_plist
