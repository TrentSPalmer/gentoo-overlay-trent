## What is this?
An unofficial overlay obviously, to experiment with ebuilds.  

To manually add overlay:
```
layman -f -a gentoo-overlay-trent -o https://raw.githubusercontent.com/TrentSPalmer/gentoo-overlay-trent/master/overlay.xml 
```
## Test drive?
[Here's a Gist](https://gist.github.com/TrentSPalmer/a929dfdb0cdb7dd946d313bde708900e)
with instructions for how to quickly spin up an nspawn container to do some test building,
if you are into that sort of thing.

## Portage Category
the app-nvim category requires a configuration file

```conf
# /etc/portage/categories
app-nvim
```
