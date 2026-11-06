status is-interactive; or return

# fzf --fish costs about 10 ms, so load it on the first key press. Check for
# fzf only then, because config.fish runs after conf.d and may add it to PATH.
function __fzf_load -a widget
    functions -e __fzf_load
    for mode in default insert
        bind -M $mode -e \cr \ct \ec
        bind -M $mode -e $__fzf_load_btab
    end
    set -e __fzf_load_btab
    if command -q fzf
        fzf --fish | source
        $widget
    else
        commandline -f repaint
    end
end

if string match -qr -- '^\d\d+|^[4-9]' $version
    set -g __fzf_load_btab shift-tab
else
    set -g __fzf_load_btab -k btab
end
for mode in default insert
    bind -M $mode \cr '__fzf_load fzf-history-widget'
    bind -M $mode \ct '__fzf_load fzf-file-widget'
    bind -M $mode \ec '__fzf_load fzf-cd-widget'
    bind -M $mode $__fzf_load_btab '__fzf_load fzf_complete'
end
