#!/usr/bin/env ruby

SUPPORTED_LOCALES = [ 'Base', 'en' ]

def product_path
  File.join(ENV['TARGET_BUILD_DIR'], ENV['FULL_PRODUCT_NAME'])
end

def path_for_locale(locale)
  File.join(product_path, locale + '.lproj')
end

def locale_for_path(locale)
  match = locale.match(/\/(?<locale>[^\/]*)\.lproj\z/)
  return match[:locale] if match
  return nil
end

def compiled_locales
  pattern = File.join(product_path, '*.lproj')
  Dir.glob(pattern).inject([]) do |array, path|
    locale = locale_for_path(path)
    if locale
      array + [ locale ]
    else
      array
    end
  end
end

compiled_locales.reject do |locale|
  SUPPORTED_LOCALES.include?(locale)
end.each do |locale|
  path = path_for_locale(locale)
  puts "Removing unsupported locale: #{locale}"
  raise "Unable to remove locale: #{locale}" unless system("rm -rf #{path}")
end
