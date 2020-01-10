#!/usr/bin/env bats

load test_helper

export GIT_DIR="${CLI_COMMON_CORE_TEST_DIR}/.git"

setup() {
  mkdir -p "$HOME"
  git config --global user.name  "Tester"
  git config --global user.email "tester@test.local"
  cd "$CLI_COMMON_CORE_TEST_DIR"
}

git_commit() {
  git commit --quiet --allow-empty -m "empty"
}

@test "default version" {
  assert [ ! -e "$CLI_COMMON_CORE_ROOT" ]
  run cli-common-core---version
  assert_success
  [[ $output == "cli-common-core "?.?.? ]]
}

@test "doesn't read version from non-cli-common-core repo" {
  git init
  git remote add origin https://github.com/homebrew/homebrew.git
  git_commit
  git tag v1.0

  run cli-common-core---version
  assert_success
  [[ $output == "cli-common-core "?.?.? ]]
}

@test "reads version from git repo" {
  git init
  git remote add origin https://github.com/la-ruby/cli-common-core.git
  git_commit
  git tag v0.4.1
  git_commit
  git_commit

  run cli-common-core---version
  assert_success "cli-common-core 0.4.1-2-g$(git rev-parse --short HEAD)"
}

@test "prints default version if no tags in git repo" {
  git init
  git remote add origin https://github.com/la-ruby/cli-common-core.git
  git_commit

  run cli-common-core---version
  [[ $output == "cli-common-core "?.?.? ]]
}
