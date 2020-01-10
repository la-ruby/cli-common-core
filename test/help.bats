#!/usr/bin/env bats

load test_helper

@test "without args shows summary of common commands" {
  run cli-common-core-help
  assert_success
  assert_line "Usage: cli-common-core <command> [<args>]"
  assert_line "Some useful cli-common-core commands are:"
}

@test "invalid command" {
  run cli-common-core-help hello
  assert_failure "cli-common-core: no such command \`hello'"
}

@test "shows help for a specific command" {
  mkdir -p "${CLI_COMMON_CORE_TEST_DIR}/bin"
  cat > "${CLI_COMMON_CORE_TEST_DIR}/bin/cli-common-core-hello" <<SH
#!shebang
# Usage: cli-common-core hello <world>
# Summary: Says "hello" to you, from cli-common-core
# This command is useful for saying hello.
echo hello
SH

  run cli-common-core-help hello
  assert_success
  assert_output <<SH
Usage: cli-common-core hello <world>

This command is useful for saying hello.
SH
}

@test "replaces missing extended help with summary text" {
  mkdir -p "${CLI_COMMON_CORE_TEST_DIR}/bin"
  cat > "${CLI_COMMON_CORE_TEST_DIR}/bin/cli-common-core-hello" <<SH
#!shebang
# Usage: cli-common-core hello <world>
# Summary: Says "hello" to you, from cli-common-core
echo hello
SH

  run cli-common-core-help hello
  assert_success
  assert_output <<SH
Usage: cli-common-core hello <world>

Says "hello" to you, from cli-common-core
SH
}

@test "extracts only usage" {
  mkdir -p "${CLI_COMMON_CORE_TEST_DIR}/bin"
  cat > "${CLI_COMMON_CORE_TEST_DIR}/bin/cli-common-core-hello" <<SH
#!shebang
# Usage: cli-common-core hello <world>
# Summary: Says "hello" to you, from cli-common-core
# This extended help won't be shown.
echo hello
SH

  run cli-common-core-help --usage hello
  assert_success "Usage: cli-common-core hello <world>"
}

@test "multiline usage section" {
  mkdir -p "${CLI_COMMON_CORE_TEST_DIR}/bin"
  cat > "${CLI_COMMON_CORE_TEST_DIR}/bin/cli-common-core-hello" <<SH
#!shebang
# Usage: cli-common-core hello <world>
#        cli-common-core hi [everybody]
#        cli-common-core hola --translate
# Summary: Says "hello" to you, from cli-common-core
# Help text.
echo hello
SH

  run cli-common-core-help hello
  assert_success
  assert_output <<SH
Usage: cli-common-core hello <world>
       cli-common-core hi [everybody]
       cli-common-core hola --translate

Help text.
SH
}

@test "multiline extended help section" {
  mkdir -p "${CLI_COMMON_CORE_TEST_DIR}/bin"
  cat > "${CLI_COMMON_CORE_TEST_DIR}/bin/cli-common-core-hello" <<SH
#!shebang
# Usage: cli-common-core hello <world>
# Summary: Says "hello" to you, from cli-common-core
# This is extended help text.
# It can contain multiple lines.
#
# And paragraphs.

echo hello
SH

  run cli-common-core-help hello
  assert_success
  assert_output <<SH
Usage: cli-common-core hello <world>

This is extended help text.
It can contain multiple lines.

And paragraphs.
SH
}
