host="$root/host"

if [[ ! -f "$host" ]]; then
    echo "No \"$root/host\" file found. Add a \"host\" file to the root of the repo with the name of the host in flake.nix you wish to use".
    exit 2
fi

host=$(cat $root/host)

if [[ "$host" == "" ]]; then
    echo "File \"$root/host\" is empty. Add a \"host\" file to the root of the repo with the name of the host in flake.nix you wish to use".
    exit 2
fi
