set t_Co=256
set nocompatible
set tabstop=4
set shiftwidth=4
set expandtab
set softtabstop=4
set showmatch
set noautoindent
set wildmode=list:longest
set hlsearch
set backspace=2
set laststatus=2
set wildmenu
set whichwrap=b,s,h,l,<,>,[,]
syntax on

" 文字コードの自動認識
if &encoding !=# 'utf-8'
  set encoding=japan
  set fileencoding=japan
endif
if has('iconv')
  let s:enc_euc = 'euc-jp'
  let s:enc_jis = 'iso-2022-jp'
  " iconvがeucJP-msに対応しているかをチェック
  if iconv("\x87\x64\x87\x6a", 'cp932', 'eucjp-ms') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'eucjp-ms'
    let s:enc_jis = 'iso-2022-jp-3'
  " iconvがJISX0213に対応しているかをチェック
  elseif iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'euc-jisx0213'
    let s:enc_jis = 'iso-2022-jp-3'
  endif
  " fileencodingsを構築
  if &encoding ==# 'utf-8'
    let s:fileencodings_default = &fileencodings
    let &fileencodings = s:enc_jis .','. s:enc_euc .',cp932'
    let &fileencodings = &fileencodings .','. s:fileencodings_default
    unlet s:fileencodings_default
  else
    let &fileencodings = &fileencodings .','. s:enc_jis
    set fileencodings+=utf-8,ucs-2le,ucs-2
    if &encoding =~# '^\(euc-jp\|euc-jisx0213\|eucjp-ms\)$'
      set fileencodings+=cp932
      set fileencodings-=euc-jp
      set fileencodings-=euc-jisx0213
      set fileencodings-=eucjp-ms
      let &encoding = s:enc_euc
      let &fileencoding = s:enc_euc
    else
      let &fileencodings = &fileencodings .','. s:enc_euc
    endif
  endif
  " 定数を処分
  unlet s:enc_euc
  unlet s:enc_jis
endif

" 日本語を含まない場合は fileencoding に encoding を使うようにする
if has('autocmd')
  function! AU_ReCheck_FENC()
    if &fileencoding =~# 'iso-2022-jp' && search("[^\x01-\x7e]", 'n') == 0
      let &fileencoding=&encoding
    endif
  endfunction
  autocmd BufReadPost * call AU_ReCheck_FENC()
endif

" 改行コードの自動認識
set fileformats=unix,dos,mac

" □とか○の文字があってもカーソル位置がずれないようにする
if exists('&ambiwidth')
  set ambiwidth=double
endif

set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P

source $VIMRUNTIME/macros/matchit.vim

"colorscheme blue
"colorscheme darkblue
"colorscheme default
"colorscheme delek
"colorscheme desert
"colorscheme elflord
"colorscheme evening
"colorscheme koehler
"colorscheme morning
"colorscheme murphy
"colorscheme pablo
colorscheme peachpuff
"colorscheme ron
"colorscheme shine
"colorscheme slate
"colorscheme torte
"colorscheme zellner
"colorscheme h2u_black

"256 color scheme
"colorscheme adaryn
"colorscheme buttercream
"colorscheme denim
"colorscheme freya
"colorscheme maroloccio
"colorscheme oceandeep
"colorscheme simpleandfriendly
"colorscheme vividchalk
"colorscheme adrian
"colorscheme calmar256-dark
"colorscheme desert256
"colorscheme fruit
"colorscheme martin_krischik
"colorscheme oceanlight
"colorscheme softblue
"colorscheme vylight
"colorscheme aiseered
"colorscheme calmar256-light
"colorscheme desertEx
"colorscheme fruity
"colorscheme matrix
"colorscheme olive
"colorscheme soso
"colorscheme winter
"colorscheme anotherdark
"colorscheme camo
"colorscheme dusk
"colorscheme golden
"colorscheme molokai
"colorscheme papayawhip
"colorscheme spring
"colorscheme wombat
"colorscheme aqua
"colorscheme candy
"colorscheme dw_blue
"colorscheme guardian
"colorscheme moria
"colorscheme peaksea
"colorscheme summerfruit256
"colorscheme wombat256
"colorscheme astronaut
"colorscheme candycode
"colorscheme dw_cyan
"colorscheme habilight
"colorscheme moss
"colorscheme print_bw
"colorscheme synic
"colorscheme wood
"colorscheme asu1dark
"colorscheme chela_light
"colorscheme dw_green
"colorscheme herald
"colorscheme motus
"colorscheme pyte
"colorscheme tabula
"colorscheme wuye
"colorscheme autumn
"colorscheme chocolateliquor
"colorscheme dw_orange
"colorscheme impact
"colorscheme mustang
"colorscheme railscasts
"colorscheme tango
"colorscheme xemacs
"colorscheme autumn2
"colorscheme clarity
"colorscheme dw_purple
"colorscheme inkpot
"colorscheme navajo-night
"colorscheme railscasts2
"colorscheme tango2
"colorscheme xoria256
"colorscheme autumnleaf
"colorscheme cleanphp
"colorscheme dw_red
"colorscheme ironman
"colorscheme navajo
"colorscheme rdark
"colorscheme taqua
"colorscheme zenburn
"colorscheme baycomb
"colorscheme colorer
"colorscheme dw_yellow
"colorscheme jammy
"colorscheme neon
"colorscheme relaxedgreen
"colorscheme tcsoft
"colorscheme zmrok
"colorscheme bclear
"colorscheme dante
"colorscheme earendel
"colorscheme jellybeans
"colorscheme neverness
"colorscheme robinhood
"colorscheme tir_black
"colorscheme biogoo
"colorscheme darkZ
"colorscheme eclipse
"colorscheme kellys
"colorscheme night
"colorscheme rootwater
"colorscheme tolerable
"colorscheme blacksea
"colorscheme darkblue2
"colorscheme ekvoli
"colorscheme leo
"colorscheme nightshimmer
"colorscheme satori
"colorscheme torte
"colorscheme bluegreen
"colorscheme darkbone
"colorscheme fine_blue
"colorscheme lettuce
"colorscheme no_quarter
"colorscheme sea
"colorscheme twilight
"colorscheme borland
"colorscheme darkslategray
"colorscheme fine_blue2
"colorscheme lucius
"colorscheme northland
"colorscheme settlemyer
"colorscheme two2tango
"colorscheme breeze
"colorscheme darkspectrum
"colorscheme fnaqevan
"colorscheme manxome
"colorscheme nuvola
"colorscheme sienna
"colorscheme vc
"colorscheme brookstream
"colorscheme dawn
"colorscheme fog
"colorscheme marklar
"colorscheme oceanblack
"colorscheme silent
"colorscheme vibrantink

let $LANG = 'ja'

" 空白文字の見える化
if has("syntax")
    syntax on
    function! ActivateInvisibleIndicator()
        syntax match InvisibleJISX0208Space "　" display containedin=ALL
        highlight InvisibleJISX0208Space term=underline ctermbg=Blue guibg=Blue
        syntax match InvisibleTrailedSpace "[ \t]\+$" display containedin=ALL
        highlight InvisibleTrailedSpace term=underline ctermbg=Red guibg=Red
        syntax match InvisibleTab "\t" display containedin=ALL
        highlight InvisibleTab term=underline ctermbg=Cyan guibg=Cyan
    endf
    augroup invisible
        autocmd! invisible
        autocmd BufNew,BufRead * call ActivateInvisibleIndicator()
    augroup END
endif

set clipboard=unnamed
"入力モード時、ステータスラインのカラーを変更
augroup InsertHook
autocmd!
autocmd InsertEnter * highlight StatusLine guifg=#CCDC90 guibg=#2E4340
autocmd InsertLeave * highlight StatusLine guifg=#2E4340 guibg=#CCDC90
augroup END

set helplang=ja,en
set nobackup


