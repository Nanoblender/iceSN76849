PROJ_NAME=emuSN
TARGET=hx8k
PACKAGE=ct256
TOP_CELL=top


gen:
	yosys -p "synth_ice40 -top ${TOP_CELL} -json ${PROJ_NAME}.json" *.v
	nextpnr-ice40 --json ${PROJ_NAME}.json --pcf ${PROJ_NAME}.pcf --asc ${PROJ_NAME}.txt --${TARGET} --package ${PACKAGE}
	icepack ${PROJ_NAME}.txt ${PROJ_NAME}.bin

pnr:
	yosys -p "synth_ice40 -top ${TOP_CELL} -json ${PROJ_NAME}.json" *.v
	nextpnr-ice40 --json ${PROJ_NAME}.json --pcf ${PROJ_NAME}.pcf --asc ${PROJ_NAME}.txt --${TARGET} --package ${PACKAGE} --gui

flash: emuSN.bin
	iceprog ${PROJ_NAME}.bin

sim:
	verilator -Wall -cc ${TOP_CELL}.v --exe sim_main.cpp
	make -C obj_dir -f V${TOP_CELL}.mk
	obj_dir/V${TOP_CELL}


clean-sim:
	rm -r obj_dir/

clean:
	rm ${PROJ_NAME}.json ${PROJ_NAME}.txt ${PROJ_NAME}.bin
