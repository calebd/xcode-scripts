require 'fileutils'

def ipa_path
 File.join(ENV['XCS_OUTPUT_DIR'], ENV['XCS_PRODUCT'])
end

def bot_name
  ENV['XCS_BOT_NAME']
end

def product_name
  ENV['PRODUCT_NAME']
end

def hockey_token
  ENV['CMD_HOCKEY_TOKEN']
end

def dsym_path_before_zip
  File.join(ENV['XCS_ARCHIVE'], 'dSYMs', "#{product_name}.app.dSYM")
end

def dsym_path_after_zip
  File.join('/tmp', "#{bot_name}.dsym.zip")
end

def zip_dsym
  FileUtils.rm_f(dsym_path_after_zip)
  system("/usr/bin/zip -r #{dsym_path_after_zip} #{dsym_path_before_zip}")
end

def curl_command
  command = [
    '/usr/bin/curl',
    '-F status=2',
    '-F notify=0',
    "-F ipa=@\"#{ipa_path}\"",
    "-F dsym=@\"#{dsym_path_after_zip}\"",
    "-H \"X-HockeyAppToken: #{hockey_token}\"",
    'https://rink.hockeyapp.net/api/2/apps/upload'
  ]
  command.join(" ")
end

def upload
  system(curl_command)
end

raise 'Unable to create dsym.zip.' unless zip_dsym
raise 'Upload failed.' unless upload
