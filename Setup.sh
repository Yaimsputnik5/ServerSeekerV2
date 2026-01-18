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
sleep 1
echo "------------------------------------------------------------"
echo "ServerSeekerV2 dependencies installed successfully!"
echo
echo "To build ServerSeekerV2, you can:"
echo "  1) Build in cargo:"
echo "       cargo build --release"
echo
echo "  2) Build directly:"
echo "       Use the provided Build.sh script."
echo "------------------------------------------------------------"
