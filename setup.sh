#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' 

print_green() {
    echo -e "${GREEN}$1${NC}"
}

print_yellow() {
    echo -e "${YELLOW}$1${NC}"
}

print_red() {
    echo -e "${RED}$1${NC}"
}

chmod +x "$0"

if [ -d "../node_modules" ]; then
    print_green "Found node_modules in parent directory"
    MODULES_DIR=".."
else
    print_green "Using current directory for node_modules"
    MODULES_DIR="."
fi

create_default_configs() {
    cat > configs.json << EOL
{
  "limit": 100,
  "countdown": 300,
  "referralCode": "ko8u3JXw",
  "delayEachAccount": [1, 81],
  "doChristmasTasks": true
}
EOL
}


while true; do
    clear
    echo "============================================================================"
    echo "    PAWS BOT SETUP AND RUN SCRIPT by @MeoMunDep"
    echo "============================================================================"
    echo
    echo "Current directory: $(pwd)"
    echo "Node modules directory: $MODULES_DIR/node_modules"
    echo
    echo "1. Install/Update Node.js Dependencies"
    echo "2. Create/Edit Configuration Files"
    echo "3. Run the Bot"
    echo "4. Exit"
    echo
    read -p "Enter your choice (1-4): " choice

    case $choice in
        1)
            clear
            print_yellow "Installing/Updating Node.js dependencies..."
            cd "$MODULES_DIR"
            npm install user-agents axios colors p-limit https-proxy-agent socks-proxy-agent crypto-js ws uuid xlsx readline-sync
            cd - > /dev/null
            print_green "Dependencies installation completed!"
            read -p "Press Enter to continue..."
            ;;
        2)
            clear
            print_yellow "Setting up configuration files..."

            if [ ! -f configs.json ]; then
                create_default_configs
                print_green "Created configs.json with default values"
            fi

            

            for file in datas.txt wallets.txt proxies.txt; do
                if [ ! -f "$file" ]; then
                    touch "$file"
                    print_green "Created $file"
                fi
            done

            print_green "\nConfiguration files have been created/checked."
            print_yellow "Please edit the files with your data before running the bot."
            read -p "Press Enter to continue..."
            ;;
        3)
            clear
            print_yellow "Checking configuration before starting..."
            if ! check_configs; then
                print_red "Error: Invalid configuration detected. Please run option 2 to fix configuration."
                read -p "Press Enter to continue..."
                continue
            fi

            print_green "Starting the bot..."
            if [ -d "../node_modules" ]; then
                print_green "Using node_modules from parent directory"
            else
                print_green "Using node_modules from current directory"
            fi
            node meomundep
            read -p "Press Enter to continue..."
            ;;
        4)
            print_green "Exiting..."
            exit 0
            ;;
        *)
            print_red "Invalid option. Please try again."
            read -p "Press Enter to continue..."
            ;;
    esac
done
