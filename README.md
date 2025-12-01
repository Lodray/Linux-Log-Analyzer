# Linux Log Analyzer

## Descripcion
Script who analyze log of linux system to identify critic mistakes and generate a small report, util fro managment and auditores of security

## Project Objective
The purpose of this Bash script is to analyze Linux system logs located in `/var/log/` and identify error patterns. It generates a report file containing all relevant error messages for easier monitoring and troubleshooting.

## Installation  and Requisitos
# Necesary:
# bash 4+
# -Acceso a /var/log/
# - Permisos de lectura

## Usage Example
After downloading or cloning this repository, make sure the script has execution permissions make:
./log_analyzer.sh/var/log/syslog
# Output:
# [INFO] 23 errores encontrados
# [WARNING] 12 advetencias
# generated report: reporte_23112025.txt

## Expected result 

A file named report_errors.txt (or similar) will be created in the project directory.
It will contain all lines from the system logs that match the error patterns, making it easier to review system issues.

## What support now?

rigth now dont't have any funcion, even dont have the scrpt, it will be implement lately

## Limitations

# Lately
