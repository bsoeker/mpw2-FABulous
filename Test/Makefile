MAX_BITBYTES=16384
FAB_PROJ_ROOT=..
BUILD_DIR=build
DESIGN=top
TESTBENCH=${DESIGN}_tb
TOP_WRAPPER=top_wrapper

USER_DESIGN_DIR=${FAB_PROJ_ROOT}/user_design
USER_DESIGN_VHDL := $(wildcard ../user_design/*.vhd)

TOP_WRAPPER_VERILOG=${USER_DESIGN_DIR}/${TOP_WRAPPER}.v # Still needs to be verilog, since it is more like a constraint file for yosys
FAB_TILE_FOLDER=${FAB_PROJ_ROOT}/Tile
FAB_FABRIC_FOLDER=${FAB_PROJ_ROOT}/Fabric
FABRIC_FILES_DIR=${BUILD_DIR}/fabric_files
WAVEFORM_TYPE=fst

VVP_ARGS=+output_waveform=${BUILD_DIR}/${DESIGN}.${WAVEFORM_TYPE}
VVP_ARGS+=+bitstream_hex=${BUILD_DIR}/${DESIGN}.hex
ifeq ($(WAVEFORM_TYPE),fst)
    VVP_ARGS+=-fst
endif

GHDL=ghdl
GHDL_FLAGS=--std=08 -O2 --workdir=${BUILD_DIR}

#only add if custom_prims.v exists
ifneq ($(wildcard ${USER_DESIGN_DIR}/custom_prims.v),)
		CUSTOM_PRIMS=-extra-plib ${USER_DESIGN_DIR}/custom_prims.v
endif

.PHONY: all run_FABulous_demo full build_test_design run_simulation mkdir_build clean FAB_sim build_demo_fabric

sim: build_test_design run_simulation clean

build_test_design: run_yosys run_nextpnr run_bitgen

run_yosys: mkdir_build
	yosys -m ghdl -p "ghdl --std=08 ${USER_DESIGN_VHDL} -e ${DESIGN}; read_verilog ${TOP_WRAPPER_VERILOG}; synth_fabulous -top ${TOP_WRAPPER} -json ${BUILD_DIR}/${DESIGN}.json ${CUSTOM_PRIMS};"

run_nextpnr: mkdir_build
	FAB_ROOT=${FAB_PROJ_ROOT} nextpnr-generic --freq 1 --uarch fabulous --json ${BUILD_DIR}/${DESIGN}.json -o fasm=${BUILD_DIR}/${DESIGN}.fasm

run_bitgen: mkdir_build
	bit_gen -genBitstream ${BUILD_DIR}/${DESIGN}.fasm ${FAB_PROJ_ROOT}/.FABulous/bitStreamSpec.bin ${BUILD_DIR}/${DESIGN}.bin
	python3 makehex.py ${BUILD_DIR}/${DESIGN}.bin ${MAX_BITBYTES} ${BUILD_DIR}/${DESIGN}.hex

mkdir_build:
	mkdir -p ${BUILD_DIR}
	mkdir -p ${FABRIC_FILES_DIR}

copy_files: mkdir_build
	find ${FAB_PROJ_ROOT}/Tile/ -name '*.v' -type f -print0 | xargs -0 cp -u -t ./${FABRIC_FILES_DIR}/
	find ${FAB_PROJ_ROOT}/Fabric/ -name '*.v' -type f -print0 | xargs -0 cp -u -t ./${FABRIC_FILES_DIR}/

run_GTKWave:
	gtkwave ${BUILD_DIR}/${DESIGN}.fst

clean:
	rm -rf ${BUILD_DIR}

run_simulation: copy_files
	iverilog -s ${TESTBENCH} -o ${BUILD_DIR}/${DESIGN}.vvp ${FABRIC_FILES_DIR}/* ${TESTBENCH}.v -g2012
	vvp ${BUILD_DIR}/${DESIGN}.vvp ${VVP_ARGS}

