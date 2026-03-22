function mise
    set file $HOME/.local/bin/mise

    if not test -x $file
        $HOME/.config/bin/install-mise
    end

    $file $argv
end
