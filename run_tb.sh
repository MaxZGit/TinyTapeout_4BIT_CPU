# store this file in the root folder of your project.
# use: bash run_tb.sh <tb/tb_file.v>


if [ $# -ne 1 ]; then
    echo "Usage: $0 <testbench_file.v>"
    exit 1
fi

TB_FILE=$1

TB_BASENAME=$(basename "$TB_FILE" .v)
TB_NAME=$(basename "$TB_FILE")
TB_COMPILED="${TB_BASENAME}_compiled"
TB_VCD="${TB_BASENAME}.vcd"

BUILD_FOLDER="build"
mkdir -p "$BUILD_FOLDER"

SIM_FOLDER="sim"
mkdir -p "$SIM_FOLDER"

echo "[INFO] Compiling $TB_FILE..."
iverilog -g2005 -o "$BUILD_FOLDER/$TB_COMPILED" "$TB_FILE"
if [ $? -ne 0 ]; then
    echo "[ERROR] Compilation failed!"
    exit 1
fi

echo "[INFO] Running simulation..."
vvp "$BUILD_FOLDER/$TB_COMPILED"
if [ $? -ne 0 ]; then
    echo "[ERROR] Simulation failed!"
    exit 1
fi

echo "[INFO] Opening $TB_VCD in GTKWave..."
gtkwave "$SIM_FOLDER/$TB_VCD" &