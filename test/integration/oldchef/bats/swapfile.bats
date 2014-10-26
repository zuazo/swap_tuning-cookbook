#!/usr/bin/env bats

PATH='/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin'

@test "creates swap file" {
  [ -f "/swapfile0" ]
}

@test "enables swap file" {
  swapon -s | grep -Fq "/swapfile0"
}

@test "does not create a second swap file" {
  ! [ -f "/swapfile1" ]
}

@test "does not enable a second swap file" {
  ! swapon -s | grep -Fq "/swapfile1"
}
