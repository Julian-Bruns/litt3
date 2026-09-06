from pathlib import Path
import select
import subprocess
import sys
import time
import unittest
from unittest.mock import patch

SCRIPTS = Path(__file__).resolve().parents[1] / 'scripts'
sys.path.insert(0, str(SCRIPTS))
import solver_completion_watch as completion
import watch_normalized_solver as monitor


class MonitorTests(unittest.TestCase):
    def test_german_decimal_and_process_identity(self):
        result = subprocess.CompletedProcess([], 0,
            '642,9 1048576 /solver normalized_oper_msolve.in', '')
        with patch.object(monitor.subprocess, 'run', return_value=result):
            self.assertEqual(monitor.process_info(123), (642.9, 1.0))
        result.stdout = '1.0 1024 unrelated-process'
        with patch.object(monitor.subprocess, 'run', return_value=result):
            self.assertIsNone(monitor.process_info(123))

    def test_verified_bar(self):
        self.assertTrue(monitor.bar(440, 29375).endswith('1.50%'))
        self.assertEqual(monitor.bar(5, 5, 4), '[####] 100.00%')

    def test_log_row(self):
        row = monitor.ROW.search('  7  250  89480  69019 x 91217  3.41%')
        self.assertEqual(row.groups(), ('7', '250', '89480', '69019', '91217', '3.41'))

    def test_exact_session_command(self):
        command = completion.resume_command('test-session')
        self.assertIn('test-session', command)
        self.assertNotIn('--last', command)
        self.assertNotIn('--dangerously-bypass-approvals-and-sandbox', command)

    @unittest.skipUnless(hasattr(select, 'kqueue'), 'macOS/BSD process events only')
    def test_actual_kernel_exit_event(self):
        child = subprocess.Popen([sys.executable, '-c', 'import time; time.sleep(0.4)'])
        start = time.monotonic()
        try:
            completion.wait_for_exit(child.pid, 'time.sleep(0.4)')
            self.assertLess(time.monotonic() - start, 5)
            self.assertEqual(child.wait(timeout=1), 0)
        finally:
            if child.poll() is None:
                child.terminate()
                child.wait()


if __name__ == '__main__':
    unittest.main()
