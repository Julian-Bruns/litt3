#!/usr/bin/env python3
"""Read-only live solver monitor. Closing this display never stops the solver."""
import argparse
import curses
import datetime as dt
import json
from pathlib import Path
import re
import subprocess

ROOT = Path(__file__).resolve().parents[1]
DATA = ROOT / 'Research' / 'computations'
RUN = DATA / 'normalized_oper_run.json'
LOG = DATA / 'normalized_oper_solver.log'
ROW = re.compile(r'^\s*(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s*x\s*(\d+)\s+([\d.]+)%', re.M)
DONE = re.compile(r'(\d+) new\s+(\d+) zero\s+([\d.]+)\s*\|\s*([\d.]+)')


def read_json(path):
    try:
        return json.loads(path.read_text())
    except (OSError, ValueError):
        return {}


def log_tail():
    try:
        with LOG.open('rb') as stream:
            stream.seek(max(0, LOG.stat().st_size - 262144))
            return stream.read().decode(errors='replace').split('SOLVER START')[-1]
    except OSError:
        return ''


def bar(done, total, width=44):
    ratio = max(0, min(1, done / total)) if total else 0
    filled = int(width * ratio)
    return '[' + '#' * filled + '-' * (width - filled) + f'] {100 * ratio:.2f}%'


def process_info(pid):
    if not isinstance(pid, int):
        return None
    try:
        result = subprocess.run(
            ['/bin/ps', '-ww', '-p', str(pid), '-o', '%cpu=,rss=,command='],
            capture_output=True, text=True, timeout=3)
        fields = result.stdout.strip().split(None, 2)
        if len(fields) == 3 and 'normalized_oper_msolve.in' in fields[2]:
            return float(fields[0].replace(',', '.')), int(fields[1]) / 1024 ** 2
    except (OSError, ValueError, subprocess.TimeoutExpired):
        pass
    return None


def lines(tick=0):
    run = read_json(RUN)
    research = read_json(ROOT / 'Research' / 'state.json')
    enumeration = research.get('enumeration', {})
    remaining = enumeration.get('remaining_full_length')
    total = 29375
    accounted = total - remaining if isinstance(remaining, int) else None
    info = process_info(run.get('solver_pid'))
    status = run.get('status', 'not started')
    if status == 'running':
        status = 'COMPUTING' if info else 'INTERRUPTED / process no longer present'
    elif status == 'finished':
        status = ('BASIS PRODUCED - mathematical verification pending'
                  if run.get('output_bytes', 0) else 'EXITED - no basis output')
    elif status == 'failed':
        status = f"STOPPED with exit code {run.get('returncode')}"
    try:
        start = dt.datetime.fromisoformat(run['started_utc'])
        end = dt.datetime.fromisoformat(run['ended_utc']) if run.get('ended_utc') else dt.datetime.now(dt.timezone.utc)
        seconds = max(0, int((end - start).total_seconds()))
        elapsed = f'{seconds // 3600:02d}:{seconds // 60 % 60:02d}:{seconds % 60:02d}'
    except (KeyError, ValueError):
        elapsed = 'unknown'
    result = ['LITT3  |  Exact equation search', '', f'Status:  {status}',
              f'Elapsed: {elapsed}    Solver PID: {run.get("solver_pid", "-")}', '']
    if info:
        position = tick % 40
        result += ['Calculation activity (not percent complete):',
                   '[' + ' ' * position + '====' + ' ' * (40 - position) + ']',
                   f'CPU: {info[0]:.1f}% (100% = one core; ten enabled)',
                   f'Resident memory: {info[1]:.2f} GiB (excludes compressed/swapped pages)', '']
    tail = log_tail()
    rows = list(ROW.finditer(tail))
    if rows:
        degree, selected, pending, height, width, density = rows[-1].groups()
        result += [f'Current degree: {degree}    Pending pairs: {int(pending):,}',
                   f'Matrix: {int(height):,} x {int(width):,}    Density: {density}%',
                   f'Pairs selected this batch: {selected}']
        completed = list(DONE.finditer(tail))
        if completed:
            new, zero, wall, cpu = completed[-1].groups()
            result += [f'Last completed batch: {wall}s wall time; {new} new basis elements']
        result += ['Pending work can grow; an honest completion ETA is not yet available.', '']
    result += ['Verified solution multiplicity (not runtime progress):']
    if accounted is not None:
        result += [bar(accounted, total),
                   f'{accounted:,} / {total:,} accounted for; {enumeration.get("distinct_exported", "?")} distinct solutions exported.']
    else:
        result += ['Enumeration status unavailable.']
    result += ['This counter changes only after mathematical verification.', '',
               'Refresh: 2 seconds. Press q to close; the calculation keeps running.',
               'Log: Research/computations/normalized_oper_solver.log']
    return result


def display(screen):
    try:
        curses.curs_set(0)
    except curses.error:
        pass
    screen.timeout(2000)
    tick = 0
    while True:
        screen.erase()
        height, width = screen.getmaxyx()
        for row, line in enumerate(lines(tick)[:max(0, height - 1)]):
            try:
                screen.addnstr(row, 0, line, max(0, width - 1))
            except curses.error:
                pass
        screen.refresh()
        key = screen.getch()  # Blocks between refreshes; no busy polling.
        if key in (ord('q'), ord('Q'), 27):
            return
        tick += 1


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--snapshot', action='store_true', help='Print one status snapshot.')
    args = parser.parse_args()
    if args.snapshot:
        print('\n'.join(lines()))
    else:
        try:
            curses.wrapper(display)
        except KeyboardInterrupt:
            pass
