status is-interactive; or exit

# fzf --fish takes about 6 ms, so run it on the first press of an fzf key
function __fzf_load -a widget
    functions -e __fzf_load __fzf_check
    for mode in default insert
        bind -M $mode -e \cr \ct \ec
        bind -M $mode -e $__fzf_load_btab
    end
    set -e __fzf_load_btab
    command -q fzf; and fzf --fish | source
    set -q widget[1]; or return
    if functions -q $widget
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

# Check at the first prompt, after config.fish has set PATH
function __fzf_check --on-event fish_prompt
    functions -e __fzf_check
    command -q fzf; or __fzf_load
end
