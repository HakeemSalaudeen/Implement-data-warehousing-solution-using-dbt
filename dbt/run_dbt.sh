#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

echo "Running dbt commands"
echo "Resolving dependencies before model execution"
dbt deps

echo "Running dbt"
dbt run --target dev --project-dir "$SCRIPT_DIR" --profiles-dir "$SCRIPT_DIR"

echo "dbt run complete"