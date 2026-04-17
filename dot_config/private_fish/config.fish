
if status is-interactive
    bind \cl history-token-search-backward
    bind \co y-pick
end

set -U fish_greeting
set -U fish_prompt_pwd_dir_length 0

abbr -a --position anywhere -- --help '--help | bat -plhelp'
abbr -a --position anywhere -- -h '-h | bat -plhelp'
abbr -a ef 'micro ~/.config/fish/config.fish'
abbr -a sf 'source ~/.config/fish/config.fish'

alias ls='eza --icons --group-directories-first'
alias ll='eza -lh --icons --git --group-directories-first'
alias la='eza -a --icons --group-directories-first'

function y-pick
    set -l tmp (mktemp -t "yazi-picker.XXXXXX")
    yazi --chooser-file="$tmp"
    
    if test -f "$tmp"
        set -l chosen (command cat -- "$tmp")
        if test -n "$chosen"
            commandline -i "$chosen"
        end
    end
    
    rm -f -- "$tmp"
    
    commandline -f repaint
end

set -l vscode_win_path "/mnt/d/Microsoft VS Code/bin/code"

if test -f "$vscode_win_path"
    function code --wraps="$vscode_win_path"
        set -l bin_path "/mnt/d/Microsoft VS Code/bin/code"
        "$bin_path" $argv
    end
else
    set -l auto_path (which code.exe 2>/dev/null | sed 's/.exe//')
    if test -n "$auto_path"
        alias code="$auto_path"
    end
end

zoxide init fish | source
