function __source_fish_function -a name -d "Load Fish's own version of a function that a plugin shadows"
    if status get-file functions/$name.fish &>/dev/null
        status get-file functions/$name.fish | source
    else if test -f $__fish_data_dir/functions/$name.fish
        source $__fish_data_dir/functions/$name.fish
    end
end
