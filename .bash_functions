# Functions shared by all shells


function start_an_activity
{
    # if [ ${UID} -ne 0 ]
    # then
    #     echo "No root privilege, exiting." >&2
    #     return 1
    # fi
    if [ -f /tmp/during_an_activity ]
    then
        echo "You have started an activity, please finish it first." >&2
        return 2
    else
        echo "Starting an activity"
        (
             trap "echo 'HaHa'" SIGTERM
             touch /tmp/during_an_activity
             sleep 5s && echo "The break is due in 10 seconds" && sleep 10s && xrandr --output eDP1 --brightness 0.0 && sleep 5s && xrandr --output eDP1 --brightness 1.0 && echo "An activity has ended."
             rm /tmp/during_an_activity
        )
    fi
}
