function ask() {
    # http://djm.me/ask - see this link for information about the ask function
    while true; do

        if [ "${2:-}" = "Y" ]; then
            prompt="Y/n"
            default=Y
        elif [ "${2:-}" = "N" ]; then
            prompt="y/N"
            default=N
        else
            prompt="y/n"
            default=
        fi

        read -p "$1 [$prompt] " REPLY </dev/tty

        if [ -z "$REPLY" ]; then
            REPLY=$default
        fi

        case "$REPLY" in
            Y*|y*) return 0 ;;
            N*|n*) return 1 ;;
        esac
    done
}
