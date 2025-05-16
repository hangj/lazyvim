# 💤 LazyVim

A starter template for [LazyVim](https://github.com/LazyVim/LazyVim).
Refer to the [documentation](https://lazyvim.github.io/installation) to get started.

# Install Neovide
https://neovide.dev/

# Edit ~/.config/fish/config.fish

Add the following code to the file

```
function neovide
  open -n /Applications/Neovide.app --args (realpath $argv[1])
end
```


And now you can start Neovide from terminal like this:

```sh
neovide your/project/directory
```


