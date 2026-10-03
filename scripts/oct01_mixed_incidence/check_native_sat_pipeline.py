#!/usr/bin/env python3
"""Small positive/negative checks of the pinned native solver/proof pipeline."""
import argparse, hashlib, json, subprocess
from pathlib import Path
from run_native_five_minor_sat import read_model, check_cnf


def run(command, log):
    with log.open('w') as stream:
        result = subprocess.run(command, stdout=stream, stderr=subprocess.STDOUT,
                                timeout=30)
    return result.returncode, log.read_text()


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--tools-dir', type=Path, required=True)
    ap.add_argument('--output-dir', type=Path, required=True)
    args = ap.parse_args()
    tools, out = args.tools_dir, args.output_dir
    out.mkdir(parents=True, exist_ok=True)
    provenance = json.loads((tools/'provenance.json').read_text())
    for name, key in [('kissat', 'kissat_binary_sha256'),
                      ('drat-trim', 'drat_trim_binary_sha256')]:
        assert hashlib.sha256((tools/name).read_bytes()).hexdigest() == provenance[key]
    php = out/'pigeonhole.cnf'
    php.write_text('p cnf 6 9\n1 2 0\n3 4 0\n5 6 0\n'
                   '-1 -3 0\n-1 -5 0\n-3 -5 0\n'
                   '-2 -4 0\n-2 -6 0\n-4 -6 0\n')
    proof = out/'pigeonhole.drat'
    command = [str(tools/'kissat'), '--strict', '--time=10', str(php), str(proof)]
    code, log = run(command, out/'solver.log')
    assert code == 20 and 's UNSATISFIABLE' in log and proof.stat().st_size > 0
    check = [str(tools/'drat-trim'), str(php), str(proof), '-t', '10']
    checked, text = run(check, out/'checker.log')
    assert checked == 0 and any(line.strip() == 's VERIFIED' for line in text.splitlines())
    empty = out/'empty.drat'
    empty.write_bytes(b'')
    rejected, text = run([str(tools/'drat-trim'), str(php), str(empty), '-t', '10'],
                         out/'negative_checker.log')
    assert rejected != 0 and not any(line.strip() == 's VERIFIED' for line in text.splitlines())
    sat = out/'satisfiable.cnf'
    sat.write_text('p cnf 3 2\n1 2 0\n-1 3 0\n')
    code, text = run([str(tools/'kissat'), '--strict', '--time=10', str(sat)],
                     out/'satisfiable_solver.log')
    assert code == 10 and 's SATISFIABLE' in text
    model = read_model(out/'satisfiable_solver.log', 3)
    assert check_cnf(sat, model) == 2
    result = dict(status='PASS', unsat_exit=20, proof_checker_exit=checked,
                  empty_proof_rejected_exit=rejected, sat_exit=10,
                  sat_all_variables_and_clauses_checked=True,
                  solver_command=command, checker_command=check,
                  proof_bytes=proof.stat().st_size,
                  proof_sha256=hashlib.sha256(proof.read_bytes()).hexdigest(),
                  provenance=provenance,
                  scope='toy native SAT/UNSAT/model/proof pipeline only; no incidence solve')
    (out/'result.json').write_text(json.dumps(result, indent=2)+'\n')
    print(json.dumps(result))


if __name__ == '__main__':
    main()
