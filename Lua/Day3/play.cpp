extern "C"
{
#include "lua.h"
#include "lauxlib.h"
#include "lualib.h"
}

#define __RTMIDI_DEBUG__

#include <iostream>
#include "RtMidi.h"
static RtMidiOut midi(RtMidi::LINUX_ALSA);

int midi_send(lua_State* L)
{
	double status = lua_tonumber(L, -3);
	double data1 = lua_tonumber(L, -2);
	double data2 = lua_tonumber(L, -1);

	// std::cout << "status: " << status << std::endl;
	// std::cout << "data1: " << data1 << std::endl;
	// std::cout << "data2: " << data2 << std::endl;

	std::vector<unsigned char> message(3);
	message[0] = static_cast<unsigned char>(status);
	message[1] = static_cast<unsigned char>(data1);
	message[2] = static_cast<unsigned char>(data2);
	// message[0] = 100;
	// message[1] = 68;
	// message[2] = 100;
	// std::cout << "message[0]: " << message[0] << std::endl;
	// std::cout << "message[1]: " << message[1] << std::endl;
	// std::cout << "message[2]: " << message[2] << std::endl;

	midi.sendMessage(&message);

	return 0;
}

int main(int argc, char const *argv[])
{
	std::cout << "checking argc" << std::endl;
	if (argc < 1) { return -1; }

	std::cout << "opening ports" << std::endl;
	unsigned int ports = midi.getPortCount();
	std::cout << "ports: " << ports << std::endl;
	if (ports < 1) { return -1; }
	midi.openPort(1);
	std::cout << "midi.isPortOpen(): " << midi.isPortOpen() << std::endl;

	RtMidi::Api api = midi.getCurrentApi();
	std::cout << "api: " << api << std::endl;

	std::cout << "setting new lua state" << std::endl;
	lua_State* L = luaL_newstate();
	luaL_openlibs(L);

	std::cout << "push c function and set global" << std::endl;
	lua_pushcfunction(L, midi_send);
	lua_setglobal(L, "midi_send");

	std::cout << "printing hello world and dofile" << std::endl;
	luaL_dostring(L, "print('Hello world!')");
	luaL_dostring(L, "song = require 'notation'");
	std::cout << argv[1] << std::endl;
	int dofile_status = luaL_dofile(L, argv[1]);
	std::cout << "dofile status: " << dofile_status << std::endl;
	luaL_dostring(L, "song.go()");

	std::cout << "closing lua" << std::endl;
	lua_close(L);
	return 0;
}