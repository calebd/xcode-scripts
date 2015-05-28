# Xcode Scripts

Helpful scripts for Xcode.

# Bot Environment Variables

Here are some useful Xcode bot environment variables:

- `XCS_OUTPUT_DIR`: Where the Xcode bot stores the current integration. All output files can be found here.
- `XCS_BOT_NAME`: The name of the bot.
- `XCS_ARCHIVE`: This is the *full path* to the `.xcarchive` file. You do not need to construct this path relative to the output directory.
- `XCS_PRODUCT`: For iOS apps, this is the path to the resulting `.ipa` file. You should construct a full path to this file relative to the output directory.

# CocoaPods

Running CocoaPods in Xcode bots is easy. My `pod install` script looks like this:

```sh
export LC_ALL=en_US.UTF-8
cd ios
pod install
```

Note that the `cd` is environment specific. When you configure an Xcode bot, it tries to match your local environment as much as possible. In this case my code is located in `~/Documents/Code/north/tiiny/ios`. So when the bot clones the git repository, it will put it in a folder called `ios`.

# Deployment Scripts

I use the deployment scripts like this:

```sh
export LC_ALL=en_US.UTF-8
export CMD_HOCKEY_TOKEN=abcd1234
export CMD_PRODUCT_NAME=App
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/calebd/xcode-scripts/master/bot-scripts/hockey.rb)"
```

# Contributions

I welcome pull requests with any scripts you’d like to share with anyone! I’d like to make the process of setting up Xcode bots as easy as possible :)

Send any feedback to [@calebd](https://twitter.com/calebd).
