#!/usr/bin/env python3
"""Regenerate arithmetic/combinatorial certificates, NOT covers or witnesses."""
from __future__ import annotations
import json
from pathlib import Path
from exact_checks import all_results

ROOT = Path(__file__).resolve().parents[1]
if __name__ == '__main__':
    data = json.loads((ROOT/'data/inputs.json').read_text())
    result = all_results(data)
    path = ROOT/'certificates/exact_checks.json'
    path.write_text(json.dumps(result,indent=2,sort_keys=True)+'\n')
    print(f'Generated {path.relative_to(ROOT)}; all assertions passed.')

