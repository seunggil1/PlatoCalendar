@echo off
:: ---------------------------------------------------------------------------
:: This script creates a .git\hooks\pre-commit file that runs Dart commands.
:: ASCII-only version to avoid encoding issues on Windows.
:: ---------------------------------------------------------------------------

:: Set the file path for pre-commit hook
set "HOOK_FILE=.git\hooks\pre-commit"

echo Creating pre-commit hook at "%HOOK_FILE%" ...

:: Use a block to write the shell script into %HOOK_FILE%
(
    echo #!/bin/sh
    echo
    echo error_messages=""
    echo
    echo "fix_output=$(dart fix --apply 2>&1)"
    echo "if ! echo \"$fix_output\" ^| grep -q \"Nothing to fix!\"; then"
    echo "    error_messages=\"$error_messages\n\nWARNING: dart fix --apply changed your code.\n$fix_output\""
    echo "fi"
    echo
    echo "format_output=$(dart format . 2>&1)"
    echo "if ! echo \"$format_output\" ^| grep -Eq \"0 changed^|no files\"; then"
    echo "    error_messages=\"$error_messages\n\nWARNING: dart format changed your code.\n$format_output\""
    echo "fi"
    echo
    echo "if [ -n \"$error_messages\" ]; then"
    echo "    error_messages=\"Please review the changes before committing. $error_messages\""
    echo "    printf \"%b\\n\" \"$error_messages\" 1>&2"
    echo "    exit 1"
    echo "fi"
    echo
    echo exit 0
) > "%HOOK_FILE%"

echo Done. pre-commit hook has been set up.
:: On Windows, chmod isn't usually necessary,
:: but if you're using Git Bash to run hooks, you might do:
:: "C:\Program Files\Git\bin\
