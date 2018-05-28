gen:
	yosys -p "synth_ice40 -blif emuSN.blif" top.v control_reg.v tone.v noise.v mixer.v serial.v reception.v dac.v
	arachne-pnr -d 8k -P ct256 -p emuSN.pcf emuSN.blif -o emuSN.txt
	icepack emuSN.txt emuSN.bin

flash: emuSN.bin
	iceprog emuSN.bin
clean:
	rm emuSN.blif emuSN.txt emuSN.bin
