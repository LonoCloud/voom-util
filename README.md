# voom-util

## voom-like-version

Creates a version in a manner similar to `lein-voom`.

There are two versions:
 - `voom-like-version.sh` - written in `bash`
 - `voom-like-version` - written in [`babashka`](https://github.com/borkdude/babashka)

The `babashka` version is recommended, as it includes support for
following symlinks and is portable between GNU Linux and BSD.

### Usage

Generate a version for a given file.

    voom-like-version path/to/file

Generate a version based on multiple files returns the version for the latest one.

    voom-like-version path/to/file path/to/another/file

Generate a version for the whole repository.

    REPO_ROOT_VOOM=1 voom-like-version

Passing paths with `REPO_ROOT_VOOM` set is not supported.

### Development & Testing

For the tests to succeed, you need a clean repo with
`version-tests/test-files/later` being included in the most recent
commit in the `version-tests` directory. If you've made changes to
anything in the version-tests directory, after you have things in a
reasonable state, make a change to `later` and commit it. For example,

    echo $(date) > version-tests/test-files/later
    git commit -am "[version-tests/test-files] Bump later."

Testing `voom-like-version` (`babashka`)

    version-tests/test

You should see the resulting happy output:

    Testing user

    Ran 2 tests containing 14 assertions.
    0 failures, 0 errors.
    {:test 2, :pass 14, :fail 0, :error 0, :type :summary}

Testing `voom-like-version.sh` (`bash`). These tests will fail on BSD
as BSD `date` doesn't support options used by `voom-like-version.sh`.

    cd version-tests && ./test.sh

Seeing resulting output should be reason for joy. Actual values may
differ.

    Running tests:
    + Running zero arg test
    + '[' 20200507_161150-g4aedf5f == 20200507_161150-g4aedf5f ']'
    + '[' 20200507_161150-g4aedf5f == 20200507_161150-g4aedf5f ']'
    + '[' 20200507_161150-g4aedf5f == 20200507_161150-g4aedf5f ']'
    + '[' 20200507_161150-g4aedf5f == 20200507_161150-g4aedf5f ']'
    + '[' 20200507_161150-g4aedf5f '!=' 20170517_190222-gec5aaba ']'
