function lt --wraps 'eza -aT'
    functions --erase lt
    if command -q eza
        alias lt='eza -aT --group-directories-first --icons=auto'
    end
    lt $argv
end
