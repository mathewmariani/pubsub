--
-- pubsub
--
-- Copyright (c) 2020 Mathew Mariani
--
-- Permission is hereby granted, free of charge, to any person obtaining a copy of
-- this software and associated documentation files (the "Software"), to deal in
-- the Software without restriction, including without limitation the rights to
-- use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
-- of the Software, and to permit persons to whom the Software is furnished to do
-- so, subject to the following conditions:
--
-- The above copyright notice and this permission notice shall be included in all
-- copies or substantial portions of the Software.
--
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
-- SOFTWARE.
--

local pubsub = { _version = "0.1.0" }
pubsub.__index = pubsub

pubsub.channels = {}

function pubsub:subscribe(channel, obs, fn)
	self[channel] = self[channel] or {}
	local t = {}
	t.o = obs
	t.f = fn
	table.insert(self[channel], t)
end

function pubsub:unsubscribe(channel, obs, fn)
	local c = self[channel]
	if not c then return end
	for i = #c, 1, -1 do
		local t = c[i]
		if t.o == obs and t.f == fn then
			table.remove(c, i)
		end
	end
end

function pubsub:publish(channel, ...)
	local c = self[channel]
	if not c then return end
	for i = 1, #c do
		local t = c[i]
		t.f(t.o, ...)
	end
end

local m = {
	subscribe   = function(...) return pubsub.subscribe(pubsub.channels, ...) end,
	unsubscribe = function(...) return pubsub.unsubscribe(pubsub.channels, ...) end,
	publish     = function(...) return pubsub.publish(pubsub.channels, ...) end,
}
setmetatable(m, pubsub)

return m