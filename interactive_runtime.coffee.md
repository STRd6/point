Interactive Runtime
-------------------

    window.Point = require("./point")

Register our example runner.

    Interactive.register "example", ({source, runtimeElement}) ->
      program = CoffeeScript.compile(source, bare: true)

      outputElement = document.createElement "pre"
      runtimeElement.empty().append outputElement

      result = eval(program)

      if result.toFixed
        if result != (0 | result)
          result = result.toFixed(4)

      outputElement.textContent = result
