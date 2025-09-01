# MPW2 eFPGA FABulous project

## Synthesize

```bash
yosys -m ghdl -p "ghdl --std=08 $(echo user_design/*.vhd) -e top; read_verilog user_design/top_wrapper.v; synth_fabulous -top top_wrapper -json out.json -extra-plib user_design/custom_prims.v"
```

## PNR

```bash
FAB_ROOT=$(pwd) nextpnr-generic --freq 1 --uarch fabulous --json out.json -o fasm=out.fasm
```

## Generate Bitstream

From the project root:

```bash
FABulous .
```

Inside the FABulous shell:

gen_bitStream_spec
gen_bitStream_binary out.fasm
