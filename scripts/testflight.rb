require 'fileutils'

def ipa_path
 File.join(ENV['XCS_OUTPUT_DIR'], ENV['XCS_PRODUCT'])
end

def bot_name
  ENV['XCS_BOT_NAME']
end

def product_name
  ENV['XCS_PRODUCT']
end

def testflight_token
  ENV['CMD_API_TOKEN']
end

def testflight_team_token
  ENV['CMD_TEAM_TOKEN']
end

def testflight_distribution_lists
  ENV['CMD_DISTRIBUTION_LISTS']
end

def dsym_path_before_zip
  File.join(ENV['XCS_ARCHIVE'], 'dSYMs', "#{product_name}.app.dSYM")
end

def dsym_path_after_zip
  File.join('/tmp', "#{bot_name}.dsym.zip")
end

def zip_dsym
  FileUtils.rm_f(dsym_path_after_zip)
  system("/usr/bin/zip -r \"#{dsym_path_after_zip}\" \"#{dsym_path_before_zip}\"")
end

def curl_command
  command = [
    '/usr/bin/curl',
    '-F notes="Build uploaded automatically from Xcode."',
    '-F notify=False',
    "-F file=@\"#{ipa_path}\"",
    "-F dsym=@\"#{dsym_path_after_zip}\"",
    "-F api_token=\"#{testflight_token}\"",
    "-F team_token=\"#{testflight_team_token}\"",
    "-F distribution_lists=\"#{testflight_distribution_lists}\"",
    'http://testflightapp.com/api/builds.json'
  ]
  command.join(" ")
end

def upload
  system(curl_command)
end

raise 'Unable to create dsym.zip.' unless zip_dsym
raise 'Upload failed.' unless upload
