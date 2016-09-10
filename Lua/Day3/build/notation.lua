local scheduler = require 'scheduler'

local NOTE_DOWN = 0x90
local NOTE_UP = 0x80
local VELOCITY = 0x7f

local function note(letter, octave)
	local notes = {
		C = 0,
		Cs = 1,
		D = 2,
		Ds = 3,
		E = 4,
		F = 5,
		Fs = 6,
		G = 7,
		Gs = 8,
		A = 9,
		As = 10,
		B = 11
	}

	local notes_per_octave = 12

	return (octave + 1) * notes_per_octave + notes[letter]
end

local tempo = 100

local function set_tempo(bpm)
	tempo = bpm
end

local function duration(value)
	local quarter = 60 / tempo
	local duration = {
		h = 2.0,
		q = 1.0,
		ed = 0.75,
		e = 0.5,
		s = 0.25
	}

	return duration[value] * quarter
end

local function velocity(value)
	value = tonumber(value)
	if (value < 0) then
		value = 0
	end
	if (value > 127) then
		value = 127
	end
	return value
end

local function parse_note(s)
	local letter, octave, value, volume =
		string.match(s, "([A-Gs]+)(%d+)(%a+)(%d+)")

	-- print(letter)
	-- print(octave)
	-- print(value)
	-- print(volume)
	if not (letter and octave and value and volume) then
		return nil
	end

	return {
		note = note(letter, octave),
		duration = duration(value),
		velocity = velocity(volume)
	}
end

local function play(note, duration, velocity)
	midi_send(NOTE_DOWN, note, velocity)
	scheduler.wait(duration)
	midi_send(NOTE_UP, note, velocity)
end

local function part(t)
	local function play_part()
		for i = 1, #t do
			-- print(t[i].note, t[i].duration, t[i].velocity)
			play(t[i].note, t[i].duration, t[i].velocity)
		end
	end

	scheduler.schedule(0.0, coroutine.create(play_part))
end

local function go()
	scheduler.run()
end

local mt = {
	__index = function(t, s)
		local result = parse_note(s)
		return result or rawget(t, s)
	end
}

setmetatable(_G, mt)

return {
	parse_note = parse_note,
	play = play,
	part = part,
	set_tempo = set_tempo,
	go = go
	}