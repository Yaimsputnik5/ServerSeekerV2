#!/bin/sh

clear
echo "------------------------------------------------------------"
echo "Step 1: Installing required system packages..."
echo "------------------------------------------------------------"

apt install -y build-essential pkg-config libssl-dev libpq-dev curl git screen
apt install -y postgresql postgresql-contrib

if ! command -v rustc >/dev/null 2>&1; then
    echo "Rust not found, installing rustup..."
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    export PATH="$HOME/.cargo/bin:$PATH"
fi

clear
echo "------------------------------------------------------------"
echo "Step 2: Ensuring Rust 1.82.0 is installed..."
echo "------------------------------------------------------------"

rustup install 1.82.0
rustup override set 1.82.0

rustc --version
cargo --version

clear
echo "------------------------------------------------------------"
echo "Step 3: Cleaning previous build artifacts..."
echo "------------------------------------------------------------"

cargo clean
sleep 1

clear
echo "------------------------------------------------------------"
echo "Step 4: Compiling ServerSeekerV2 (release mode)..."
echo "------------------------------------------------------------"

cargo build --release

if [ $? -ne 0 ]; then
    echo "------------------------------------------------------------"
    echo "Build failed! Check the errors above and rerun Setup.sh"
    echo "------------------------------------------------------------"
    exit 1
fi

clear
echo "------------------------------------------------------------"
echo "Step 5: Copying config.toml to build directory"
echo "------------------------------------------------------------"
cp config.toml /target/release

clear
sleep 1
echo "------------------------------------------------------------"
echo "ServerSeekerV2 built successfully!"
echo
echo "To start ServerSeekerV2, you can:"
echo "  1) Run in cargo:"
echo "       cargo run --release"
echo
echo "  2) Run directly:"
echo "       ./target/release/ServerSeekerV2"
echo
echo "If you plan to use masscan or scan networks, ensure you run as root or with sudo."
echo "------------------------------------------------------------"
