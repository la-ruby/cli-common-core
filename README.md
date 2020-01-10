# the cli-common-core tool [![Build Status](https://api.travis-ci.org/la-ruby/cli-common-core.svg?branch=master)](http://travis-ci.org/la-ruby/cli-common-core)


## Table of Contents

* [Installation](#installation)
  * [Basic GitHub Checkout](#basic-github-checkout)
    * [Upgrading with Git](#upgrading-with-git)
  * [Uninstalling cli-commonc-re](#uninstalling-cli-common-core)
* [Command Reference](#command-reference)
  * [cli-common-core version](#cli-common-core-version)
* [Environment variables](#environment-variables)
* [Development](#development)

## Installation

### Basic GitHub Checkout

This will get you going with the latest version of cli-common-core without needing
a systemwide install.

1. Clone cli-common-core into `~/.cli-common-core`.

    ~~~ sh
    $ git clone https://github.com/la-ruby/cli-common-core.git ~/.cli-common-core
    ~~~


2. Add `~/.cli-common-core/bin` to your `$PATH` for access to the `cli-common-core`
   command-line utility.

   * For **bash**:
     ~~~ bash
     $ echo 'export PATH="$HOME/.cli-common-core/bin:$PATH"' >> ~/.bash_profile
     ~~~
     
   * For **Zsh**:
     ~~~ zsh
     $ echo 'export PATH="$HOME/.cli-common-core/bin:$PATH"' >> ~/.zshrc
     ~~~

3. Restart your shell so that PATH changes take effect. (Opening a new
   terminal tab will usually do it.)

#### Upgrading with Git

If you've installed cli-common-core using Git, you can upgrade to the
latest version by pulling from GitHub:

~~~ sh
$ cd ~/.cli-common-core
$ git pull
~~~

### Uninstalling cli-common-core

1. To completely **uninstall**,  remove its root directory:

        rm -rf ~/.cli-common-core/

## Command Reference

Like `git`, the `cli-common-core` command delegates to subcommands based on its
first argument. The most common subcommands are:

### cli-common-core -v

Displays the version of this tool

    $ cli-common-core -v
    cli-common-core 1.1.2

## Environment variables

You can affect how cli-common-core operates with the following settings:

name | default | description
-----|---------|------------
`CLI_COMMON_CORE_ROOT` | `~/.cli-common-core` | Defines the directory used by cli-common-core
`CLI_COMMON_CORE_DEBUG` | | Outputs debug information.<br>Also as: `cli-common-core --debug <subcommand>`


## Development

The source code is [hosted on
GitHub](https://github.com/la-ruby/cli-common-core). It's clean, modular,
and easy to understand, even if you're not a shell hacker.

Tests are executed using [Bats](https://github.com/sstephenson/bats):

    $ bats test
    $ bats test/<file>.bats

Please feel free to submit pull requests and file bugs on the [issue
tracker](https://github.com/la-ruby/cli-common-core/issues).
