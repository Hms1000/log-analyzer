# Log Analyzer
- This is a basic log analyzer tool

## Purpose
- The tool is meant to scan logs for potential malicious ip addresses
- Scanning logs regularly gives security analyst, devops and every one in the IT team a heads up and prevent any potential breaches
- The information retrieved by this tools ensures that we protect our network by blocking ip addresses of malicious actors
- By taking proactive action we are empowered to comply with various regulations such as (e.g. GDPR, ISO) regarding safe keeping of data

## Project Structure
- `analyzer.sh`: The core Bash logic for log parsing.
- [docs/analyzer.service](./docs/analyzer.service): The systemd unit file configuration.
- [docs/Learnings.md](./docs/Learnings.md): Technical challenges and solutions found during development.

## Deployment
1. Move the project to the standard production directory:
   `sudo mv log-analyzer /opt/`
2. Set up the systemd service for automation:
   `sudo cp /opt/log-analyzer/docs/analyzer.service /etc/systemd/system/`
   `sudo systemctl enable --now analyzer.service`

## Key Features
- **Regex Parsing:** Uses optimized patterns to extract IPv4 addresses from `/var/log/auth.log`.
- **Threshold Detection:** Automatically flags IPs with 5 or more failed login attempts.
- **Automated Archiving:** Compresses daily reports into `.tar.gz` for efficient long-term storage.
- **Git Integration:** Automatically commits daily reports to track security trends over time.
