scheduler = require 'scheduler'
notation = require 'notation'

notes = {
	'C4q',
	'D4q',
	'E4q',
	'F4q',
	--
	'D4q',
	'E4q',
	'D4q',
	'G4q',
	'Fs4h'
}

function play_song()
	for i = 1, #notes do
		local symbol = notation.parse_note(notes[i])
		notation.play(symbol.note, symbol.duration)
	end
end

print('start good_morning_to_all')
scheduler.schedule(0.0, coroutine.create(play_song))
scheduler.run()
