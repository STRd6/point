Point = require "../point"

ok = assert
equals = assert.equal

TAU = 2 * Math.PI

describe "Point", ->

  TOLERANCE = 0.00001

  equalEnough = (expected, actual, tolerance, message) ->
    message ||= "" + expected + " within " + tolerance + " of " + actual
    ok(expected + tolerance >= actual && expected - tolerance <= actual, message)

  it "copy constructor", ->
    p = Point(3, 7)

    p2 = Point(p)

    equals p2.x, p.x
    equals p2.y, p.y

  it "#add", ->
    p1 = Point(5, 6)
    p2 = Point(7, 5)

    result = p1.add(p2)

    equals result.x, p1.x + p2.x
    equals result.y, p1.y + p2.y

    equals p1.x, 5
    equals p1.y, 6
    equals p2.x, 7
    equals p2.y, 5

  it "#add with two arguments", ->
    point = Point(3, 7)
    x = 2
    y = 1

    result = point.add(x, y)

    equals result.x, point.x + x
    equals result.y, point.y + y

    x = 2
    y = 0

    result = point.add(x, y)

    equals result.x, point.x + x
    equals result.y, point.y + y

  it "#add existing", ->
    p = Point(0, 0)

    p.add(Point(3, 5))

    equals p.x, 0
    equals p.y, 0

  it "#subtract", ->
    p1 = Point(5, 6)
    p2 = Point(7, 5)

    result = p1.subtract(p2)

    equals result.x, p1.x - p2.x
    equals result.y, p1.y - p2.y

  it "#subtract existing", ->
    p = Point(8, 6)

    p.subtract(3, 4)

    equals p.x, 8
    equals p.y, 6

  it "#norm", ->
    p = Point(2, 0)

    normal = p.norm()
    equals normal.x, 1

    normal = p.norm(5)
    equals normal.x, 5

    p = Point(0, 0)

    normal = p.norm()
    equals normal.x, 0, "x value of norm of point(0,0) is 0"
    equals normal.y, 0, "y value of norm of point(0,0) is 0"

  it "#norm existing", ->
    p = Point(6, 8)

    p.norm(5)

    equals p.x, 6
    equals p.y, 8

  it "#scale", ->
    p = Point(5, 6)
    scalar = 2

    result = p.scale(scalar)

    equals result.x, p.x * scalar
    equals result.y, p.y * scalar

    equals p.x, 5
    equals p.y, 6

  it "#scale existing", ->
    p = Point(0, 1)
    scalar = 3

    p.scale(scalar)

    equals p.x, 0
    equals p.y, 1

  it "#equal", ->
    ok Point(7, 8).equal(Point(7, 8))

  it "#magnitude", ->
    equals Point(3, 4).magnitude(), 5

  it "#length", ->
    equals Point(0, 0).length(), 0
    equals Point(-1, 0).length(), 1

  it "#toString", ->
    p = Point(7, 5)
    ok eval(p.toString()).equal(p)

  it "#clamp", ->
    p = Point(10, 10)
    p2 = p.clamp(5)

    equals p2.length(), 5

  it ".centroid", ->
    centroid = Point.centroid(
      Point(0, 0),
      Point(10, 10),
      Point(10, 0),
      Point(0, 10)
    )

    equals centroid.x, 5
    equals centroid.y, 5

  it ".fromAngle", ->
    p = Point.fromAngle(TAU / 4)

    equalEnough p.x, 0, TOLERANCE
    equals p.y, 1

  it ".random", ->
    p = Point.random()

    ok p

  it ".interpolate", ->
    p1 = Point(10, 7)
    p2 = Point(-6, 29)

    ok p1.equal(Point.interpolate(p1, p2, 0))
    ok p2.equal(Point.interpolate(p1, p2, 1))
