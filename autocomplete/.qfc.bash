##qfc https://github.com/pindexis/qfc
[[ -s "$HOME/.qfc/bin/qfc.sh" ]] && source "$HOME/.qfc/bin/qfc.sh"

qfc_quick_command 'cd' '\C-b' 'cd $0'
qfc_quick_command 'vim' '\C-p' 'vim $0'

