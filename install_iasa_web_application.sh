#!/bin/bash
# Kent 'picat' Gruber

# Set variables
SUDO_CHECK=false
PACKAGE_MANAGER=false
LOG_DIR="/log"
LOG_FILE="installer_log.log"
LOG="$LOG_DIR/$LOG_FILE"

function Help_Menu {
  echo "EMU IASA WEB APP INSTALLER
  -d     Use default options ( -c, -a, -s, -r, -g )
  -a     Download all required dependencies.
  -c     Check system dependencies.
  -s     Use sudo for this installer.
  -g     Download required gems.
  -r     Download RVM.
  -s     Download sinatra gem.
  -l     Download lolize gem.
  -t     Download thin gem.
  -o     Download openssl.
  -R     Download relevant rack gems.
  -p     Specify a package manager to use.
  -v     Display version.
  -h     Display this menu."
}

# Default to calling that Help_Menu
if [ $# -eq 0 ]; then
  echo "No arguments supplied!"
  Help_Menu
  exit 1
fi

# Decided to put everything into fun functions because functions are fun.
function Version_Check {
  echo "GENERATE SELF-SIGNED SSL CERT THINGS v 0.000000001"
}

# The main openssl thing basically.
function Default_Installer {
  echo "[*] Default Download Option"
  # All the default install instructions go here...
}

# The function to download all dependencies.
function Dowload_All_Dependencies {
  echo "[*] Downloading all dependencies..."

}

# Download required gems.
function Dowload_All_Dependencies {
  echo "[*] Downloading the required gems..."
}

# Check that we can actually do the things because we have the things to do the things with to do our things, k?
function Check_for_Openssl {
  echo "[*] Checking if openssl is installed."
  if which openssl >/dev/null; then
    echo "[+] Found openssl!"
  else
    echo "[-] Unable to find openssl."
    exit 1
  fi
}

# Functional programming really lends itself to having a "Main" function. So, like, why not? Right?
function Main {
  echo "GENERATE SELF-SIGNED SSL CERT THINGS"
  Check_for_Openssl
  Trust_Me
  exit 0
}

# Bam, more functions, because option parsing!
function parseOpts() {
  # 5. Parse user arguments.
  while getopts :hgv opt; do
    case $opt in
      h) # Help
        Help_Menu
        # I need somebody
        # Help, not just anybody
        # Help, you know I need someone
        # The Beatles
        exit 0
        ;;
      v) # Version check
        Version_Check
        exit 0
        ;;
      g) # Basically, do what this is meant to do.
        Main
        ;;
      \?) # Invalid arg
        echo "Invalid option: -$OPTARG"
        Help_Menu
        exit 1
        ;;
      :) # Missing arg
        echo "An argument must be specified for -$OPTARG"
        Help_Menu
        exit 1
        ;;
        esac
        done
}

# Not a function, but essentially triggers the rest of the application.
# Parse Arguments
parseOpts "$@"
