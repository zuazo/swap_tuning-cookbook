#!/usr/bin/env bats

PATH='/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin'

@test "should create swap file" {
  [ -f "/swapfile0" ]
}

@test "should enable swap file" {
  swapon -s | grep -Fq "/swapfile0"
}
