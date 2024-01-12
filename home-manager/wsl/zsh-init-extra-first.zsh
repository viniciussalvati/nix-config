# Workaround to make wsl start in home in Windows Terminal
if [ "$(pwd)" = "/mnt/c/Windows/System32" ]
then
    cd ~
fi
