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

## Function Documentation

This configuration includes many shell functions that are intended for
interactive usage, and given the poor legibility of shell code, it's important
to provide some sort of documentation on what these functions do (for the sake
of my future self).  But the standard facilities for documenting CLI tools
(`man` or `info` pages, or `--help` options) are all much too heavyweight for
this sort of personal-use tool.

Since the ZSH `which` command outputs the full code for commands defined as
shell functions but strips comments, I've adopted the habit of writing my
functions like this:

```zsh
function foo() {
  : << 'DOCSTRING'
  ## Brief description of function.
  #
  # More detailed description of function.
DOCSTRING

  # Function implementation
}
```

Recall that the `:` shell built-in is a no-op, so the "docstring" heredoc has no
effect when executing the function.  But it will show up in the output for
`which foo`, making this a viable documentation approach.

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
