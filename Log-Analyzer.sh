```bash
#!/usr/bin/env bash
# log_analyzer.sh - Simple Linux log analyzer
# Usage: ./log_analyzer.sh /path/to/logfile

set -euo pipefail
IFS=$'\n\t'

show_help() {
  echo "Usage: $0 /path/to/logfile"
  exit 1
}

if [[ ${1:-} == "" ]]; then
  show_help
fi

LOGFILE="$1"

if [[ ! -f "$LOGFILE" ]]; then
  echo "[ERROR] File not found: $LOGFILE" >&2
  exit 2
fi

# Timestamp for report filename
TS=$(date +"%Y%m%d_%H%M%S")
REPORT="report_errors_${TS}.txt"

echo "[INFO] Scanning $LOGFILE"
echo "Log Analyzer Report" > "$REPORT"
echo "Log file: $LOGFILE" >> "$REPORT"
echo "Generated: $(date --rfc-3339=seconds)" >> "$REPORT"
echo "----------------------------------------" >> "$REPORT"

# Extract lines with common error keywords 
# We use grep with -i for case-insensitive.
ERROR_LINES=$(grep -Ei "error|fail|failed|fatal|segfault|panic|authentication failure|unauthorized|error|fallo|auntenticacion" "$LOGFILE" || true)
WARN_LINES=$(grep -Ei "warn|warning" "$LOGFILE" || true)

# Write sections
echo "CRITICAL / ERROR LINES" >> "$REPORT"
if [[ -n "$ERROR_LINES" ]]; then
  echo "$ERROR_LINES" >> "$REPORT"
else
  echo "None found." >> "$REPORT"
fi
echo "" >> "$REPORT"

echo "WARNINGS" >> "$REPORT"
if [[ -n "$WARN_LINES" ]]; then
  echo "$WARN_LINES" >> "$REPORT"
else
  echo "None found." >> "$REPORT"
fi
echo "" >> "$REPORT"

# Generate simple summary counts
ERROR_COUNT=$(echo "$ERROR_LINES" | wc -l)
WARN_COUNT=$(echo "$WARN_LINES" | wc -l)

echo "SUMMARY" >> "$REPORT"
echo "Errors: $ERROR_COUNT" >> "$REPORT"
echo "Warnings: $WARN_COUNT" >> "$REPORT"

echo "[INFO] Report generated: $REPORT"
exit 0
