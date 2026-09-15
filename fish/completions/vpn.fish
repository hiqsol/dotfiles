# Config names and subcommands come from `vpn --complete`, so this stays in
# sync with the alias table in bin/vpn without duplicating it.
complete -c vpn -f
complete -c vpn -n '__fish_is_first_token' -a '(vpn --complete)'
complete -c vpn -n '__fish_seen_subcommand_from show' -a '(vpn --complete)'
complete -c vpn -n '__fish_seen_subcommand_from logs' -s f -l follow -d 'follow the journal'
