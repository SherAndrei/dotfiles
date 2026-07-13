# Add Homebrew to PATH if it is present
# source: https://docs.brew.sh/Homebrew-on-Linux
test -d ~/.linuxbrew && eval "$(~/.linuxbrew/bin/brew shellenv)"
test -d /home/linuxbrew/.linuxbrew && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# Disable autoupdates since they are useless most of the times
export HOMEBREW_NO_AUTO_UPDATE=1
