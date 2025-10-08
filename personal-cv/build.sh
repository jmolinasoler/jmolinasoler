#!/bin/bash

# CV Builder Script
# A simple wrapper around the Makefile for easier use

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print colored output
print_color() {
    printf "${2}${1}${NC}\n"
}

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to check dependencies
check_dependencies() {
    print_color "Checking dependencies..." "$BLUE"
    
    if ! command_exists pandoc; then
        print_color "ERROR: pandoc is not installed" "$RED"
        print_color "Install with: sudo dnf install pandoc (Fedora) or sudo apt install pandoc (Ubuntu/Debian) or brew install pandoc (macOS)" "$YELLOW"
        exit 1
    fi
    
    if ! command_exists xelatex; then
        print_color "ERROR: xelatex is not installed" "$RED"
        print_color "Install with: sudo dnf install texlive-xetex (Fedora) or sudo apt install texlive-xetex (Ubuntu/Debian) or brew install mactex (macOS)" "$YELLOW"
        exit 1
    fi
    
    print_color "All dependencies are installed ✓" "$GREEN"
}

# Function to build CV
build_cv() {
    local format="$1"
    
    print_color "Building CV in $format format..." "$BLUE"
    
    case "$format" in
        "pdf")
            make pdf
            ;;
        "html")
            make html
            ;;
        "docx")
            make docx
            ;;
        "txt")
            make txt
            ;;
        "all")
            make all
            ;;
        *)
            print_color "ERROR: Unknown format '$format'" "$RED"
            show_usage
            exit 1
            ;;
    esac
    
    print_color "CV built successfully in $format format ✓" "$GREEN"
}

# Function to show usage
show_usage() {
    echo "Usage: $0 [COMMAND] [OPTIONS]"
    echo ""
    echo "Commands:"
    echo "  build [format]   Build CV (formats: pdf, html, docx, txt, all)"
    echo "  clean           Remove generated files"
    echo "  preview         Open HTML version in browser"
    echo "  watch           Watch for changes and rebuild"
    echo "  check           Check dependencies"
    echo "  install         Install dependencies (Fedora)"
    echo "  install-debian  Install dependencies (Ubuntu/Debian)"
    echo "  install-mac     Install dependencies (macOS)"
    echo "  help            Show this help message"
    echo ""
    echo "Examples:"
    echo "  $0 build pdf     # Build PDF version"
    echo "  $0 build all     # Build all formats"
    echo "  $0 preview       # Build HTML and open in browser"
    echo "  $0 watch         # Watch for changes"
}

# Main script logic
case "${1:-build}" in
    "build")
        check_dependencies
        build_cv "${2:-all}"
        ;;
    "clean")
        print_color "Cleaning generated files..." "$BLUE"
        make clean
        print_color "Cleaned successfully ✓" "$GREEN"
        ;;
    "preview")
        check_dependencies
        print_color "Building and previewing CV..." "$BLUE"
        make preview
        ;;
    "watch")
        check_dependencies
        print_color "Starting watch mode..." "$BLUE"
        make watch
        ;;
    "check")
        check_dependencies
        ;;
    "install")
        print_color "Installing dependencies (Fedora)..." "$BLUE"
        make install-deps
        print_color "Dependencies installed ✓" "$GREEN"
        ;;
    "install-debian")
        print_color "Installing dependencies (Ubuntu/Debian)..." "$BLUE"
        make install-deps-debian
        print_color "Dependencies installed ✓" "$GREEN"
        ;;
    "install-mac")
        print_color "Installing dependencies (macOS)..." "$BLUE"
        make install-deps-mac
        print_color "Dependencies installed ✓" "$GREEN"
        ;;
    "help"|"-h"|"--help")
        show_usage
        ;;
    *)
        print_color "ERROR: Unknown command '$1'" "$RED"
        show_usage
        exit 1
        ;;
esac