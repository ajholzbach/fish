function cd --wraps cd
    functions --erase cd
    if command -q zoxide
        zoxide init --cmd cd fish | source
    else
        __source_fish_function cd
    end
    cd $argv
end
