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

- From the project root:

```bash
FABulous .
```

- Inside the FABulous shell:

```FABulous
gen_bitStream_spec
```

```FABulous
gen_bitStream_binary out.fasm
```

## Uploading the Bitstream

Clone the following repo to an arbitrary path:

```bash
git clone https://github.com/EverythingElseWasAlreadyTaken/FABulous_fabric_demo.git
cd FABulous_fabric_demo
```

Create a virtual environment and install the requirements:

```bash
virtualenv venv
source venv/bin/activate
pip install -r requirements.txt
```

Once the setup is complete, you can upload your bitstream to the board with the following command:

```bash
./board.py upload -b 57600 PATH_TO_YOUR_MPW2_PROJECT/YOUR_OUTPUT.bin
```
