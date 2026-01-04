#!/bin/sh

clear
echo "============================================================"
echo "                  ServerSeekerV2 Runner"
echo "============================================================"
echo

command -v cargo >/dev/null 2>&1 || {
  echo "[ERROR] Rust (cargo) is not installed"
  exit 1
}

command -v masscan >/dev/null 2>&1 || {
  echo "[ERROR] masscan is not installed"
  echo "Install it with: apt install masscan"
  exit 1
}

systemctl is-active --quiet postgresql || {
  echo "[ERROR] PostgreSQL is not running"
  echo "Start it with: systemctl start postgresql"
  exit 1
}

if [ ! -f "./target/release/ServerSeekerV2" ]; then
  echo "[INFO] Release binary not found"
  echo "[INFO] Building now..."
  cargo build --release || exit 1
fi

echo
echo "[OK] Environment ready"
echo

if command -v screen >/dev/null 2>&1; then
  echo "[INFO] 'screen' is installed. Launching ServerSeekerV2 in a screen session..."
  screen -S serverseeker ./target/release/ServerSeekerV2
else
  echo "[WARNING] 'screen' is not installed. Running ServerSeekerV2 normally..."
  ./target/release/ServerSeekerV2
fi
