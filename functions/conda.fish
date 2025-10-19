function conda --wraps conda
    functions --erase conda
    # >>> conda initialize >>>
    if test -f /opt/homebrew/Caskroom/miniforge/base/bin/conda
        eval /opt/homebrew/Caskroom/miniforge/base/bin/conda "shell.fish" "hook" | source
        conda $argv
    else if test -f "/opt/homebrew/Caskroom/miniforge/base/etc/fish/conf.d/conda.fish"
        . "/opt/homebrew/Caskroom/miniforge/base/etc/fish/conf.d/conda.fish"
    end
    # <<< conda initialize <<<
end
