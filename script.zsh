#!/usr/bin/env zsh

set ERR_RETURN

local here=$(dirname $0)

preexec-print() { print -n '• '; print $2 }
autoload -U add-zsh-hook
add-zsh-hook preexec preexec-print # print all our commands from here-on-out

# - - -

brew uninstall --force `# uninstall multiple versions` git
curl https://raw.githubusercontent.com/Homebrew/homebrew/7f25b0865af022f56cc9067be989a548fd34733e/Library/Formula/git.rb >! ${here}/git.rb
brew install ${here}/git.rb

brew uninstall --force `# uninstall multiple versions` carthage
curl https://raw.githubusercontent.com/Homebrew/homebrew/a8713e1955823abed7d68e1f8e0e330e98a90afa/Library/Formula/carthage.rb >! ${here}/carthage.rb
brew install --build-from-source --HEAD ${here}/carthage.rb

unset ERR_RETURN

which git
git --version

which carthage
carthage version

echo 'github "antitypical/Result" == 2.0.0' >! Cartfile
carthage bootstrap --no-build || carthage bootstrap --verbose --no-build
