#!/usr/bin/env python3
"""Regenerate all compact exact checks and compare to the saved evidence."""
from pathlib import Path
import json
import phase_sums, check_inputs, check_bounds, check_resonance, four_phase_minors, five_phase_coefficients, check_completion_algebra

def main():
    root=Path(__file__).resolve().parents[1]
    for module,filename in [(phase_sums,'phase_sums.json'),
                            (check_inputs,'input_checks.json'),
                            (check_bounds,'bound_checks.json'),
                            (check_resonance,'resonance_checks.json'),
                            (four_phase_minors,'four_phase_minors.json'),
                            (five_phase_coefficients,'five_phase_coefficients.json'),
                            (check_completion_algebra,'completion_algebra.json')]:
        result=json.loads(json.dumps(module.verify()))
        expected=json.loads((root/'evidence'/filename).read_text())
        assert result==expected, f'evidence mismatch: {filename}'
        print(f'PASS {filename}',flush=True)
    print('PASS all executed exact checks. The completed geometric theorem is proved in REPORT.md, not by this test runner.',flush=True)
if __name__=='__main__': main()
