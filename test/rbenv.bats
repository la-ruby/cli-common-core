#!/usr/bin/env bats

load test_helper

@test "blank invocation" {
  run cli-common-core
  assert_failure
  assert_line 0 "$(cli-common-core---version)"
}

@test "invalid command" {
  run cli-common-core does-not-exist
  assert_failure
  assert_output "cli-common-core: no such command \`does-not-exist'"
}

