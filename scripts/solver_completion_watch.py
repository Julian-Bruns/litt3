#!/usr/bin/env python3
"""One-shot macOS process-exit watcher; no model calls while waiting.

Arm with --arm --session UUID. The kernel wakes us on supervisor exit;
then notify the user and resume that exact Codex session once. No solver
is restarted, signalled, or modified by this script.
"""
import argparse
from contextlib import closing
import fcntl
import json
import os
from pathlib import Path
import select
import subprocess
import sys
import tempfile
import uuid

from run_normalized_solver import ROOT, DATA, STATE, now

WATCH = DATA / 'normalized_oper_completion_watch.json'
WATCH_LOG = DATA / 'normalized_oper_completion_watch.log'
RESUME_LOG = DATA / 'normalized_oper_resume.jsonl'
REPLY = DATA / 'normalized_oper_resume_reply.md'
CODEX = '/opt/homebrew/bin/codex'


def read(path):
    return json.loads(path.read_text())


def save(record):
    with tempfile.NamedTemporaryFile('w', dir=DATA, prefix='.completion-', delete=False) as handle:
        json.dump(record, handle, indent=2)
        handle.write('\n')
    os.replace(handle.name, WATCH)


def process_matches(pid, text):
    if not isinstance(pid, int):
        return False
    result = subprocess.run(['/bin/ps', '-ww', '-p', str(pid), '-o', 'command='],
                            capture_output=True, text=True)
    return result.returncode == 0 and text in result.stdout


def wait_for_exit(pid, command_fragment):
    """Register first, then verify identity, so an intervening exit is not missed."""
    with closing(select.kqueue()) as queue:
        event = select.kevent(pid, filter=select.KQ_FILTER_PROC,
            flags=select.KQ_EV_ADD | select.KQ_EV_ONESHOT, fflags=select.KQ_NOTE_EXIT)
        try:
            queue.control([event], 0, 0)
        except ProcessLookupError:
            return
        if process_matches(pid, command_fragment):
            queue.control([], 1, None)  # Kernel sleep, no periodic model or CPU polling.


def resume_command(session):
    prompt = (
        'Automatic one-shot solver completion wake-up requested by the user. '
        'First read update.md, Research/STATE.md and Research/state.json. '
        'Inspect Research/computations/normalized_oper_run.json, the solver log '
        'and basis output. Do not assume exit0 means a proved result. If successful, '
        'run the recorded exact --normalized verification/export, preserve all '
        'multiplicities, and continue enumeration/research from the recorded frontier. '
        'If failed or interrupted, diagnose from saved evidence and report accurately; '
        'do not start repeated blind retries. Preserve both actual finite etale legs '
        'and all existing user instructions. Update the canonical continuation state '
        'and give the user the outcome. Do not arm another wake-up for this same run.')
    return [CODEX, 'exec', '--sandbox', 'workspace-write', 'resume', session,
            '--json', '-o', str(REPLY), prompt]


def notify(message):
    # Fixed strings only; no solver output is interpreted as AppleScript.
    subprocess.run(['/usr/bin/osascript', '-e',
        'display notification ' + json.dumps(message) + ' with title "Litt3 computation"'],
        capture_output=True, timeout=10)


def worker(session):
    with (DATA / '.normalized_oper_completion.lock').open('a') as lock:
        try:
            fcntl.flock(lock, fcntl.LOCK_EX | fcntl.LOCK_NB)
        except BlockingIOError:
            raise SystemExit('A completion watcher is already active.')
        run = read(STATE)
        identity = run['started_utc']
        if WATCH.exists():
            previous = read(WATCH)
            if previous.get('solver_started_utc') == identity and previous.get('triggered_utc'):
                raise SystemExit('This solver run has already triggered a wake-up.')
        record = dict(status='armed', watcher_pid=os.getpid(), session_id=session,
                      armed_utc=now(), solver_started_utc=identity,
                      solver_pid=run.get('solver_pid'), supervisor_pid=run.get('supervisor_pid'))
        save(record)
        try:
            if run.get('status') in ('starting', 'running'):
                wait_for_exit(run['supervisor_pid'], 'run_normalized_solver.py --worker')
                # If the supervisor alone was killed, wait for the actual calculation.
                if run.get('solver_pid'):
                    wait_for_exit(run['solver_pid'], 'normalized_oper_msolve.in')
            final = read(STATE)
            if final.get('started_utc') != identity:
                record.update(status='cancelled_run_replaced', ended_utc=now())
                save(record)
                return
            record.update(status='resuming', triggered_utc=now(), solver_status=final.get('status'))
            save(record)  # At most one trigger, including after a watcher crash/relaunch.
            notify('The equation search has stopped. Codex is checking its result.')
            with RESUME_LOG.open('ab', buffering=0) as log:
                process = subprocess.Popen(resume_command(session), cwd=ROOT,
                    stdin=subprocess.DEVNULL, stdout=log, stderr=subprocess.STDOUT,
                    close_fds=True)
                record['codex_pid'] = process.pid
                save(record)
                code = process.wait()
            record.update(status='resume_finished' if code == 0 else 'resume_failed',
                          resume_returncode=code, ended_utc=now())
            save(record)
            notify('Codex has finished checking the computation.' if code == 0 else
                   'Automatic Codex resume failed. Please open the Litt3 chat.')
        except BaseException as error:
            record.update(status='watch_failed', error=repr(error), ended_utc=now())
            save(record)
            raise


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--arm', action='store_true')
    parser.add_argument('--worker', action='store_true', help=argparse.SUPPRESS)
    parser.add_argument('--session', required=True)
    args = parser.parse_args()
    session = str(uuid.UUID(args.session))  # Never use --last or choose an unrelated chat.
    if args.worker:
        worker(session)
    elif args.arm:
        with WATCH_LOG.open('ab', buffering=0) as log:
            process = subprocess.Popen([sys.executable, str(Path(__file__).resolve()),
                '--worker', '--session', session], cwd=ROOT, stdin=subprocess.DEVNULL,
                stdout=log, stderr=subprocess.STDOUT, start_new_session=True, close_fds=True)
        print(f'Completion watcher launched: PID {process.pid}; inspect {WATCH}')
    else:
        parser.error('use --arm')


if __name__ == '__main__':
    main()
