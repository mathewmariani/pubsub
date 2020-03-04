# pubsub
A fast, lightweight pub/sub library for Lua.

## Installation
The [pubsub.lua](pubsub.lua?raw=1) file should be dropped into an existing project
and required by it.

```lua
local pubsub = require("pubsub")
``` 

## Usage
```lua
ui = {}
ui._score = 0

function ui:score(value)
  ui._score = ui._score + value
end

pubsub.subscribe("score:update", ui, ui.score)
pubsub.publish("score:update", 100)
```

#### :subscribe(channel, obs, fn)
Subscribes the observer to the specified channel. Sets the function `fn` to be called once data has been posted to the channel.

#### :unsubscribe(channel, obs, fn)
Unsubscribes the observer from the specified channel.

#### :publish(channel, ...)
Posts data to the given channel.

## License
This library is free software; you can redistribute it and/or modify it under
the terms of the MIT license. See [LICENSE](LICENSE) for details.