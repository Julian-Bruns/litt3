#!/usr/bin/env python3
"""Seconds-scale stop/orphan regressions; no Sage or mathematical solver."""
import json
import subprocess
import sys
import tempfile
import time
import unittest
from pathlib import Path
import backup_genus_two_batch as batch


class BackupCleanupTests(unittest.TestCase):
    def setUp(self):
        self.tmp=tempfile.TemporaryDirectory(prefix='litt3-backup-cleanup-')
        batch.OUT=Path(self.tmp.name);batch.STAMP='regression'
        batch.START=time.monotonic();batch.DEADLINE=batch.START+15
        batch.GROUPS.clear();batch.PROCESSES.clear()

    def tearDown(self):
        self.assertFalse(batch.GROUPS);self.assertFalse(batch.PROCESSES)
        self.tmp.cleanup()

    def run_command(self,name,code,limit=4):
        result=batch.run_job((name,[sys.executable,'-u','-c',code]),limit)
        self.assertFalse(batch.GROUPS);self.assertFalse(batch.PROCESSES)
        return result

    def test_completed_parent(self):
        answer=self.run_command('completed','print("complete")')
        self.assertEqual(answer['exit_code'],0)

    def test_exited_wrapper_leaves_child(self):
        child='import signal,time; signal.signal(signal.SIGTERM,signal.SIG_IGN); time.sleep(20)'
        code='import subprocess,sys; p=subprocess.Popen([sys.executable,"-c",'+repr(child)+']); print(p.pid)'
        answer=self.run_command('orphan',code)
        self.assertEqual(answer['exit_code'],0)
        pid=int(Path(answer['log']).read_text().strip())
        rows=subprocess.check_output(['ps','-axo','pid=,stat='],text=True).splitlines()
        self.assertFalse(any(int(cols[0])==pid and not cols[1].startswith('Z')
            for row in rows if len(cols:=row.split())==2))

    def test_timeout_kills_entire_group(self):
        child='import signal,time; signal.signal(signal.SIGTERM,signal.SIG_IGN); time.sleep(20)'
        code='import subprocess,sys,time; p=subprocess.Popen([sys.executable,"-c",'+repr(child)+']); print(p.pid); time.sleep(20)'
        answer=self.run_command('timeout',code,limit=2.1)
        self.assertLess(answer['elapsed_seconds'],4)
        self.assertNotEqual(answer['exit_code'],0)

    def test_closed_window_does_not_launch(self):
        batch.DEADLINE=time.monotonic()
        answer=self.run_command('closed','raise SystemExit("must not launch")')
        self.assertEqual(answer['status'],'not_started_window_closed')


if __name__=='__main__':
    started=time.monotonic();suite=unittest.defaultTestLoader.loadTestsFromTestCase(BackupCleanupTests)
    result=unittest.TextTestRunner(verbosity=2).run(suite)
    print(json.dumps({'status':'PASS' if result.wasSuccessful() else 'FAIL',
        'tests_run':result.testsRun,'elapsed_seconds':time.monotonic()-started,
        'scope':'Process cleanup only; no mathematical computation or exclusion.'}),flush=True)
    raise SystemExit(0 if result.wasSuccessful() else 1)
