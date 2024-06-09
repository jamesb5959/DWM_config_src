# DWM_config_src

https://ffprofile.com/#start

Install by running - "sudo ./start"
start script only works with arch for now but can work with other linux disto's 
if dependencies are installed manually 

------------------------------------
ST font changed to 16  

ST patch list - alpha, scrollback
W3M patch is in patch folder but not applied. Doesn't work well with alpha pathc.
To apply do:
patch -p1 < patch/st-w3m-0.8.3.diff

ST Theme - everforest

------------------------------------
Mod key changed to MOD4  

DWM patch list - fullgaps, barpadding

keep it simple stupid wallpaper script for dwm  
updated and don't use KISSWP.sh instead use feh.

"xsessions" goes into /usr/share/

".xinitrc" Doesn't work with lighdm (or any other login managers) with "dwm.desktop"

To get the same functionality as ".xinitrc" the "dwm.desktop" uses a startup script similar to ".xinitrc" called "startdwm"

------------------------------------
DMENU patch list - alph, border, casinsensitive, center, highlight, highpriority

------------------------------------
VIM addons - coc.nvim, lightline, nerdtree, vim-polyglot

VIM Theme - everforest (made in terminal.sexy)

Change vim folder to .vim

------------------------------------
Hooks go into "/etc/libvirt/"
KVM XML needs to be edited to work with scripts. Works with supergfx

CPU isolating and pinning

For mux gpu with windows 10 or 11. 
