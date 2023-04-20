function parse_parameter {
    name=$1
    value="$2"

    if [[ "$value" == "" ]]; then
        # [[ "$2" == "" ]] && msg="Missing parameter" || msg="$2"
        msg=${3:-"Missing parameter \"$name\""}
        echo -e "$msg" >&2
        exit 1
    fi

    export $name="$value"
}