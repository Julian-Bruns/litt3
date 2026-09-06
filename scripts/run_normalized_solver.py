#!/usr/bin/env python3
"""Detached supervisor for the single exact solver, with durable diagnostics.

The supervisor blocks in wait(), not a polling loop. Its child and log
survive the launching terminal. A nonempty basis is never overwritten.
"""
import argparse
import datetime
import hashlib
import json
import os
from pathlib import Path
import subprocess
import sys
import tempfile

ROOT = Path(__file__).resolve().parents[1]
DATA = ROOT / 'Research' / 'computations'
STATE = DATA / 'normalized_oper_run.json'
LOG = DATA / 'normalized_oper_solver.log'
INPUT = DATA / 'normalized_oper_msolve.in'
OUTPUT = DATA / 'normalized_oper_msolve.gb'
BINARY = Path('/tmp/litt3-msolve-lowmem.bQGL6w/msolve-0.10.1/msolve')


def now():
    return datetime.datetime.now(datetime.timezone.utc).isoformat()


def save_state(state):
    with tempfile.NamedTemporaryFile(mode='w', dir=DATA, prefix='.solver-',
                                     suffix='.json', delete=False) as handle:
        json.dump(state, handle, indent=2)
        handle.write('\n')
        name = handle.name
    os.replace(name, STATE)


def old_job_alive():
    if not STATE.exists():
        return False
    old = json.loads(STATE.read_text())
    if old.get('status') not in ('starting', 'running'):
        return False
    for field in ('supervisor_pid', 'solver_pid'):
        pid = old.get(field)
        if not pid:
            continue
        result = subprocess.run(['/bin/ps', '-ww', '-p', str(pid), '-o', 'command='],
                                capture_output=True, text=True)
        if result.returncode == 0 and any(part in result.stdout for part in
                ('run_normalized_solver.py', 'normalized_oper_msolve.in')):
            return True
    return False


def worker():
    command = [str(BINARY), '-t', str(os.cpu_count()), '-l', '2', '-m', '250',
               '-v', '2', '-g', '2', '-f', str(INPUT), '-o', str(OUTPUT)]
    state = {'status': 'starting', 'started_utc': now(),
             'supervisor_pid': os.getpid(), 'command': command,
             'input_sha256': hashlib.sha256(INPUT.read_bytes()).hexdigest(),
             'log': str(LOG), 'output': str(OUTPUT)}
    save_state(state)
    code = None
    try:
        print('\nSOLVER START ' + state['started_utc'], flush=True)
        process = subprocess.Popen(command, cwd=ROOT, stdin=subprocess.DEVNULL)
        state.update(status='running', solver_pid=process.pid)
        save_state(state)
        code = process.wait()
        state['status'] = 'finished' if code == 0 else 'failed'
    except BaseException as error:
        state.update(status='failed', error=repr(error))
        raise
    finally:
        state.update(ended_utc=now(), returncode=code,
                     output_bytes=OUTPUT.stat().st_size if OUTPUT.exists() else 0)
        save_state(state)
        print('SOLVER END ' + json.dumps(state), flush=True)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--worker', action='store_true', help=argparse.SUPPRESS)
    args = parser.parse_args()
    if args.worker:
        worker()
        return
    if old_job_alive():
        raise SystemExit('The recorded solver/supervisor is already running.')
    if OUTPUT.exists() and OUTPUT.stat().st_size:
        raise SystemExit('Nonempty basis output exists; verify it before restarting.')
    if not INPUT.is_file() or not BINARY.is_file():
        raise SystemExit('Missing input or validated solver binary.')
    with LOG.open('ab', buffering=0) as log:
        process = subprocess.Popen([sys.executable, str(Path(__file__).resolve()), '--worker'],
            cwd=ROOT, stdin=subprocess.DEVNULL, stdout=log, stderr=subprocess.STDOUT,
            start_new_session=True, close_fds=True)
    print(f'Detached supervisor PID {process.pid}; diagnostics: {STATE}')


if __name__ == '__main__':
    main()
