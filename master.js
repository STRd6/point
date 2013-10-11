(function() {
  var Point, isObject,
    __slice = [].slice;

  Point = function(x, y) {
    var _ref;
    if (isObject(x)) {
      _ref = x, x = _ref.x, y = _ref.y;
    }
    return {
      __proto__: Point.prototype,
      x: x != null ? x : 0,
      y: y != null ? y : 0
    };
  };

  Point.prototype = {
    clamp: function(n) {
      if (this.magnitude() > n) {
        return this.norm(n);
      } else {
        return this.copy();
      }
    },
    copy: function() {
      return Point(this.x, this.y);
    },
    add: function(first, second) {
      if (second != null) {
        return Point(this.x + first, this.y + second);
      } else {
        return Point(this.x + first.x, this.y + first.y);
      }
    },
    subtract: function(first, second) {
      if (second != null) {
        return Point(this.x - first, this.y - second);
      } else {
        return this.add(first.scale(-1));
      }
    },
    scale: function(scalar) {
      return Point(this.x * scalar, this.y * scalar);
    },
    norm: function(length) {
      var m;
      if (length == null) {
        length = 1.0;
      }
      if (m = this.length()) {
        return this.scale(length / m);
      } else {
        return this.copy();
      }
    },
    equal: function(other) {
      return this.x === other.x && this.y === other.y;
    },
    length: function() {
      return Math.sqrt(this.dot(this));
    },
    magnitude: function() {
      return this.length();
    },
    direction: function() {
      return Math.atan2(this.y, this.x);
    },
    dot: function(other) {
      return this.x * other.x + this.y * other.y;
    },
    cross: function(other) {
      return this.x * other.y - other.x * this.y;
    },
    distance: function(other) {
      return Point.distance(this, other);
    },
    toString: function() {
      return "Point(" + this.x + ", " + this.y + ")";
    }
  };

  Point.distance = function(p1, p2) {
    return Math.sqrt(Point.distanceSquared(p1, p2));
  };

  Point.distanceSquared = function(p1, p2) {
    return Math.pow(p2.x - p1.x, 2) + Math.pow(p2.y - p1.y, 2);
  };

  Point.interpolate = function(p1, p2, t) {
    return p2.subtract(p1).scale(t).add(p1);
  };

  Point.fromAngle = function(angle) {
    return Point(Math.cos(angle), Math.sin(angle));
  };

  Point.direction = function(p1, p2) {
    return Math.atan2(p2.y - p1.y, p2.x - p1.x);
  };

  Point.centroid = function() {
    var points;
    points = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
    return points.reduce(function(sumPoint, point) {
      return sumPoint.add(point);
    }, Point(0, 0)).scale(1 / points.length);
  };

  Point.random = function() {
    return Point.fromAngle(Math.random() * 2 * Math.PI);
  };

  module.exports = Point;

  isObject = function(object) {
    return Object.prototype.toString.call(object) === "[object Object]";
  };

}).call(this);

//# sourceURL=point.coffee