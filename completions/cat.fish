if type --query bat
    complete --erase --command cat
    complete --command cat --wraps bat
else
    status get-file completions/cat.fish | source
end
