## Waht is this?
This is essentially a fork from 
https://github.com/stefantalpalaru/gentoo-overlay/tree/master/app-vim/youcompleteme

## Why?
but with the ability to turn on all the options for vim-youcompleteme plugin with
use flags, adding the use flags  mono, go, rust, and nodejs

## Handy tips!
if you're building in a headless environment, you can add `dev-lang/mono minimal`
to package.use

if you're building in a container, mono wants kernel sources and a config. You
can install gentoo-sources, generate the host's kernel config with
`zcat /proc/config.gz` or `cat /boot/config-some-version`, and output that to
/usr/src/linux/.config on the container.

### Rust
added app-vim/rust-vim as dependancy for USE="rust",
[additional info](http://blog.jwilm.io/youcompleteme-rust/)

## Test drive?
[Here's a Gist](https://gist.github.com/TrentSPalmer/a929dfdb0cdb7dd946d313bde708900e)
with instructions for how to quickly spin up an nspawn container to do some test building,
if you are into that sort of thing.
