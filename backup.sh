#!/usr/bin/env bash

on_err() {
  local exit_code=$?
  err "failed at ${BASH_SOURCE[1]}:${BASH_LINE_NO[0]} (exit $exit_code)"
  exit "$exit_code"
}
trap on_err ERR

usage() {
  local script_name=${0##*/}
  cat<<EOF
Options:
  -d            Directory mode (add/remove folders)
  -a <files>    Configure new file
  -r <files>    Remove file from config
  -n            Dry run (no changes)
  -s            Save all the configured files  
  -l            Load all the configured files
  -c            Configure initial setup
  -v            Verbose (debug logs)
  -q            Quiet (supress info)
  -h            Show this help

Usage:
  $script_name

Examples:
  $script_name -d -a .config/nvim,.config/i3
  $script_name -r .zshrc,.wezterm.lua
  $script_name -s -v
  $script_name -n -l -q
EOF
}

# TODO
# Add long options

# setup and read from
backup_config.txt



