# --- IDE SYNTAX HIGHLIGHTING & AUTOSUGGESTIONS ---
eval "$(zoxide init zsh)"
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
PROMPT='%F{green}%n@%m%f:%F{cyan}%~%f %# '
neofetch
[[ -s /home/khoa/.cache/yay/autojump/pkg/autojump/etc/profile.d/autojump.sh ]] && source /home/khoa/.cache/yay/autojump/pkg/autojump/etc/profile.d/autojump.sh
	autoload -U compinit && compinit -u
#Custom alias
alias ls="exa -l"
alias goc="cd ~/Coding/Backend/C"
alias {gocpp,goc++}="cd ~/Coding/Backend/C++"
alias {gopy,gopython}="cd ~/Coding/Backend/Python"
alias codingc="cd ~/Coding/Backend/C && nvim"
alias {codingcpp,codingc++}="cd ~/Coding/Backend/C++ && nvim"
alias {codingpy,codingpython}="cd ~/Coding/Backend/Python && nvim"
run() {
    local file="$1"
    
    if [[ ! -f "$file" ]]; then
        echo "Error: File '$file' not found."
        return 1
    fi

    # Extract name without extension
    local output_name="${file%.*}"

    case "$file" in
        *.c)
            gcc "$file" -o "$output_name" && ./"$output_name"
            ;;
        *.cpp|*.cc|*.cxx)
            g++ "$file" -o "$output_name" && ./"$output_name"
            ;;
        *.py)
            python "$file"
            ;;
        *)
            echo "Error: Unsupported file extension."
            return 1
            ;;
    esac
}
# Custom colors for syntax
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)
# Adjust colors to match Catppuccin / IDE style
ZSH_HIGHLIGHT_STYLES[command]='fg=#89b4fa,bold'           # Valid commands -> Blue & Bold
ZSH_HIGHLIGHT_STYLES[alias]='fg=#89b4fa,bold'             # Aliases -> Blue & Bold
ZSH_HIGHLIGHT_STYLES[builtin]='fg=#89b4fa,bold'           # Shell builtins -> Blue
ZSH_HIGHLIGHT_STYLES[function]='fg=#89b4fa,bold'          # Functions -> Blue
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=#f38ba8,bold'      # Incorrect/Errors -> Red & Bold
ZSH_HIGHLIGHT_STYLES[path]='fg=#94e2d5,underline'         # Valid file paths -> Cyan & Underlined
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=#f9e2af'   # Flags like -la -> Yellow
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=#f9e2af'   # Flags like --help -> Yellow
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=#a6e3a1' # 'Strings' -> Green
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=#a6e3a1' # "Strings" -> Green
#CLI Agents
export PATH=/home/khoa/.kilo/bin:$PATH


# Added by Antigravity CLI installer
export PATH="/home/khoa/.local/bin:$PATH"
