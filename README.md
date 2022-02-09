# Advent of Code 2021

The purpose of this repo is to test modern development methods

## Directory Structure

### day-xx

Each days challenge is contained in it's own directory and is it's own perl application.  All directories below are assumed to be inside a day directory

### bin

Executable script(s) to get the answer for the days puzzle.  bin scripts should be kept thin, actual logic is inside the pm file(s).  To run do so from the root of the day dir so that the use lib path works eg `./bin/day_one.pl`

### lib

Contains perl modules that perform the necessary operations to solve the puzzle.  Modules should be responsible for doing 1 "thing".  They should also be fully covered by unit tests.  The current exception being modules that interact with the file system

### t

Contains unit tests, test files correspond to pm files in the lib directory.  To run the tests, from the root of the day dir run `prove -lrv t`

## Test Coverage

TODO

## Static Code Analysis

TODO