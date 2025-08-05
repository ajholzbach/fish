function cat --wraps cat
    functions --erase cat
    if type -q bat
        alias cat='bat --paging=never --style=plain --color=always'
    end
    cat $argv
end
