Government Shutdown
======
The federal government recently shut down.
Let's look at how spending has changed during
the shutdown.

## Schedule
This project is spread across two days, plus the
usual next day for presentations and code review.

Lectures will be organized as follows.

* Day 1: The grammar of graphics and ggplot2
* Day 2: More data visualization theory and
  more about R
* Day 3: Code review

## Data
[treasury.io](http://treasury.io) provides
a daily feed of deposits and withdrawals
from different accounts within the federal
treasury. You can download the full historical
feed as a SQLite3 database.

    wget ...

Here's a [codebook](https://github.com/csvsoundsystem/federal-treasury-api/wiki/Treasury.io-Data-Dictionary).

## Goals
* Learn some data visualization theory
* Learn how to make plots in ggplot2
* Learn enough R to make plots in ggplot2

## Assignment
Explore the data, figure out something interesting
about the government shutdown, and explain this in
a blog post that includes some explanatory plots.

During lecture on day 1, we'll show you how to
use the R library ggplot2, but we won't expect
you to know anything about R other than this.
Base your plotting code on [`boilerplate.r`](boilerplate.r)
so that you don't have to know how R works.
We'll talk a bit about R during day 2.

## Extra credit
We want you to apply some data visualization theory
and to make some plots with ggplot2. Once you feel
that you have done this, you may move on to other
things. Here are some ideas.

* Do a more involved analysis in Python, and make
    plots in matplotlib.
* R has a lot of standard statistical methods build-in.
    If you already understand how these works, use R
    to build models about what is going on.


## Required readings/videos

* This [summary]() of Timothy Samara's Design Elements.
* Grammar of graphics video?
    http://ggplot2.org/resources/2007-vanderbilt.pdf

## References (optional readings)

### Day 1

* The Grammar of Graphics
* [ggplot2 documuentation](http://docs.ggplot2.org/current/)

### Day 2

* Design Elements, by Timothy Samara
* Some R introduction
* [R Spells for Data Wizards](http://thomaslevine.com/!/r-spells-for-data-wizards/)
