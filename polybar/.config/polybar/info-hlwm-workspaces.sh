#!/usr/bin/env bash

herbstclient --idle "tag_*" 2>/dev/null | {

    while true; do
        # Read tags into $tags as array
        IFS=$'\t' read -ra tags <<< "$(herbstclient tag_status)"
        {
            for i in "${tags[@]}" ; do
                LABEL=${i:1}
                # Read the prefix from each tag and render them according to that prefix
                case ${i:0:1} in
                    '#')
                        # the tag is viewed on the focused monitor
                        # Underline with green
                        echo "%{u#9fbc00}"
                        ;;
                    ':')
                        # : the tag is not empty
                        # Output as is
                        ;;
                    '!')
                        # ! the tag contains an urgent window
                        # Red text
                        echo "%{F#e60053}"
                        ;;
                    '-')
                        # - the tag is viewed on a monitor that is not focused
                        # Underline with green
                        echo "%{u#9fbc00}"
                        ;;
                    '.')
                        # . the tag is empty
                        echo "%{F-}%{B-}"
                        LABEL="·"
                        ;;
                esac

                echo "%{A1:herbstclient use ${i:1}:} ${LABEL} %{A -u -o F- B-}"
            done

            echo "%{F-}%{B-}"
        } | tr -d "\n"

    echo

    # wait for next event from herbstclient --idle
    read -r || break
done
} 2>/dev/null
