## Steam

Instructions came from [this video](https://www.youtube.com/watch?v=qlfm3MEbqYA), which also links to [this repo](https://github.com/vimjoyer/nixos-gaming-video).

### Setup

To enable steam:
- Make sure the graphics cards drivers are working. See [instructions](./graphics-cards.md) for graphics cards.
- Add this line to your host config 
  ```nix
  programs.steam.enable = true;
  ```
- Restart the session or machine to get the new env variables
- Run `protonup` to install proton

### Setup games

Once a game is installed, configure the games to use one of the following:
- `gamemoderun %command%` - Starts games with a micro-compositor to improve games and fix issues.
- `mangohud %command%` - Program to monitor systems status (CPU and GPU load and temp, RAM, FPS, etc).
- `gamescope %command%` - Improves game performance by temporarily applying optimizations to the OS and game process.

I still don't know how to use more than one at a time.
