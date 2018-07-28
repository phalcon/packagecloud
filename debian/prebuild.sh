#!/bin/bash

# This line instructs debconf to store in its database an answer for
# the program debconf. If (the running program) debconf later asks
# (the database of answers) debconf what is my frontend the answer
# will be frontend is Noninteractive.
#
# It has nothing to do with the interactivity of bash.
echo 'debconf debconf/frontend select Noninteractive' | sudo debconf-set-selections
