
Create a new point with given x and y coordinates. If no arguments are given
defaults to (0, 0).

>     #! example
>     Point()

----

>     #! example
>     Point(-2, 5)

----

    Point = (x, y) ->
      if isObject(x)
        {x, y} = x

      __proto__: Point.prototype
      x: x ? 0
      y: y ? 0

Point protoype methods.

    Point:: =

Constrain the magnitude of a vector.

      clamp: (n) ->
        if @magnitude() > n
          @norm(n)
        else
          @copy()

Creates a copy of this point.

      copy: ->
        Point(@x, @y)

>     #! example
>     Point(1, 1).copy()

----

Adds a point to this one and returns the new point. You may
also use a two argument call like `point.add(x, y)`
to add x and y values without a second point object.

      add: (first, second) ->
        if second?
          Point(
            @x + first
            @y + second
          )
        else
          Point(
            @x + first.x,
            @y + first.y
          )

>     #! example
>     Point(2, 3).add(Point(3, 4))

----

Subtracts a point to this one and returns the new point.

      subtract: (first, second) ->
        if second?
          Point(
            @x - first,
            @y - second
          )
        else
          @add(first.scale(-1))

>     #! example
>     Point(1, 2).subtract(Point(2, 0))

----

Scale this Point (Vector) by a constant amount.

      scale: (scalar) ->
        Point(
          @x * scalar,
          @y * scalar
        )

>     #! example
>     point = Point(5, 6).scale(2)

----

The `norm` of a vector is the unit vector pointing in the same direction. This method
treats the point as though it is a vector from the origin to (x, y).

      norm: (length=1.0) ->
        if m = @length()
          @scale(length/m)
        else
          @copy()

>     #! example
>     point = Point(2, 3).norm()

----

Determine whether this `Point` is equal to another `Point`. Returns `true` if 
they are equal and `false` otherwise.

      equal: (other) ->
        @x == other.x && @y == other.y

>     #! example
>     point = Point(2, 3)
>
>     point.equal(Point(2, 3))

----

Computed the length of this point as though it were a vector from (0,0) to (x,y).

      length: ->
        Math.sqrt(@dot(this))

>     #! example
>     Point(5, 7).length()

----

Calculate the magnitude of this Point (Vector).

      magnitude: ->
        @length()

>     #! example
>     Point(5, 7).magnitude()
  
----

Returns the direction in radians of this point from the origin.

      direction: ->
        Math.atan2(@y, @x)

>     #! example
>     point = Point(0, 1)
>
>     point.direction()

----

Calculate the dot product of this point and another point (Vector).

      dot: (other) ->
        @x * other.x + @y * other.y


`cross` calculates the cross product of this point and another point (Vector).
Usually cross products are thought of as only applying to three dimensional vectors,
but z can be treated as zero. The result of this method is interpreted as the magnitude
of the vector result of the cross product between [x1, y1, 0] x [x2, y2, 0]
perpendicular to the xy plane.

      cross: (other) ->
        @x * other.y - other.x * @y


`distance` computes the Euclidean distance between this point and another point.

      distance: (other) ->
        Point.distance(this, other)

>     #! example
>     pointA = Point(2, 3)
>     pointB = Point(9, 2)
>
>     pointA.distance(pointB)

----

`toString` returns a string representation of this point. The representation is
such that if `eval`d it will return a `Point`

      toString: ->
        "Point(#{@x}, #{@y})"

`distance` Compute the Euclidean distance between two points.

    Point.distance = (p1, p2) ->
      Math.sqrt(Point.distanceSquared(p1, p2))

>     #! example
>     pointA = Point(2, 3)
>     pointB = Point(9, 2)
>
>     Point.distance(pointA, pointB)

----

`distanceSquared` The square of the Euclidean distance between two points.

    Point.distanceSquared = (p1, p2) ->
      Math.pow(p2.x - p1.x, 2) + Math.pow(p2.y - p1.y, 2)

>     #! example
>     pointA = Point(2, 3)
>     pointB = Point(9, 2)
>
>     Point.distanceSquared(pointA, pointB)

----

`interpolate` returns a point along the path from p1 to p2

    Point.interpolate = (p1, p2, t) ->
      p2.subtract(p1).scale(t).add(p1)

Construct a point on the unit circle for the given angle.

    Point.fromAngle = (angle) ->
      Point(Math.cos(angle), Math.sin(angle))

>     #! example
>     Point.fromAngle(Math.PI / 2)

----

If you have two dudes, one standing at point p1, and the other
standing at point p2, then this method will return the direction
that the dude standing at p1 will need to face to look at p2.

>     #! example
>     p1 = Point(0, 0)
>     p2 = Point(7, 3)
>
>     Point.direction(p1, p2)

    Point.direction = (p1, p2) ->
      Math.atan2(
        p2.y - p1.y,
        p2.x - p1.x
      )

The centroid of a set of points is their arithmetic mean.

    Point.centroid = (points...) ->
      points.reduce((sumPoint, point) ->
        sumPoint.add(point)
      , Point(0, 0))
      .scale(1/points.length)

Generate a random point on the unit circle.

    Point.random = ->
      Point.fromAngle(Math.random() * 2 * Math.PI)

Export

    module.exports = Point

Helpers
-------

    isObject = (object) ->
      Object.prototype.toString.call(object) is "[object Object]"

Live Examples
-------------

>     #! setup
>     require("/interactive_runtime")
