# 基础设置
set -g fish_greeting ""
set -g fish_prompt_pwd_dir_length 0

# 只在交互式 shell 中加载这些配置
if status is-interactive
    set -gx EDITOR micro

    bind \cl history-token-search-backward
    bind \co y-pick

    if command -q bat
        abbr -a --position anywhere -- --help '--help 2>&1 | bat -plhelp'
        abbr -a --position anywhere -- -h '-h 2>&1 | bat -plhelp'
    end

    abbr -a ef 'chezmoi edit ~/.config/fish/config.fish && chezmoi apply'
    abbr -a sf 'source ~/.config/fish/config.fish'

    if command -q eza
        alias ls='eza --icons --group-directories-first'
        alias ll='eza -lh --icons --git --group-directories-first'
        alias la='eza -a --icons --group-directories-first'
    end

    function y-pick
        if not command -q yazi
            echo "yazi not found"
            return 127
        end

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
end

# VS Code / WSL code 命令
set -l vscode_win_path "/mnt/d/Microsoft VS Code/bin/code"

if test -x "$vscode_win_path"
    function code
        "/mnt/d/Microsoft VS Code/bin/code" $argv
    end
else if command -q code.exe
    function code
        code.exe $argv
    end
end

# zoxide
if command -q zoxide
    zoxide init fish | source
end
