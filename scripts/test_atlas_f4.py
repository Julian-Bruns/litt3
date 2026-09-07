#!/usr/bin/env python3
"""Cheap controller/ETA tests; engine roundtrip tests are recorded separately."""
import unittest
from pathlib import Path
import tempfile
import atlas_f4 as a


class ControllerTests(unittest.TestCase):
    def test_metadata_events_do_not_require_degree(self):
        events=[dict(event='run_start'),dict(event='round',degree=4),
                dict(event='operation',degree=None),dict(event='round',degree=7)]
        self.assertEqual(a.telemetry_max_degree(events),7)
        self.assertEqual(a.telemetry_max_degree([dict(event='run_start')]),0)

    def test_calibration(self):
        jobs=[dict(chart=0,nvars=65)]
        self.assertIsNone(a.eta({'jobs':{}},jobs)['seconds_high'])

    def test_growth_not_clipped(self):
        samples=[dict(chart=26,nvars=40,seconds=12,status='basis_needs_verification'),
                 dict(chart=25,nvars=41,seconds=53,status='basis_needs_verification'),
                 dict(chart=24,nvars=42,seconds=164,status='basis_needs_verification')]
        lo,hi=a.predict_job(dict(chart=0,nvars=65),samples)
        self.assertGreater(hi,365*86400)
        self.assertGreater(hi,lo)

    def test_no_false_completion(self):
        with tempfile.TemporaryDirectory(prefix='atlas-output-test-') as tmp:
            p=Path(tmp)/'out'
            p.write_text('[-1]:\n')
            self.assertIsNone(a.output_kind(p))
            p.write_text('#Reduced Groebner basis data\n'+'#\n'*6+'[1]:\n')
            self.assertEqual(a.output_kind(p),'unit_candidate')
            p.write_text(p.read_text()[:-3])
            self.assertIsNone(a.output_kind(p))

    def test_result_is_not_proof(self):
        text=a.eta_text({'status':'queue_finished'})
        self.assertIn('verification remains',text)


if __name__=='__main__':
    unittest.main()
