#!bin/sh

SCRIPT_DIR_PATH=$(cd $(dirname $0);pwd)

mkdir ~/.hammerspoon
ln -fns ${SCRIPT_DIR_PATH}/.hammerspoon/init.lua ~/.hammerspoon/init.lua

if [ "$(uname)" == 'Darwin' ]; then

  # Homebrewで管理しているパッケージをインストールする
  # ref: https://tech.gootablog.com/article/homebrew-brewfile/
  brew bundle

  # マウスカーソルの速度を速くする
  defaults write "Apple Global Domain" com.apple.mouse.scaling 8

  # アプリの整列
  defaults write com.apple.dock ResetLaunchPad -bool true\nkillall Dock

  # Finderで隠しファイルを表示する
  defaults write com.apple.finder AppleShowAllFiles -bool true

  # Xcodeでビルドにかかった時間を表示する
  defaults write com.apple.dt.Xcode ShowBuildOperationDuration -bool true

  # シミュレータにタップジェスチャーを表示する
  defaults write com.apple.iphonesimulator ShowSingleTouches 1

  # Swiftプロジェクトのビルドを速くする
  defaults write com.apple.dt.XCBuild EnableSwiftBuildSystemIntegration 1

  # SystemUIServerを再起動して設定を反映させる
  killall SystemUIServer

fi

