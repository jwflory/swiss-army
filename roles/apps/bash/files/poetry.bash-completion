_poetry_9cf82bc144790825_complete()
{
    local cur script coms opts com
    COMPREPLY=()
    _get_comp_words_by_ref -n : cur words

    # for an alias, get the real script behind it
    if [[ $(type -t ${words[0]}) == "alias" ]]; then
        script=$(alias ${words[0]} | sed -E "s/alias ${words[0]}='(.*)'/\1/")
    else
        script=${words[0]}
    fi

    # lookup for command
    for word in ${words[@]:1}; do
        if [[ $word != -* ]]; then
            com=$word
            break
        fi
    done

    # completing for an option
    if [[ ${cur} == --* ]] ; then
        opts="--ansi --help --no-ansi --no-interaction --quiet --verbose --version"

        case "$com" in

            (about)
            opts="${opts} "
            ;;

            (add)
            opts="${opts} --allow-prereleases --dev --dry-run --extras --git --optional --path --platform --python"
            ;;

            (build)
            opts="${opts} --format"
            ;;

            (cache:clear)
            opts="${opts} --all"
            ;;

            (check)
            opts="${opts} "
            ;;

            (config)
            opts="${opts} --list --unset"
            ;;

            (debug:info)
            opts="${opts} "
            ;;

            (debug:resolve)
            opts="${opts} --extras --install --python --tree"
            ;;

            (develop)
            opts="${opts} "
            ;;

            (help)
            opts="${opts} --format --raw"
            ;;

            (init)
            opts="${opts} --author --dependency --description --dev-dependency --license --name"
            ;;

            (install)
            opts="${opts} --develop --dry-run --extras --no-dev"
            ;;

            (list)
            opts="${opts} --format --raw"
            ;;

            (lock)
            opts="${opts} "
            ;;

            (new)
            opts="${opts} --name --src"
            ;;

            (publish)
            opts="${opts} --build --password --repository --username"
            ;;

            (remove)
            opts="${opts} --dev --dry-run"
            ;;

            (run)
            opts="${opts} "
            ;;

            (script)
            opts="${opts} "
            ;;

            (search)
            opts="${opts} --only-name"
            ;;

            (self:update)
            opts="${opts} --preview"
            ;;

            (shell)
            opts="${opts} "
            ;;

            (show)
            opts="${opts} --all --latest --no-dev --outdated --tree"
            ;;

            (update)
            opts="${opts} --dry-run --lock --no-dev"
            ;;

            (version)
            opts="${opts} "
            ;;

        esac

        COMPREPLY=($(compgen -W "${opts}" -- ${cur}))
        __ltrim_colon_completions "$cur"

        return 0;
    fi

    # completing for a command
    if [[ $cur == $com ]]; then
        coms="about add build cache:clear check config debug:info debug:resolve develop help init install list lock new publish remove run script search self:update shell show update version"

        COMPREPLY=($(compgen -W "${coms}" -- ${cur}))
        __ltrim_colon_completions "$cur"

        return 0
    fi
}

complete -o default -F _poetry_9cf82bc144790825_complete poetry
complete -o default -F _poetry_9cf82bc144790825_complete /usr/bin/poetry
