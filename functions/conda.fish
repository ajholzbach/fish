function conda --wraps conda
    functions --erase conda

    set -l conda_exe
    if set -q CONDA_EXE; and test -x "$CONDA_EXE"
        set conda_exe "$CONDA_EXE"
    else if command -sq conda
        set conda_exe (command -s conda)
    end

    if test -z "$conda_exe"
        set -l prefixes \
            $HOME/miniforge3 $HOME/miniconda3 $HOME/anaconda3 $HOME/mambaforge \
            /opt/miniforge3 /opt/miniconda3 /opt/anaconda3 /opt/conda

        if command -sq brew
            set -l brew_prefix (brew --prefix ^/dev/null)
            set -a prefixes \
                $brew_prefix/Caskroom/miniforge/base \
                $brew_prefix/Caskroom/miniconda/base \
                $brew_prefix/Caskroom/mambaforge/base \
                $brew_prefix/Caskroom/anaconda/base
        end

        for p in $prefixes
            if test -x "$p/bin/conda"
                set conda_exe "$p/bin/conda"
                break
            end
        end
    end

    if test -z "$conda_exe"
        echo "conda: not found (checked \$PATH, CONDA_EXE, and common locations)" >&2
        return 127
    end

    $conda_exe "shell.fish" "hook" | source
    conda $argv
end
