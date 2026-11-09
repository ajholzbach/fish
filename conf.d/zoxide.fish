status is-interactive; or exit

# zoxide init takes about 5 ms, so run it on the first cd or cd Tab
function __zoxide_load
    functions -e __zoxide_load __zoxide_check cd
    complete -e -c __zoxide_z
    command -q zoxide; and zoxide init --cmd cd fish | source
    functions -q cd; and return
    # zoxide is missing or its init failed, so restore fish's cd
    complete -e -c cd
    __source_fish_function cd completions
    __source_fish_function cd
    return 1
end

# Without a wrap, fish marks zoxide queries as bad paths
function cd --wraps __zoxide_z
    functions -e cd
    __zoxide_load
    cd $argv
end
complete -c __zoxide_z -f -a '(__zoxide_load; and __zoxide_z_complete)'

# Check at the first prompt, after config.fish has set PATH
function __zoxide_check --on-event fish_prompt
    functions -e __zoxide_check
    command -q zoxide; or __zoxide_load
end
