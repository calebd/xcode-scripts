# Xcode Bot Scripts

Helpful scripts for Xcode bots.

# Environment Variables

Here are some useful Xcode bot environment variables:

- `XCS_OUTPUT_DIR`: Where the Xcode bot stores the current integration. All output files can be found here.
- `XCS_BOT_NAME`: The name of the bot.
- `XCS_ARCHIVE`: This is the *full path* to the `.xcarchive` file. You do not need to construct this path relative to the output directory.
- `XCS_PRODUCT`: For iOS apps, this is the path to the resulting `.ipa` file. You should construct a full path to this file relative to the output directory.
