#!/usr/bin/env bats

@test "should create swap file" {
  [ -f "/swapfile0" ]
}

@test "should enable swap file" {
  swapon -s | grep -Fq "/swapfile0"
}
