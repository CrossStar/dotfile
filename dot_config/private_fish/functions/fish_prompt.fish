function fish_prompt
    # 2. 用户名@主机名 (明亮绿)
    set_color brgreen
    echo -n (whoami)'@'(hostname)

    # 3. 路径 (黄色)
    set_color yellow
    echo -n ' ' (pwd)

    # 4. Git 分支 (青色/红色)
    if git rev-parse --is-inside-work-tree >/dev/null 2>&1
        set_color cyan
        echo -n ' ('
        set_color red
        echo -n (git branch --show-current)
        set_color cyan
        echo -n ')'
    end

    # 5. 提示符符号
    set_color normal
    echo -n ' $ '
end
