# Add Homebrew to PATH if it is present
# source: https://docs.brew.sh/Homebrew-on-Linux
test -d ~/.linuxbrew && eval "$(~/.linuxbrew/bin/brew shellenv)"
test -d /home/linuxbrew/.linuxbrew && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
