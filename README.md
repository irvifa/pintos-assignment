# Pintos Assignment

## Preparation

```
sudo apt install qemu
zcat pintos.tar.gz | tar x
```

Note that I'm using `$HOME/workspace/pintos-assignment` as my workspace

Do `cd pintos/src/utils` and edit pintos-gdb `GDBMACROS=$HOME/workspace/pintos-assignment/pintos/src/misc/gdb-macros` 

Edit `Makefile` in the `utils` directory and replace `LDFLAGS = -lm` by `LDLIBS = -lm`

Compile `utils` directory using `make`

Do `cd ../threads` and edit `Make.vars`

Change `default simulator` to `SIMULATOR = –qemu`

Compile pintos kernel

Do `cd ../utils` edit `pintos` file change `default simulator` to `$sim = “qemu” if !defined $sim;`, replace `kernel.bin` to `$HOME/workspace/pintos-assignment/pintos/src/threads/build/kernel.bin` (in my case it will be `/home/irvi/workspace/pintos-assignment/pintos/src/threads/build/kernel.bin`, change line no. 623 to ` my (@cmd) = (‘qemu-system-x86_64’);`

Edit `Pintos.pm` replace `loader.bin` to `$HOME/workspace/pintos-assignment/pintos/src/threads/build/loader.bin`

Add env variable `export PATH=$HOME/workspace/pintos-assignment/pintos/src/utils:$PATH`
