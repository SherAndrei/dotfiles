
# see zshcompsys(1) for more

# source: https://github.com/ohmyzsh/ohmyzsh/blob/6e7ac0544e71c7b777746cb50f70de68c6495b86/lib/completion.zsh

# fixme - the load process here seems a bit bizarre
zmodload -i zsh/complist

WORDCHARS=''

# see zshoptions(1) for more

# do not autoselect the first completion entry as in MC-Windows cmd.exe
unsetopt MENU_COMPLETE
# disalbe flow control characters '^S' and '^Q' cause they are mostly useless
# see https://www.gnu.org/software/screen/manual/html_node/Flow-Control-Summary.html
unsetopt FLOW_CONTROL
# Show completion menu on successive tab press
setopt AUTO_MENU
# Leave cursor inplace until completion is successful
setopt COMPLETE_IN_WORD
# Move cursor to the end after successful completion
setopt ALWAYS_TO_END

# should this be in keybindings?
bindkey -M menuselect '^o' accept-and-infer-next-history
zstyle ':completion:*:*:*:*:*' menu select

# Complete . and .. special directories
zstyle ':completion:*' special-dirs true

zstyle ':completion:*' list-colors ''
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'

if [[ "$OSTYPE" = solaris* ]]; then
  zstyle ':completion:*:*:*:*:processes' command "ps -u $USERNAME -o pid,user,comm"
else
  zstyle ':completion:*:*:*:*:processes' command "ps -u $USERNAME -o pid,user,comm -w -w"
fi

# disable named-directories autocompletion
zstyle ':completion:*:cd:*' tag-order local-directories directory-stack path-directories

# Use caching so that commands like apt and dpkg complete are useable
# Default value of path is in '${HOME}/.zcompcache' if ZDOTDIR is not defined
zstyle ':completion:*' use-cache yes

# Don't complete uninteresting users
zstyle ':completion:*:*:*:users' ignored-patterns \
        adm amanda apache at avahi avahi-autoipd beaglidx bin cacti canna \
        clamav daemon dbus distcache dnsmasq dovecot fax ftp games gdm \
        gkrellmd gopher hacluster haldaemon halt hsqldb ident junkbust kdm \
        ldap lp mail mailman mailnull man messagebus mldonkey mysql nagios \
        named netdump news nfsnobody nobody nscd ntp nut nx obsrun openvpn \
        operator pcap polkitd postfix postgres privoxy pulse pvm quagga radvd \
        rpc rpcuser rpm rtkit scard shutdown squid sshd statd svn sync tftp \
        usbmux uucp vcsa wwwrun xfs '_*'

# ... unless we really want to.
zstyle '*' single-ignored show

# look for 'autoload' in zshbuiltins(1)
# and for 'Autoloading functions' in zshmisc(1)
# automatically load bash completion functions if they were not defined
autoload -U  +X bashcompinit && bashcompinit
