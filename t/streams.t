#!/bin/ksh
#
# streams.t
# Test streams
# By Stuart McMurray
# Created 20260506
# Last Modified 20260506

set -euo pipefail

. t/shmore.subr

# Work out how many tests we'll run.
N=0
for HAVEF in t/testdata/streams/*_have; do echo $HAVEF; : $((N++)); done
tap_plan "$N"

# We'll use a temporary file for output because the shell does funny things
# with trailing newlines.
STMPF=$(mktemp)
VTMPF=$(mktemp)
trap 'rm -f "$STMPF" "$VTMPF"; tap_done_testing' EXIT

# test_stream checks if ${1}_have turns into ${1}_want with both ssan and, if
# available, vis(1).
#
# Arguments:
# $1 - Filename prefix
test_stream() {
        tap_plan 4

        local _havef="${1}_have" _wantf="${1}_want" _dgot

        # Can we run ssan?
        ./ssan <"$_havef" >$STMPF
        tap_is $? 0 "ssan ran without errors" "$0" $LINENO
        # Is its output correct?
        _dgot=$(diff -u -L want -L got "$_wantf" "$STMPF" 2>&1)
        tap_is "$_dgot" "" "ssan output correct" "$0" $LINENO
        # Is its output the same as vis'?
        vis <"$_havef" >$VTMPF
        tap_is $? 0 "vis(1) ran without errors" "$0" $LINENO
        _dgot=$(diff -u -L "vis(1)" -L "ssan" "$VTMPF" "$STMPF" 2>&1)
        tap_is "$_dgot" "" "ssan and vis(1) output identical" "$0" $LINENO
}

# Test cases live in t/testdata/streams/*_have
for HAVEF in t/testdata/streams/*_have; do
        PREFIX="${HAVEF%_have}"
        subtest() { test_stream "$PREFIX"; }
        tap_subtest "$(basename "$PREFIX")" subtest "$0" $LINENO
done

# vim: ft=sh
