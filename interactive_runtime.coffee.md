Interactive Runtime
-------------------

    window.Point = require("./point")

Register our example runner.

    Interactive.register "example", ({source, runtimeElement}) ->
      program = CoffeeScript.compile(source, bare: true)

      outputElement = document.createElement "pre"
      runtimeElement.empty().append outputElement

      result = eval(program)

      if typeof result is "number"
        if result != (0 | result)
          result = result.toFixed(4)
    

      outputElement.textContent = result
