HISTFILE=~/.zhistory
HISTSIZE=10000
SAVEHIST=10000

setopt appendhistory autocd extendedglob nomatch notify
bindkey -e
zstyle :compinstall filename '/home/ikawa/.zshrc'

#zstyle ':completion:*' verbose yes
#zstyle ':completion:*:descriptions' format '%B%d%b'
#zstyle ':completion:*:messages' format '%d'
#zstyle ':completion:*:warnings' format 'No matches for: %d'
#zstyle ':completion:*' group-name ''

autoload -Uz add-zsh-hook
autoload -Uz compinit; compinit
autoload -U colors; colors
setopt complete_in_word
setopt correct
setopt list_packed        # 補完候補を詰めて表示する
setopt list_rows_first    # 補完候補を水平方向に表示する
setopt list_types         # 補完候補にファイルの種類を表示する
setopt extended_history   # コマンドの実行時刻を記録する
setopt hist_ignore_dups   # 直前と同じコマンドは記録しない
setopt hist_reduce_blanks # 余分なスペースを無視する
setopt inc_append_history # 複数のセッションで実効順に記録する
setopt share_history      # historyファイルを複数のセッションで参照する
setopt hist_no_store      # historyコマンドを記録しない
setopt hist_ignore_space  # 行頭がスペースのコマンドは記録しない
setopt no_beep
setopt nolistbeep
setopt auto_pushd         # cdコマンドでpushdする
setopt cdable_vars        # 絶対パスが入った変数をディレクトリとみなす
setopt numeric_glob_sort  # ファイル名を数値としてソート
setopt auto_resume        # 実行中のjobを１文字で指定

## ブランチ
autoload -Uz vcs_info
zstyle ':vcs_info:*' formats '[%b]'
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd () {
  psvar=()
  LANG=en_US.UTF-8 vcs_info
  [[ -n "$vcs_invo_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}

## プロンプト
if [[ $TERM = dumb || $TERM = emacs ]] {
  export PROMPT="[%n@%m]%(!.#.$) "
  export RPROMPT="[%(5~,%-2~/.../%2~,%~)]"
} else {
  local DEFAULT=$'%{\e[m%}'
  export PROMPT="%{$fg[green]%}[%n@%m]%(!.#.$) "$DEFAULT
  export RPROMPT="%1(v|%F{green}%1v%f|)%{$fg[yellow]%}[%(5~,%-2~/.../%2~,%~)]"$DEFAULT
  export SPROMPT="%{$fg[red]%} '%R' -> '%r' ? [nyae]: "$DEFAULT
}

## vcs_info
autoload -Uz vcs_info
zstyle ':vcs_info:*' formats '%F{yellow}[%S(%b:%s)]%f'
zstyle ':vcs_info:*' actionformats '%F{red}[%S(%b|%a:%s)]%f'
function _update_vcs_info_msg() {
#    LANG=en_US.UTF-8 vcs_info
#    RPROMPT="${vcs_info_msg_0}"
}
add-zsh-hook precmd _update_vcs_info_msg

## coreファイルを抑制する
unlimit
limit core 0
limit -s

## グローバルエイリアス
alias -g M='|more'
alias -g H='|head'
alias -g T='|tail'
alias -g G='|grep'
alias -g GI='|grep -i'
alias -g ....='../..'

## エイリアス
alias ls="ls -G"
alias ll="ls -lh"
alias la="ls -alh"
alias vi='vim'

typeset -U path cdpath fpath manpath # 変数の重複する値を削除

bindkey "^P" history-beginning-search-backward

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
