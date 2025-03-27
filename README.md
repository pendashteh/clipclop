# ClipClop 🐎

A playful clipboard history manager for Ubuntu-based Linux desktops.

## Version

Current Version: 0.0.6

## Features

- Automatically save current clipboard content
- Browse clipboard history with fuzzy search
- Preview saved clipboard entries
- Restore entries to clipboard
- Save entries to a new file

## Prerequisites

- Ubuntu or Debian-based Linux distribution
- `xclip`
- `fzf` (Fuzzy Finder)

## Installation

1. Install dependencies:
   ```bash
   sudo apt-get update
   sudo apt-get install xclip fzf
   ```

2. Clone or download the script:
   ```bash
   wget https://raw.githubusercontent.com/yourusername/clipclop/main/clipclop.sh
   ```

3. Make the script executable:
   ```bash
   chmod +x clipclop.sh
   ```

## Configuration

### Data Directory

By default, ClipClop stores clipboard histories in `$HOME/data/clipclop`. 
You can override this by setting the `CLIPCLOP_DATADIR` environment variable:

```bash
export CLIPCLOP_DATADIR="/path/to/your/preferred/directory"
```

## Usage

Run the script:
```bash
./clipclop.sh
```

### Workflow
1. Script automatically saves current clipboard
2. Browse clipboard history
3. Select an entry to reveal options:
   - Copy to Clipboard
   - Save to File
   - Back to List
   - Exit

## Advanced Features

- Fuzzy search through clipboard content
- Preview entries with scrolling (Ctrl+P/Ctrl+N)
- Quick copy to clipboard (Ctrl+Y in list view)

## Changelog

### v0.0.6
- Configurable data directory
- Improved content-based searching
- Enhanced preview and interaction features

## Suggested Improvements

1. Limit clipboard entries
2. Advanced search capabilities
3. Entry metadata
4. Custom configuration options
5. Additional clipboard operations

## Troubleshooting

- Ensure `xclip` and `fzf` are installed
- Check script permissions
- Verify clipboard access permissions

## Contributing

1. Fork the repository
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## License

[Specify your license here, e.g., MIT, GPL]

## Author

[Your Name]
