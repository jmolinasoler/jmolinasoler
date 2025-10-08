# Pandoc CV Template

A professional, customizable CV template built with Pandoc that generates beautiful CVs in multiple formats (PDF, HTML, DOCX, and plain text).

## Features

- 📄 **Multiple Output Formats**: PDF (via LaTeX), HTML, DOCX, and plain text
- 🎨 **Professional Styling**: Custom LaTeX template and CSS for polished appearance
- 🔧 **Easy Customization**: Simple Markdown editing with YAML metadata
- 🚀 **Automated Building**: Makefile and shell script for one-command generation
- 📱 **Responsive Design**: HTML output is mobile-friendly
- 🖨️ **Print Optimized**: Print-friendly CSS for HTML version
- ⚡ **Watch Mode**: Automatic rebuilding when files change

## Quick Start

1. **Edit your information** in `cv.md`
2. **Build your CV**: `./build.sh build all`
3. **Find your CV** in the `output/` directory

## Prerequisites

### Fedora 42
```bash
sudo dnf update -y
sudo dnf install -y pandoc texlive-xetex texlive-collection-fontsrecommended texlive-collection-latex texlive-microtype texlive-titlesec texlive-enumitem texlive-fancyhdr texlive-lastpage texlive-fontspec texlive-xcolor texlive-hyperref texlive-geometry texlive-parskip texlive-tex-gyre
```

### Ubuntu/Debian
```bash
sudo apt update
sudo apt install pandoc texlive-xetex texlive-fonts-recommended texlive-plain-generic
```

### macOS
```bash
brew install pandoc
brew install --cask mactex
```

Or use the automatic installer:
```bash
# Fedora 42
make install-deps

# Ubuntu/Debian
make install-deps-debian

# macOS
make install-deps-mac
```

## File Structure

```
personal-cv/
├── cv.md                    # Your CV content (EDIT THIS)
├── cv-template.tex          # LaTeX template for PDF
├── cv-style.css            # CSS styling for HTML
├── pandoc.yaml             # Pandoc configuration
├── Makefile                # Build automation
├── build.sh                # Simple build script
├── reference-template.md   # DOCX reference template
├── output/                 # Generated files
│   ├── cv.pdf
│   ├── cv.html
│   ├── cv.docx
│   └── cv.txt
└── README.md              # This file
```

## Usage

### Using the Build Script (Recommended)

```bash
# Build all formats
./build.sh build all

# Build specific format
./build.sh build pdf
./build.sh build html
./build.sh build docx

# Preview HTML in browser
./build.sh preview

# Watch for changes and auto-rebuild
./build.sh watch

# Clean generated files
./build.sh clean

# Check dependencies
./build.sh check
```

### Using Make Directly

```bash
# Build all formats
make all

# Build specific formats
make pdf
make html
make docx
make txt

# Preview in browser
make preview

# Watch for changes (requires 'entr')
make watch

# Clean generated files
make clean

# Check dependencies
make check-deps
```

## Customization

### Editing Your CV Content

Edit `cv.md` to customize your CV. The file includes:

- **YAML Header**: Personal information, contact details, styling options
- **Markdown Content**: Your experience, education, skills, etc.

Key YAML variables you should customize:
```yaml
title: "Your Name"
subtitle: "Your Professional Title"
email: "your.email@example.com"
phone: "+1 (555) 123-4567"
address: "Your City, Country"
linkedin: "linkedin.com/in/yourprofile"
github: "github.com/yourusername"
website: "www.yourwebsite.com"
```

### Styling Customization

#### PDF Styling (LaTeX)
- Edit `cv-template.tex` to modify PDF appearance
- Change colors by modifying the `\definecolor` commands
- Adjust fonts by modifying the `\setmainfont` and `\setsansfont` commands
- Modify spacing by adjusting `\titlespacing` commands

#### HTML Styling (CSS)
- Edit `cv-style.css` to modify HTML appearance
- Change colors by modifying the CSS variables in `:root`
- Adjust fonts by modifying the `font-family` properties
- Customize layout and spacing as needed

#### DOCX Styling
- Generate a DOCX file: `make docx`
- Open it in Microsoft Word and modify styles
- Save as `reference.docx` to use as template
- Update Makefile to use `--reference-doc=reference.docx`

### Advanced Configuration

Edit `pandoc.yaml` to modify Pandoc behavior:
- Change paper size, margins, font size
- Enable/disable table of contents
- Modify code highlighting
- Add bibliography support

## Tips and Best Practices

### Content Writing
- Keep descriptions concise and action-oriented
- Use bullet points for easy scanning
- Quantify achievements with numbers when possible
- Tailor content for your target role/industry

### Formatting
- Use consistent date formats throughout
- Keep section order logical (Summary → Experience → Education → Skills)
- Use markdown formatting sparingly for emphasis
- Test in all formats to ensure consistency

### Version Control
- Commit your `cv.md` changes regularly
- Tag releases when applying for jobs
- Keep different versions for different roles in branches

## Troubleshooting

### Common Issues

**LaTeX not found**
```bash
# Install LaTeX
sudo dnf install texlive-xetex  # Fedora
sudo apt install texlive-xetex  # Ubuntu/Debian
brew install mactex            # macOS
```

**PDF generation fails**
- Ensure XeLaTeX is installed
- Check for special characters in your content
- Try building without custom fonts first

**Fonts not found**
- Install TeX Gyre fonts or modify template to use system fonts
- For system fonts, change `\setmainfont{TeX Gyre Pagella}` to `\setmainfont{Times New Roman}`

**Watch mode not working**
```bash
# Install entr
sudo dnf install entr          # Fedora
sudo apt install entr          # Ubuntu/Debian
brew install entr              # macOS
```

### Debugging

Enable verbose output:
```bash
# Add --verbose flag to pandoc commands in Makefile
pandoc cv.md --template=cv-template.tex --pdf-engine=xelatex --verbose --output=output/cv.pdf
```

Check pandoc version:
```bash
pandoc --version
```

Test template without content:
```bash
echo "# Test" | pandoc --template=cv-template.tex --pdf-engine=xelatex -o test.pdf
```

## Customization Examples

### Adding a Photo
Add to YAML header:
```yaml
photo: "path/to/photo.jpg"
```

Modify `cv-template.tex` to include the photo in the header section.

### Adding Social Media Links
Extend YAML header:
```yaml
twitter: "twitter.com/yourhandle"
instagram: "instagram.com/yourhandle"
```

Update the template to display these links.

### Custom Sections
Add any section to your markdown:
```markdown
# Hobbies

- Photography
- Rock climbing
- Playing guitar
```

### Color Themes
Modify CSS variables for different color schemes:
```css
:root {
    /* Professional Blue Theme */
    --primary-color: #1e3a8a;
    --secondary-color: #3b82f6;
    
    /* Creative Purple Theme */
    --primary-color: #7c3aed;
    --secondary-color: #a855f7;
}
```

## Contributing

Feel free to:
- Report bugs or request features
- Submit pull requests with improvements
- Share your customizations

## License

This template is free to use and modify for personal and commercial purposes.

## Support

If you encounter issues:
1. Check this README for solutions
2. Verify all dependencies are installed
3. Test with the sample content first
4. Check Pandoc documentation for advanced features

---

**Happy job hunting! 🚀**