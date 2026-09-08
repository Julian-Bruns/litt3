#!/usr/bin/env python3
"""Real bounded process-group regressions; no Sage or production changes."""
import io
import os
import signal
import subprocess
import sys
import time
import unittest
from unittest.mock import patch

import atlas_native_batch as batch


class NativeCleanupTests(unittest.TestCase):
    def test_reaped_empty_group_never_signalled(self):
        proc=subprocess.Popen([sys.executable,'-c','pass'],start_new_session=True)
        proc.wait()
        with patch.object(batch.os,'kill',side_effect=AssertionError('Empty group signalled')):
            batch.stop(dict(proc=proc),grace=.1)

    def test_reparented_descendant_is_counted(self):
        rows=[(10,1,10,100,5),(11,1,10,200,10),(12,11,10,300,20),(20,1,20,400,30)]
        self.assertEqual(batch.descendants(rows,10),{10,11,12})

    def test_foreign_uid_is_recorded_never_signalled(self):
        group=198765;owned=198766;foreign=198767
        lines=f'{owned} {group} {os.getuid()} S\n{foreign} {group} {os.getuid()+1} S\n'
        remaining=f'{foreign} {group} {os.getuid()+1} S\n'
        proc=type('Proc',(),{'pid':group,'poll':lambda _:0})()
        job=dict(proc=proc)
        with patch.object(batch.subprocess,'check_output',side_effect=[lines,remaining]),\
             patch.object(batch.os,'kill') as kill:
            batch.stop(job,grace=.2)
        kill.assert_called_once_with(owned,signal.SIGTERM)
        self.assertEqual([r['pid'] for r in job['foreign_uid_members_not_signalled']],[foreign])

    def test_exited_wrapper_ignoring_child_is_killed(self):
        child='import signal,time; signal.signal(signal.SIGTERM,signal.SIG_IGN); print("ready",flush=True); time.sleep(60)'
        wrapper=('import subprocess,sys; p=subprocess.Popen([sys.executable,"-c",'+repr(child)+'],stdout=subprocess.PIPE,text=True); '
                 'assert p.stdout.readline().strip()=="ready"; print(p.pid,flush=True)')
        proc=subprocess.Popen([sys.executable,'-c',wrapper],start_new_session=True,
                              stdout=subprocess.PIPE,text=True)
        descendant=int(proc.stdout.readline());proc.wait()
        try:
            self.assertIn(descendant,batch.live_group_members(proc.pid))
            batch.stop(dict(proc=proc),grace=.1)
            self.assertEqual(batch.live_group_members(proc.pid),[])
        finally:
            proc.stdout.close()
            if descendant in batch.live_group_members(proc.pid):os.kill(descendant,signal.SIGKILL)

    def test_cleanup_continues_after_one_error(self):
        a=dict(proc=type('Proc',(),{'pid':100})(),log=io.StringIO())
        b=dict(proc=type('Proc',(),{'pid':101})(),log=io.StringIO())
        with patch.object(batch,'stop',side_effect=[PermissionError('fixture'),None]) as stop:
            failures=batch.cleanup({31:a,30:b})
        self.assertEqual(stop.call_count,2);self.assertEqual(len(failures),1)
        self.assertTrue(a['log'].closed and b['log'].closed)


if __name__=='__main__':unittest.main()
