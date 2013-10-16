#!/bin/sh
set -e

test -e 1-ggplot2-a.pdf || wget -O 1-ggplot2-a.pdf http://ggplot2.org/resources/2007-vanderbilt.pdf
test -e 1-ggplot2-b.pdf || wget -O 1-ggplot2-b.pdf http://ggplot2.org/resources/2007-past-present-future.pdf
