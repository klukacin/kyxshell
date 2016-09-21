START_TIME=$SECONDS

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
echo "Brutalis script by KL"
echo "password: v8NGuckkU3qC"
if ask "Do you wish to dump a database maybe?" Y; then
  ssh korisnik2@212.92.195.14 'cd /usr/share/drupal7/ && ~/.composer/vendor/drush/drush/drush sql-dump > sites/default/files/dbdumps/db.sql'
fi
if ask "Do you wish to sync a database and files to staging server (known as croatia-staging.dev8.cc) maybe?" Y; then
rsync -r --info=progress2 korisnik2@212.92.195.14:/usr/share/drupal7/sites/default/files/. domains/croatia-staging.dev8.cc/public_html/sites/default/files/
fi
if ask "Do you wish to sync a database and files to dev server (known as croatia.dev8.cc) maybe?" Y; then
rsync -r --info=progress2 korisnik2@212.92.195.14:/usr/share/drupal7/sites/default/files/. public_html/sites/default/files/
fi
ELAPSED_TIME=$(($SECONDS - $START_TIME))
echo '----------------------------------------------------------------------------------------------'
echo '____________________ ____ ___________________  .____    .___  _________'
echo '\______   \______   \    |   \__    ___/  _  \ |    |   |   |/   _____/'
echo ' |    |  _/|       _/    |   / |    | /  /_\  \|    |   |   |\_____  \ '
echo ' |    |   \|    |   \    |  /  |    |/    |    \    |___|   |/        \'
echo ' |______  /|____|_  /______/   |____|\____|__  /_______ \___/_______  /'
echo '        \/        \/                         \/        \/           \/ '
echo 'All done by Brutalis script and your puny contribution in '$ELAPSED_TIME' Seconds... HURAAAJ!!'
echo '----------------------------------------------------------------------------------------------'
