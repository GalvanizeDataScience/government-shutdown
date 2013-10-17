Government Shutdown
======
The federal government recently
[shut down](http://en.wikipedia.org/wiki/United_States_federal_government_shutdown_of_2013).
Let's look what their finances have looked like during the shutdown.

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

    wget http://api.treasury.io/cc7znvq/47d80ae900e04f2/http/treasury_data.db

Here's a [codebook](https://github.com/csvsoundsystem/federal-treasury-api/wiki/Treasury.io-Data-Dictionary).

## Software
You're going to use R for this project.

R is already installed on your vagrant machine, but you probably
want RStudio. RStudio is a fancy development environment for R,
and you can download it here.
http://www.rstudio.com/ide/download/desktop

You might also find it helpful to install ordinary R outside of your
vagrant machine.
http://cran.r-project.org/

Sometimes, scripting the plot's format is more work than it's worth.
Consider using Inkscape to tidy up the plot afterwards.
http://inkscape.org/download/?lang=en

## Goals
* Learn some data visualization theory
* Learn how to make plots in ggplot2
* Learn enough R to make plots in ggplot2

## Assignments

### Prework
Select four visuals that someone else created.

1. A good data visual
2. A bad data visual
3. A good non-data visual
4. A bad non-data visual

For each visual, write a paragraph about why you chose it.

Save these in [visual-critques.md](visual-critiques.md),
and submit them via pull request by day 2 of this project.
Choose one of these four visuals to present to the class;
we'll start day 2 with these presentations.

### Government shutdown analysis
[Time](http://swampland.time.com/2013/10/15/see-for-yourself-uncle-sams-bank-account-running-low/)
looked at how the federal government's finances have been doing for the past two weeks.
Their analysis is pretty cool, but you can do better.

Explore the data, figure out something interesting
about the government shutdown, and explain this in
a blog post that includes some explanatory plots.

During lecture on day 1, we'll show you how to
use the R library ggplot2, but we won't talk too much
about how R works in general until day 2.

Base your code on [`boilerplate.r`](boilerplate.r)
so that you don't have to know how R works.

### More critique of visuals
Look at the four visuals that you selected before.
Explain how well each one follows the guidelines
and theory that we discussed in lecture during this
project. Write a paragraph for each visual.

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

Watch [Engineering Data Analysis](http://www.youtube.com/watch?v=TaxJwC_MP9Q)
before day 1 of the project.

## Other resources

### Day 1

* The Grammar of Graphics, by Leland Wilkinson
* [ggplot2 documuentation](http://docs.ggplot2.org/current/)
* Scales examples
  * [Wetlands data](https://github.com/tlevine/scales-lightning-talk)
  * [Treasury data](scales-example.r)

### Day 2

* [Summary](http://www.behance.net/gallery/Book-Layout-Timothy-Samaras-20-Rules-of-Good-Design/7616553)
    of Timothy Samara's Design Elements.
* Design Elements, by Timothy Samara
* [R Spells for Data Wizards](http://thomaslevine.com/!/r-spells-for-data-wizards/)
* [Intro to R](http://www.youtube.com/playlist?list=PLOU2XLYxmsIK9qQfztXeybpHvru-TrqAP) videos
* [R-bloggers](http://www.r-bloggers.com/)
