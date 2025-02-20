## Customize prompt
#
# Uses flags:
# - %B ... %b          => Makes span bold
# - %F{<color>} ... %f => Colorizes span with <color>
# - %n                 => Username
# - %<n>~              => Last n directory segments (using ~ for home)
# - %#                 => Usually shows '%' (would be '#' if running as root)
# - \$(...)            => As normal process substitution but defer until runtime

function git-branch() {
  : << 'DOCSTRING'
  ## If in a Git repo, shows current branch name; no output otherwise.
  #
  # From https://gist.github.com/joseluisq/1e96c54fa4e1e5647940
DOCSTRING

  git branch 2> /dev/null | sed -ne 's/^\* \(.*\)/\1/p'
}

function git-repo() {
  : << 'DOCSTRING'
  ## If in a Git repo, shows name of repository; no output otherwise.
DOCSTRING

  basename "$(git rev-parse --show-toplevel 2> /dev/null)" 2> /dev/null
}

function toggle-git-prompt() {
  : << 'DOCSTRING'
  ## Toggles display of Git info in shell prompt.
DOCSTRING

  case ${+PROMPT_HIDE_GIT} in
    (0) export PROMPT_HIDE_GIT='true';;
    (1) unset PROMPT_HIDE_GIT;;
  esac
}

function _git-info-for-prompt() {
  : << 'DOCSTRING'
  ## Retrieve info about current Git repo for use in prompt.
  #
  # - If currently in a repo, show current repository name (in blue) and branch name (in magenta).
  # - If PROMPT_HIDE_GIT variable is set (to any value), instead show a constant value "(-)".
  # - If not in a repo, show nothing.  This takes precedence over PROMPT_HIDE_GIT.
DOCSTRING

  local REPO; REPO=$(git-repo)
  local BRANCH; BRANCH=$(git-branch)

  local OPEN_PAREN="%F{blue\}(%f"
  local REPO_PART="%F{blue\}$REPO%f"
  local BRANCH_PART="%F{magenta\}$BRANCH%f"
  local CLOSE_PAREN="%F{blue\})%f"

  case ${+PROMPT_HIDE_GIT} in
    (0) local GIT_INFO="${OPEN_PAREN}${REPO_PART}:${BRANCH_PART}${CLOSE_PAREN}";;
    (1) local GIT_INFO="${OPEN_PAREN}-${CLOSE_PAREN}";;
  esac

  echo "${REPO:+ $GIT_INFO}"
}

setopt PROMPT_SUBST
export PROMPT="%B%F{green}%3~\$(_git-info-for-prompt)%F{green} %#%f%b "
export RPROMPT="\$(date -u '+%T')"
