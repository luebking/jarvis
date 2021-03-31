J.A.R.V.I.S.
============
#### Just Another Runner Validating Infinite Support

J.A.R.V.I.S. offers an auto-hiding, auto-expanding single line zsh terminal.
Pressing F11 will toggle a 100x32 window (so you can see more stuff)

There's a crude desktop service launcher function:
**launch** comes with an autocomplete and runs the services applications tend to
install in /usr/share/applications (or you add to ~/.local/share/applications)

### Why is this better than rofi/dmenu or <genericquakestyleterminalimplementation>?
It's not the same as either.
* rofi & dmenu are good runners, but they don't allow you to quickly look at or edit
files, read a manpage, … without yet another window. Also you can't autocomplete
paths in their prompt.
* Quake-a-like terminals provide you with an actual interactive shell and are much
more similar to J.A.R.V.I.S., but the window is usually either too small (to
less a file) or too big (to just run a process) and in the way.

### WARNING (well, kinda):
J.A.R.V.I.S. shadows common binaries to alter the window size and run them w/
predefined parameters or pipes them into less.
The point is to have convenient invocation of features you know and probably
use, **not** to provide a "regular" interactive shell.
As a result, your local shell functions and aliases _might_ behave in unexpected
ways and seem broken. In doubt, bypass jarvis by invoking the absolute path, eg.
_/usr/bin/less_ instead of _less_

## Requirements
* zsh
* urxvt
* xdotool
* redshift (optional)

## Installation
Run install.sh as root and then bind /usr/bin/jarvis to some shortcut in
whatever shortcut daemon you use.
J.A.R.V.I.S. is smart enough to activate or toggle the window depending on its
current state.

## Configuration
You can copy the "config" file in the repo to ~/.config/jarvis and edit it to
your liking. See comments in that file on details.

## Extension
J.A.R.V.I.S. sources files from /usr/share/jarvis/funcs.d and ~/.local/share/jarvis/funcs.d
You can look up the provided ones and add your own. Done.
**Notice:** if you intend to shadow a binary, the common noob error is to call the
binary in the function w/o the absolute path which will not work and create a
recursion because *foo* is no longer resolved from */usr/bin/foo* but the function
you just added that ends up calling itself…
If you're not a noob but just not paying attention to what you do, relax:
This happened to me much more than once in my life ;-)

## Disclaimer:
If you're Tony Stark and you want to sue me, you're welcome.
If you're not Tony Stark, but a stupid Mouse posing as Tony Stark, go fuck yourself.
If you're Jon Favreau, thanks for making stuff that does not suck. And for Luke.
