function claude --wraps=claude
    if command -q brew
        set -l brew_prefix (brew --prefix 2>/dev/null)
        if test -n "$brew_prefix" -a -x "$brew_prefix/bin/claude"
            $brew_prefix/bin/claude $argv
            return
        end
    end

    command claude $argv
end
