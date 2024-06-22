# .zshrc.d

This is the personal ZSH configuration of Aaron Harris.  While it is intended
only for my own use, I have made it publicly available in case it proves useful
to others.

## Organization

I generally prefer to spread this sort of configuration across multiple files
rather than jamming everything into `.zshrc` directly.  So the only thing that
actually lives in `.zshrc` is the code that finds all of those other files and
sources them.

In addition to the usual benefits of modularization, this also supports an
interesting plugin-by-symlink pattern.  If a given project wants to provide
its own project-focused shell functions, then it can do so by symlinking a
directory of those functions under `~/.zshrc.d` (perhaps in some sort of
"development environment bootstrap" script).  That way, the implementations of
those functions will automatically track any changes.

## Initial Setup

Here's how to set up ZSH on a new machine:

```shell
cd ~
git clone https://github.com/aaron-harris/.zshrc.d.git
./.zshrc.d/init
exec zsh
```

In more detail, that will clone the repository into `~/.zshrc.d` and modify your
`.zshrc` file so that it includes the snippet that loads the other configuration.
Note that any existing configuration in `.zshrc` will not be removed, so you may
see conflicts if you're starting from an existing configuration, or if you ever
run the `init` script again.
