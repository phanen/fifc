function _fifc_source_files -d "Return a command to recursively find files"
    set -l path (_fifc_path_to_complete)
    set -l hidden (string match "*." "$path")

    if type -q fd
        if test "$path" = {$PWD}/
            echo "fd . --color=always --strip-cwd-prefix $fifc_fd_opts"
        else if test "$path" = "."
            echo "fd . --color=always --strip-cwd-prefix --hidden $fifc_fd_opts"
        else if test -n "$hidden"
            echo "fd . --color=always --hidden $fifc_fd_opts $path"
        else
            echo "fd . --color=always $fifc_fd_opts $path"
        end
    else if test -n "$hidden"
        echo "find . $path -not -path '*/.*' -print $fifc_find_opts | sed 's|^\./||'"
    else
        # Use sed to strip cwd prefix
        echo "find . $path -print $fifc_find_opts | sed 's|^\./||'"
    end
end
