#!/bin/sh

# MIT license

VERSION="2.0"
DEBUG=0

usage () {
    cat << EOF >&2
    
Usage: $0 [--version] [-w] [-e] [-f] [--no-X] [-d/--depth=2] [DIR [DIR]...]

mgitstatus shows uncommitted, untracked and unpushed changes in multiple Git
repositories.  By default, mgitstatus scans two directories deep. This can be
changed with the -d (--depth) option.  If DEPTH is 0, the scan is infinitely
deep.

  --version      Show version
  -w             Warn about dirs that are not Git repositories
  -e             Exclude repos that are 'ok'
  -f             Do a 'git fetch' on each repo (slow for many repos)
  -c             Force color output (preserve colors when using pipes)
  -d, --depth=2  Scan this many directories deep

You can limit output with the following options:

  --no-push
  --no-pull
  --no-upstream
  --no-uncommitted
  --no-untracked
  --no-stashes
    
EOF
}

# Handle commandline options
WARN_NOT_REPO=0
EXCLUDE_OK=0
DO_FETCH=0
FORCE_COLOR=0
NO_PUSH=0
NO_PULL=0
NO_UPSTREAM=0
NO_UNCOMMITTED=0
NO_UNTRACKED=0
NO_STASHES=0
DEPTH=2

while [ -n "$1" ]; do
    # Stop reading when we've run out of options.
    [ "$(printf "%s" "$1" | cut -c 1)" != "-" ] && break

    if [ "$1" = "--version" ]; then
        echo "v$VERSION"
        exit 0
    fi
    if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
        usage
        exit 1
    fi
    if [ "$1" = "-w" ]; then
        WARN_NOT_REPO=1
    fi
    if [ "$1" = "-e" ]; then
        EXCLUDE_OK=1
    fi
    if [ "$1" = "-f" ]; then
        DO_FETCH=1
    fi
    if [ "$1" = "-c" ]; then
        FORCE_COLOR=1
    fi
    if [ "$1" = "--no-push" ]; then
        NO_PUSH=1
    fi
    if [ "$1" = "--no-pull" ]; then
        NO_PULL=1
    fi
    if [ "$1" = "--no-upstream" ]; then
        NO_UPSTREAM=1
    fi
    if [ "$1" = "--no-uncommitted" ]; then
        NO_UNCOMMITTED=1
    fi
    if [ "$1" = "--no-untracked" ]; then
        NO_UNTRACKED=1
    fi
    if [ "$1" = "--no-stashes" ]; then
        NO_STASHES=1
    fi
    if [ "$1" = "-d" ] || [ "$1" = "--depth" ]; then
        DEPTH="$2"
        echo "$DEPTH" | grep -E "^[0-9]+$" > /dev/null 2>&1
        IS_NUM="$?"
        if [ "$IS_NUM" -ne 0 ]; then
            echo "Invalid value for 'depth' (must be a number): $DEPTH" >&2
            exit 1
        fi
        # Shift one extra param
        shift
    fi

    shift
done

if [ -t 1 ] || [ "$FORCE_COLOR" -eq 1 ]; then
    # Our output is not being redirected, so we can use colors.
    C_RED="\033[1;31m"
    C_GREEN="\033[1;32m"
    C_YELLOW="\033[1;33m"
    C_BLUE="\033[1;34m"
    C_PURPLE="\033[1;35m"
    C_CYAN="\033[1;36m"
    C_RESET="$(tput sgr0)"
fi

C_OK="$C_GREEN"
C_LOCKED="$C_RED"
C_NEEDS_PUSH="$C_YELLOW"
C_NEEDS_PULL="$C_BLUE"
C_NEEDS_COMMIT="$C_RED"
C_NEEDS_UPSTREAM="$C_PURPLE"
C_UNTRACKED="$C_CYAN"
C_STASHES="$C_YELLOW"

# Find all .git dirs, up to DEPTH levels deep. If DEPTH is 0, the scan in
# infinitely deep
FIND_OPTS=""
if [ "$DEPTH" -ne 0 ]; then
    FIND_OPTS="$FIND_OPTS -maxdepth $DEPTH"
fi

# Go through positional arguments (DIRs) or '.' if no argumnets are given
for DIR in "${@:-"."}"; do
    # We *want* to expand parameters, so disable shellcheck for this error:
    # shellcheck disable=SC2086
    find -L "$DIR" $FIND_OPTS -type d | while read -r PROJ_DIR
    do
        GIT_DIR="$PROJ_DIR/.git"
        GIT_CONF="$PROJ_DIR/.git/config"
        
        # Check git config for this project to see if we should ignore this repo.
        IGNORE=$(git config -f "$GIT_CONF" --bool mgitstatus.ignore)
        if [ "$IGNORE" = "true" ]; then
            continue
        fi

        # If this dir is not a repo, and WARN_NOT_REPO is 1, tell the user.
        if [ ! -d "$GIT_DIR" ]; then
            if [ "$WARN_NOT_REPO" -eq 1 ] && [ "$PROJ_DIR" != "." ]; then
                printf "${PROJ_DIR}: not a git repo\n"
            fi
            continue
        fi

        [ $DEBUG -eq 1 ] && echo "${PROJ_DIR}"

        # Check if repo is locked
        if [ -f "$GIT_DIR/index.lock" ]; then
            printf "${PROJ_DIR}: ${C_LOCKED}Locked. Skipping.${C_RESET}\n"
            continue
        fi

        # Do a 'git fetch' if requested
        if [ "$DO_FETCH" -eq 1 ]; then
            git --work-tree "$(dirname "$GIT_DIR")" --git-dir "$GIT_DIR" fetch -q >/dev/null
        fi

        # Refresh the index, or we might get wrong results.
        git --work-tree "$(dirname "$GIT_DIR")" --git-dir "$GIT_DIR" update-index -q --refresh >/dev/null 2>&1

        # Find all remote branches that have been checked out and figure out if
        # they need a push or pull. We do this with various tests and put the name
        # of the branches in NEEDS_XXXX, seperated by newlines. After we're done,
        # we remove duplicates from NEEDS_XXX.
        NEEDS_PUSH_BRANCHES="" 
        NEEDS_PULL_BRANCHES=""
        NEEDS_UPSTREAM_BRANCHES=""

        for REF_HEAD in $(cd "$GIT_DIR/refs/heads" && find . -type 'f' | sed "s/^\.\///"); do
            # Check if this branch is tracking an upstream (local/remote branch)
            UPSTREAM=$(git --git-dir "$GIT_DIR" rev-parse --abbrev-ref --symbolic-full-name "$REF_HEAD@{u}" 2>/dev/null)
            EXIT_CODE="$?"
            if [ "$EXIT_CODE" -eq 0 ]; then
                # Branch is tracking a remote branch. Find out how much behind /
                # ahead it is of that remote branch.
                CNT_AHEAD_BEHIND=$(git --git-dir "$GIT_DIR" rev-list --left-right --count "$REF_HEAD...$UPSTREAM")
                CNT_AHEAD=$(echo "$CNT_AHEAD_BEHIND" | awk '{ print $1 }')
                CNT_BEHIND=$(echo "$CNT_AHEAD_BEHIND" | awk '{ print $2 }')

                [ $DEBUG -eq 1 ] && echo "CNT_AHEAD_BEHIND: $CNT_AHEAD_BEHIND"
                [ $DEBUG -eq 1 ] && echo "CNT_AHEAD: $CNT_AHEAD"
                [ $DEBUG -eq 1 ] && echo "CNT_BEHIND: $CNT_BEHIND"

                if [ "$CNT_AHEAD" -gt 0 ]; then
                    NEEDS_PUSH_BRANCHES="${NEEDS_PUSH_BRANCHES}\n$REF_HEAD"
                fi
                if [ "$CNT_BEHIND" -gt 0 ]; then
                    NEEDS_PULL_BRANCHES="${NEEDS_PULL_BRANCHES}\n$REF_HEAD"
                fi

                # Check if this branch is a branch off another branch. and if it needs
                # to be updated.
                REV_LOCAL=$(git --git-dir "$GIT_DIR" rev-parse --verify "$REF_HEAD" 2>/dev/null)
                REV_REMOTE=$(git --git-dir "$GIT_DIR" rev-parse --verify "$UPSTREAM" 2>/dev/null)
                REV_BASE=$(git --git-dir "$GIT_DIR" merge-base "$REF_HEAD" "$UPSTREAM" 2>/dev/null)

                [ $DEBUG -eq 1 ] && echo "REV_LOCAL: $REV_LOCAL"
                [ $DEBUG -eq 1 ] && echo "REV_REMOTE: $REV_REMOTE"
                [ $DEBUG -eq 1 ] && echo "REV_BASE: $REV_BASE"

                if [ "$REV_LOCAL" = "$REV_REMOTE" ]; then
                    : # NOOP
                else
                    if [ "$REV_LOCAL" = "$REV_BASE" ]; then
                        NEEDS_PULL_BRANCHES="${NEEDS_PULL_BRANCHES}\n$REF_HEAD"
                    fi
                    if [ "$REV_REMOTE" = "$REV_BASE" ]; then
                        NEEDS_PUSH_BRANCHES="${NEEDS_PUSH_BRANCHES}\n$REF_HEAD"
                    fi
                fi
            else
                # Branch does not have an upstream (local/remote branch).
                NEEDS_UPSTREAM_BRANCHES="${NEEDS_UPSTREAM_BRANCHES}\n$REF_HEAD"
            fi
        done

        # Remove duplicates from NEEDS_XXXX and make comma-seperated
        NEEDS_PUSH_BRANCHES=$(printf "$NEEDS_PUSH_BRANCHES" | sort | uniq | tr '\n' ',' | sed "s/^,\(.*\),$/\1/")
        NEEDS_PULL_BRANCHES=$(printf "$NEEDS_PULL_BRANCHES" | sort | uniq | tr '\n' ',' | sed "s/^,\(.*\),$/\1/")
        NEEDS_UPSTREAM_BRANCHES=$(printf "$NEEDS_UPSTREAM_BRANCHES" | sort | uniq | tr '\n' ',' | sed "s/^,\(.*\),$/\1/")

        # Find out if there are unstaged, uncommitted or untracked changes
        UNSTAGED=$(git --work-tree "$(dirname "$GIT_DIR")" --git-dir "$GIT_DIR" diff-index --quiet HEAD -- 2>/dev/null; echo $?)
        UNCOMMITTED=$(git --work-tree "$(dirname "$GIT_DIR")" --git-dir "$GIT_DIR" diff-files --quiet --ignore-submodules --; echo $?)
        UNTRACKED=$(git --work-tree "$(dirname "$GIT_DIR")" --git-dir "$GIT_DIR" ls-files --exclude-standard --others)
        cd "$(dirname "$GIT_DIR")" || exit
        STASHES=$(git stash list | wc -l)
        cd "$OLDPWD" || exit

        # Build up the status string
        IS_OK=0  # 0 = Repo needs something, 1 = Repo needs nothing ('ok')
        STATUS_NEEDS=""
        if [ -n "$NEEDS_PUSH_BRANCHES" ] && [ "$NO_PUSH" -eq 0 ]; then
            STATUS_NEEDS="${STATUS_NEEDS}${C_NEEDS_PUSH}Needs push ($NEEDS_PUSH_BRANCHES)${C_RESET} "
        fi
        if [ -n "$NEEDS_PULL_BRANCHES" ] && [ "$NO_PULL" -eq 0 ]; then
            STATUS_NEEDS="${STATUS_NEEDS}${C_NEEDS_PULL}Needs pull ($NEEDS_PULL_BRANCHES)${C_RESET} "
        fi
        if [ -n "$NEEDS_UPSTREAM_BRANCHES" ] && [ "$NO_UPSTREAM" -eq 0 ]; then
            STATUS_NEEDS="${STATUS_NEEDS}${C_NEEDS_UPSTREAM}Needs upstream ($NEEDS_UPSTREAM_BRANCHES)${C_RESET} "
        fi
        if [ "$UNSTAGED" -ne 0 ] || [ "$UNCOMMITTED" -ne 0 ] && [ "$NO_UNCOMMITTED" -eq 0 ]; then
            STATUS_NEEDS="${STATUS_NEEDS}${C_NEEDS_COMMIT}Uncommitted changes${C_RESET} "
        fi
        if [ "$UNTRACKED" != "" ] && [ "$NO_UNTRACKED" -eq 0 ]; then
            STATUS_NEEDS="${STATUS_NEEDS}${C_UNTRACKED}Untracked files${C_RESET} "
        fi
        if [ "$STASHES" -ne 0 ] && [ "$NO_STASHES" -eq 0 ]; then
            STATUS_NEEDS="${STATUS_NEEDS}${C_STASHES}$STASHES stashes${C_RESET} "
        fi
        if [ "$STATUS_NEEDS" = "" ]; then
            IS_OK=1
            STATUS_NEEDS="${STATUS_NEEDS}${C_OK}ok${C_RESET} "
        fi

        # Print the output, unless repo is 'ok' and -e was specified
        if [ "$IS_OK" -ne 1 ] || [ "$EXCLUDE_OK" -ne 1 ]; then
            printf "${PROJ_DIR}: $STATUS_NEEDS\n"
        fi
    done
done
