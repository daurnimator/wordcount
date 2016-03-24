#!/usr/bin/env lua

local function nextword(str, pos)
	-- Find non-whitespace
	local start_word
	for i=pos, #str do
		local c = str:byte(i, i)
		if c ~= 32 and c ~= 8 then
			start_word = i
			break
		end
	end
	if start_word then
		local end_pos = #str
		for i=start_word+1, #str do
			local c = str:byte(i, i)
			if c == 32 or c == 8 then
				end_pos = i
				break
			end
		end
		return end_pos+1, str:sub(start_word, end_pos)
	end
end
local counts = setmetatable({}, {__index=function() return 0 end})
for line in io.stdin:lines() do
	for _, word in nextword, line, 1 do
		counts[word] = counts[word] + 1
	end
end
local sorted = {}
local n = 0
for word in pairs(counts) do
	n = n + 1
	sorted[n] = word
end
table.sort(sorted, function(a,b)
	local na = counts[a]
	local nb = counts[b]
	if na == nb then
		return a < b
	else
		return na > nb
	end
end)
for i=1, n do
	local word = sorted[i]
	print(word, counts[word])
end
