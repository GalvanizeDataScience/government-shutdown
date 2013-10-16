The Grammar of Graphics
======

## Command types

> Statistical graphic specifications are expressed in six statements:
> 
> 1) `DATA`: a set of data operations that create variables from datasets,
> 2) `TRANS`: variable transformations (*e.g., rank*),
> 3) `SCALE`: scale transformations (*e.g., log*),
> 4) `COORD`: a coordinate system (*e.g., polar*),
> 5) `ELEMENT`: graphs (*e.g., points*) and their aesthetic attributes (*e.g., color*),
> 6) `GUIDE`: one or more guides (*axes, legends, etc.*).

(page 7 of *The Grammar of Graphics*)

## Aesthetics
(chapter 10)

* Form (position, size)
* Surface (color, texture)
* Motion (direction, speed)
* Sound (tone, volume)
* Text

"Sound" is part of the grammar even
though we might not see it graphically.

## Guides
(chapter 12)

Guides relate graphical information to
non-graphical annotations

* Scales (axis, legend)
* Annotations (text, image)

## Variables
(chapter 4)

Transforms

* Mathematical
* Statistical
* Multivariate

## Geometry
(chapter 8)

Geometric graphs

* Functions (point, line, area, &c.)
* Partitions (polygon, contour)
* Networks (edge)

Collision modifiers

* Stack (symmetric, asymmetric)
* Dodge (symmetric, asymmetric)
* Jitter (uniform, normal)

## Spaces
(chapter 13)

The underlying space versus the display space

## Coordinates
(chapter 9)

Transformations

* Isometry (translation, rotation, reflection)
* Similarity (dilation)
* Affine (stretch, shear)
* Projective
* Conformal

Specific things

* Polar coordinates (conformal)
* Warpings (conformal)
* Map projections (projective)

## Statistics
(chapter 7)

Methods

* Bin
* Summary
* Region
* Smooth
* Link

## Scales
(chapter 6)

* Scale transformations (`TRANS`)
* Nice numbers
* Really nice numbers

## Algebra

* Cross (cross product, factorial)
* Nest (block)
* Blend (concatenate)

## Examples

* Bar graph versus Pie chart
* Histogram
* Faceting
* Napoleon's march
* http://ggplot2.org/resources/2007-past-present-future.pdf
