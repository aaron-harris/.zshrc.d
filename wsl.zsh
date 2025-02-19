## WSL Utilities
#
# Functions in this file are only designed for use when running under WSL (the
# Windows Subsystem for Linux) and will only be defined when it appears that the
# current environment is running in WSL.
#
# Aliases here to Windows-native tools will generally not specify an explicit
# path, instead assuming that the tool will have been separately installed and
# added to the Windows-side PATH.
#
# The heuristic for determining whether we are running in WSL was taken from
# this Stack Overflow answer:
#   https://superuser.com/a/1749811/460709

if [[ -n $WSL_DISTRO_NAME ]]; then
  function open() {
    : << 'DOCSTRING'
    ## Open the specified file in Windows Explorer.
    #
    # This is intended to mimic the `open` command that is available by default
    # on Macs.
    #
    # Parameters:
    # $1 - The file to be opened, as a Linux path
DOCSTRING

    explorer.exe "$(wslpath -w "$1")"
  }

  # Emacs
  alias emacs=runemacs.exe

  # IntelliJ IDEA
  alias ij=idea64.exe
fi
