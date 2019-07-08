#!/usr/bin/env sh

$(which docker) rm $($(which docker) ps -a -q)