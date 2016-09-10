song = require 'notation'

song.set_tempo(50)

song.part{
	D3s127, Fs3s127, A3s127, D4s127,
	A2s127, Cs3s127, E3s127, A3s127,
	B2s127, D3s127, Fs3s127, B3s127,
	Fs2s127, A2s127, Cs3s127, Fs3s127,

	G2s127, B2s127, D3s127, G3s127,
	D2s127, Fs2s127, A2s127, D3s127,
	G2s127, B2s127, D3s127, G3s127,
	A2s127, Cs3s127, E3s127, A3s127
}

song.part{
	Fs4ed127, Fs5s127,
	Fs5s127, G5s127, Fs5s127, E5s127,
	D5ed127, D5s127,
	D5s127, E5s127, D5s127, Cs5s127,

	B4q127,
	D5q127,
	D5s127, C5s127, B4s127, C5s127,
	A4q127
}

song.go()