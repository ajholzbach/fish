function psmem
    ps aux | begin
        read -l header
        printf '%s\n' "$header"
        sort -nrk 4
    end
end
