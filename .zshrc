bindkey -e          # Emacs風キーバインド

# コマンド履歴
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
bindkey '^r' history-incremental-pattern-search-backward
bindkey '^s' history-incremental-pattern-search-forward
autoload -Uz history-search-end
zle -N history-beginning-search-backward-end history-search-end
bindkey '^o' history-beginning-search-backward-end

# cd
#setopt AUTO_CD      # cdコマンドを省略して、ディレクトリ名で移動
#setopt AUTO_PUSHD   # cdコマンドでpushd、移動履歴を自動的に保存する
#setopt PUSHD_IGNORE_DUPS    # pushdの重複を避ける
autoload -Uz add-zsh-hook
autoload -Uz chpwd_recent_dirs cdr
add-zsh-hook chpwd chpwd_recent_dirs
zstyle ":chpwd:*" recent-dirs-max 200
zstyle ":chpwd:*" recent-dirs-default true

# zmv
autoload -Uz zmv
alias zmv='noglob zmv -W'

# 補完機能を有効にする
fpath=(/usr/local/share/zsh-completions $fpath)
autoload -Uz compinit
compinit
zstyle ':completion:*:default' menu select=2
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# 単語区切りの設定
autoload -Uz select-word-style
select-word-style default
zstyle ':zle:*' word-chars " /=;@:{},|"
zstyle ':zle:*' word-style unspecified

# プロンプト
PROMPT="[%n@%m](%*%) %~ %# "
RPROMPT="[%~]"

# vcs_info
autoload -Uz vcs_info
zstyle ':vcs_info:*' formats '%F{green}[%S(%b:%s)]%f'
zstyle ':vcs_info:*' actionformats '%F{red}[%S(%b|%a:%s)]%f'
function _update_vcs_info_msg() {
  LANG=en_US.UTF-8 vcs_info
  RPROMPT="${vcs_info_msg_0_}"
}
add-zsh-hook precmd _update_vcs_info_msg

# Syntax Highlight
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# 不要な機能を無効
# setopt IGNORE_EOF   # ^Dでzshを終了しない
setopt NO_FLOW_CONTROL  # ^Q/^Sのフローコントロールを無効
setopt NO_BEEP  # BEEP音を鳴らさない

# エイリアス(コマンドを置き換える)
alias ls='ls -F'    # ディレクトリ名には/をつける
alias la='ls -a'    # 隠しファイルも表示する
alias ll='ls -l'    # リスト表示

alias rm='rm -i'    # 削除確認
alias cp='cp -i'
alias mv='mv -i'

alias mkdir='mkdir -p'  # 再帰的にディレクトリを作成

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# グローバルエイリアス(コマンドのどの位置でも置きかわる)
alias -g L='| less'
alias -g H='| head'
alias -g T='| tail'
alias -g G='| grep'
alias -g N='> /dev/null'
alias -g V='| vim -R -'
alias -g P=' --help | less'

# コマンド履歴をpecoで検索して実行する
function peco-execute-history() {
  local item
  item=$(builtin history -n -r 1 | peco --query="$LBUFFER")
  if [[ -z "$item" ]]; then
    return 1
  fi
  BUFFER="$item"
  CURSOR=$#BUFFER
}
zle -N peco-execute-history
bindkey '^x^r' peco-execute-history

# 最近移動したディレクトリをpecoで検索して移動する
function peco-cdr() {
  local item
  item=$(cdr -l | sed 's/^[^ ]\{1,\} \{1,\}//' | peco)
  if [[ -z "$item" ]]; then
    return 1
  fi
  BUFFER="cd -- $item"
  zle accept-line
}
zle -N peco-cdr
bindkey '^xb' peco-cdr

