# git-credential-osxkeychain-fallback

This is a credential helper based on git-credential-osxkeychain
from the git distribution that will search the keychain as
git-credential-osxkeychain does but if it doesn't find a match it
will then search for an entry without the path portion. This is mostly
convenient for using GitHub https URLs where you don't have to necessarily have
an entry in your keychain for every repository.

My only contribution to this code it to add the retry for the base URL and the build
to the Makefile.  All the hard work was done by the Git developers. I have purposely
split this code out and retained the history for both recognition and ease of updates.
I would like to eventually submit this work for inclusion into the main git source, but
that process is not short/easy.  So until I have time to go throught that, I'll keep it
separate.

## Installation

Manual

    $ git clone https://github.com/mgrubb/osxkeychain-fallback
    $ cd osxkeychain-fallback
    $ make fallback-install
    $ git config --global credential.helper osxkeychain-fallback
    
Homebrew _(coming soon)_

    $ brew install git-credential-osxkeychain-fallback

## Configure repository for updating from upstream

1. Add upstream remote

        git remote add -t master --no-tags upstream https://github.com/git/git

## Updating from upstream
1. Fetch updates

        git fetch upstream

2. Create a pruned branch that contains only osxkeychain

        git branch kcmerge upstream/master
        git filter-branch --prune-empty --subdirectory-filter contrib/credential/osxkeychain kcmerge

3. Rebase master from kcmerge branch

        git rebase kcmerge

4. Cleanup repository

        git branch -D kcmerge
