#  bfimumps

A brainfuck interpreter in MUMPS I wrote one Sunday morning. Because, why not?

See [BfInterpreter.m](./src/BfInterpreter.m), if you dare.

## How to run it (under Ubuntu / WSL)

```bash
# Install fis-gtm, an open source MUMPS distribution
sudo apt install fis-gtm

# fis-gtm doesn't add any binaries to your /usr/bin
# Source gtmprofile to setup your environment variables correctly
source /usr/lib/x86_64-linux-gnu/fis-gtm/V6.3-007_x86_64/gtmprofile

# Like some other archaic languges (e.g Go) MUMPS requires your source files to be in a certain folder
# Luckily more modern distributions allow you to configure this with a magic environment variable
# Append the source directory to $gtmroutines
cd src
gtmroutines="$gtmroutines $(eval pwd)"

mumps -run BfInterpreter
```

You can use `tail -f out.txt` to observe the output while the interpreter is still doing stuff.

## Greetz

- `hello.bf` is from Wikipedia
- `mandelbrot.bf` was written by Erik Bosman
- [Skrolli](https://skrolli.fi/en/) magazine for inspiration

## License

Please do not use this for anything. Regardless, see [license.txt](license.txt).