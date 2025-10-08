# CV Build System
# Generates CV in multiple formats using Pandoc

# Variables
SOURCE = cv.md
TEMPLATE = cv-template.tex
CSS = cv-style.css
OUTPUT_DIR = output
PDF_OUTPUT = $(OUTPUT_DIR)/cv.pdf
HTML_OUTPUT = $(OUTPUT_DIR)/cv.html
DOCX_OUTPUT = $(OUTPUT_DIR)/cv.docx
TXT_OUTPUT = $(OUTPUT_DIR)/cv.txt

# Default target
all: pdf html docx txt

# Create output directory
$(OUTPUT_DIR):
	mkdir -p $(OUTPUT_DIR)

# PDF generation using custom LaTeX template
pdf: $(PDF_OUTPUT)
$(PDF_OUTPUT): $(SOURCE) $(TEMPLATE) | $(OUTPUT_DIR)
	pandoc $(SOURCE) \
		--template=$(TEMPLATE) \
		--pdf-engine=xelatex \
		--variable=geometry:margin=1in \
		--variable=fontsize=11pt \
		--variable=colorlinks:true \
		--output=$@

# HTML generation with custom CSS
html: $(HTML_OUTPUT)
$(HTML_OUTPUT): $(SOURCE) $(CSS) | $(OUTPUT_DIR)
	pandoc $(SOURCE) \
		--standalone \
		--css=$(CSS) \
		--metadata title="CV" \
		--to=html5 \
		--output=$@

# DOCX generation
docx: $(DOCX_OUTPUT)
$(DOCX_OUTPUT): $(SOURCE) | $(OUTPUT_DIR)
	pandoc $(SOURCE) \
		--standalone \
		--output=$@

# Plain text generation
txt: $(TXT_OUTPUT)
$(TXT_OUTPUT): $(SOURCE) | $(OUTPUT_DIR)
	pandoc $(SOURCE) \
		--to=plain \
		--output=$@

# Clean generated files
clean:
	rm -rf $(OUTPUT_DIR)

# Quick preview in browser (HTML)
preview: html
	@if command -v xdg-open > /dev/null; then \
		xdg-open $(HTML_OUTPUT); \
	elif command -v open > /dev/null; then \
		open $(HTML_OUTPUT); \
	else \
		echo "Please open $(HTML_OUTPUT) in your browser"; \
	fi

# Watch for changes and rebuild (requires entr)
watch:
	@if command -v entr > /dev/null; then \
		echo "Watching for changes... Press Ctrl+C to stop"; \
		echo $(SOURCE) $(TEMPLATE) $(CSS) | tr ' ' '\n' | entr -r make all; \
	else \
		echo "Install 'entr' package to use watch mode"; \
		echo "On Fedora: sudo dnf install entr"; \
		echo "On Ubuntu/Debian: sudo apt install entr"; \
		echo "On macOS: brew install entr"; \
	fi

# Install dependencies (Fedora)
install-deps:
	sudo dnf update -y
	sudo dnf install -y pandoc texlive-xetex texlive-collection-fontsrecommended texlive-collection-latex texlive-microtype texlive-titlesec texlive-enumitem texlive-fancyhdr texlive-lastpage texlive-fontspec texlive-xcolor texlive-hyperref texlive-geometry texlive-parskip texlive-tex-gyre texlive-fontawesome5 texlive-tikz

# Install dependencies (Ubuntu/Debian)
install-deps-debian:
	sudo apt update
	sudo apt install -y pandoc texlive-xetex texlive-fonts-recommended texlive-plain-generic

# Install dependencies (macOS)
install-deps-mac:
	brew install pandoc
	brew install --cask mactex

# Check if required tools are installed
check-deps:
	@echo "Checking dependencies..."
	@command -v pandoc >/dev/null 2>&1 || { echo "ERROR: pandoc is not installed"; exit 1; }
	@command -v xelatex >/dev/null 2>&1 || { echo "ERROR: xelatex is not installed"; exit 1; }
	@echo "All dependencies are installed ✓"

# Help
help:
	@echo "Available targets:"
	@echo "  all          - Build CV in all formats (default)"
	@echo "  pdf          - Build PDF version"
	@echo "  html         - Build HTML version"
	@echo "  docx         - Build DOCX version"
	@echo "  txt          - Build plain text version"
	@echo "  clean        - Remove generated files"
	@echo "  preview      - Open HTML version in browser"
	@echo "  watch        - Watch for changes and rebuild"
	@echo "  check-deps   - Check if required tools are installed"
	@echo "  install-deps - Install dependencies (Fedora)"
	@echo "  install-deps-debian - Install dependencies (Ubuntu/Debian)"
	@echo "  install-deps-mac - Install dependencies (macOS)"
	@echo "  help         - Show this help message"

.PHONY: all pdf html docx txt clean preview watch install-deps install-deps-debian install-deps-mac check-deps help