"""Small monitor tests; no solver is launched or modified."""
import json
from pathlib import Path
import tempfile
import unittest

import atlas_eta as eta


class EtaTests(unittest.TestCase):
    def setUp(self):
        eta._CACHE.clear()
        eta._ROUNDS.clear()

    def fixture(self, root):
        root=Path(root);charts=root/'charts';charts.mkdir()
        tensor=root/'tensor.json';tensor.write_text('{}')
        jobs=[dict(chart=j,status='ready' if j==21 else 'linear_certificate_verified') for j in range(32)]
        (charts/'manifest.json').write_text(json.dumps(dict(all_32_complete=True,jobs=jobs)))
        return dict(status='running',updated=100.,jobs={'orbit_0000':dict(id='orbit_0000',charts=str(charts),
            tensor=str(tensor),degree_F25=1,stage='ready')})

    def test_native_calibration_matches_both_real_work_counts(self):
        self.assertAlmostEqual(eta.native_budget(23)[0]/49758395881,1.)
        self.assertLess(abs(eta.native_budget(22)[0]/734985358004-1),.01)

    def test_field_cost_not_equal_representatives(self):
        self.assertAlmostEqual(eta.f4_budget(10,100)/eta.f4_budget(10,1),100)

    def test_deferred_job_not_counted_in_work_or_completion(self):
        with tempfile.TemporaryDirectory() as td:
            state=self.fixture(td);baseline=eta.forecast(state,now=100.)
            state['jobs']['orbit_0011']=dict(state['jobs']['orbit_0000'],id='orbit_0011',
                degree_F25=7324,deferred=True,stage='needs_attention')
            report=eta.forecast(state,now=100.)
            self.assertEqual(report['eta_seconds'],baseline['eta_seconds'])
            self.assertEqual(report['charts_total'],32)
            self.assertEqual(report['charts_finished'],31)
            self.assertEqual(report['blocked_representatives'],[])
            self.assertEqual(report['deferred_representatives'],['orbit_0011'])
            self.assertIn('Selected-run ETA',eta.render(report))

    def test_incremental_round_counts_do_not_double_count(self):
        with tempfile.TemporaryDirectory() as td:
            path=Path(td)/'rounds.jsonl'
            a=json.dumps(dict(event='round',selected_pairs=20))+'\n'
            b=json.dumps(dict(event='round',selected_pairs=30))+'\n'
            path.write_text(a)
            self.assertEqual(eta.round_summary(path)['selected'],20)
            self.assertEqual(eta.round_summary(path)['selected'],20)
            path.write_text(a+b[:-2])
            self.assertEqual(eta.round_summary(path)['selected'],20)
            path.write_text(a+b)
            self.assertEqual(eta.round_summary(path)['selected'],50)

    def test_native_invocation_deltas_accumulate_across_resume(self):
        with tempfile.TemporaryDirectory() as td:
            path=Path(td)/'operations.jsonl'
            first=json.dumps(dict(counter_scope='interval_actual_work',run_id='one',counts={'coefficient_updates':70}))+'\n'
            second=json.dumps(dict(counter_scope='interval_actual_work',run_id='two',counts={'coefficient_updates':30}))+'\n'
            path.write_text(first)
            self.assertEqual(eta.round_summary(path)['native_updates'],70)
            path.write_text(first+second)
            self.assertEqual(eta.round_summary(path)['native_updates'],100)
            self.assertEqual(eta.round_summary(path)['native_updates'],100)

    def test_forecast_overrun_keeps_positive_work(self):
        self.assertGreater(eta.remaining(100.,200.,floor=30.),0)

    def test_no_calibration_still_has_numeric_forecast(self):
        with tempfile.TemporaryDirectory() as td:
            report=eta.forecast(self.fixture(td),now=100.)
            self.assertGreater(report['eta_seconds'],0)
            self.assertEqual(report['charts_finished'],31)
            self.assertNotIn('not yet',eta.render(report))

    def test_exhausted_bounded_matrix_is_not_chart_completion(self):
        with tempfile.TemporaryDirectory() as td:
            state=self.fixture(td);out=Path(td)/'pencil';out.mkdir()
            (out/'result.json').write_text(json.dumps(dict(status='bounded_ansatz_no_certificate',
                native_seconds=100,cumulative_seconds=100,rows_processed=100,rows_total=100,
                work_since_invocation_start={'coefficient_updates':1000})))
            state['jobs']['orbit_0000']['pencil_attempts']={'21:5':dict(directory=str(out))}
            report=eta.forecast(state,now=100)
            self.assertEqual(report['charts_finished'],31)
            self.assertGreater(report['eta_seconds'],0)

    def test_live_native_work_updates_before_completion(self):
        with tempfile.TemporaryDirectory() as td:
            state=self.fixture(td);out=Path(td)/'pencil';out.mkdir()
            state['active']=dict(rep='orbit_0000',stage='pencil_solving',started=0,
                                 command=['solver','--output',str(out),'--chart','21'])
            path=out/'state.cp.progress.json'
            def write(rows,ops):
                path.write_text(json.dumps(dict(status='running',rows_processed=rows,rows_total=100,
                    native_seconds=rows/2,cumulative_seconds=rows/2,
                    work_since_invocation_start={'coefficient_updates':ops})))
            write(10,1000);a=eta.forecast(state,now=5)
            write(20,25000);b=eta.forecast(state,now=10)
            self.assertEqual(a['active']['done'],10)
            self.assertEqual(b['active']['done'],20)
            self.assertGreater(b['estimated_updates_done'],a['estimated_updates_done'])
            self.assertEqual(b['charts_finished'],31)

    def test_parallel_builder_counts_directions_not_largest_index(self):
        with tempfile.TemporaryDirectory() as td:
            state=self.fixture(td); job=state['jobs']['orbit_0000']
            Path(job['tensor']).unlink()
            log=Path(td)/'builder.log'
            log.write_text(json.dumps(dict(directions_pending=list(range(32))))+'\n'+
                'oper completed direction_09 elapsed 2\noper completed direction_03 elapsed 3\n'+
                'oper completed direction_09 elapsed 2\n')
            state['active']=dict(rep='orbit_0000',stage='building',log=str(log),started=0)
            self.assertEqual(eta.forecast(state,now=10)['active']['done'],2)

    def test_sparse_export_reports_live_phase_before_chart_completion(self):
        with tempfile.TemporaryDirectory() as td:
            folder=Path(td); chart=folder/'chart-31'; chart.mkdir()
            (folder/'export_session.json').write_text(json.dumps(dict(workers=10,status='running',
                coefficient_field_degree_F5=12,charts_requested=list(range(22,32)))))
            (chart/'export_progress.json').write_text(json.dumps(dict(phase='initial_rref',pid=42,
                elapsed_seconds=2,updated=98,units_done=0,units_total=0)))
            report=eta.sparse_export_progress(folder,set(),100)
            self.assertEqual(report['workers'],10)
            self.assertEqual(report['live_charts'][0]['phase'],'initial_rref')
            self.assertGreater(report['estimated_work_percent'],0)
            self.assertGreater(report['eta_seconds'],0)

    def test_memory_limited_attempt_waves(self):
        self.assertEqual(eta.bounded_parallel_time([1]*10,10,10,305),305)
        self.assertEqual(eta.bounded_parallel_time([3]*10,10,10,305),1220)
        self.assertEqual(eta.bounded_parallel_time([],10,10,305),0)

    def test_native_batch_reports_phases_without_counting_timeouts_as_certificates(self):
        with tempfile.TemporaryDirectory() as td:
            state=self.fixture(td);out=Path(td)/'native';out.mkdir()
            chart=out/'chart-21';chart.mkdir()
            (chart/'events.jsonl').write_text(json.dumps(dict(stage='exact_affine_preconditioning',seconds=20))+'\n')
            (out/'telemetry.jsonl').write_text(json.dumps(dict(cpu_percent=887,rss_bytes=12345))+'\n')
            (out/'batch.json').write_text(json.dumps(dict(status='running',updated_epoch=99,
                active={'21':dict(pid=42,phase='solve',elapsed_seconds=20)},
                charts={'20':dict(status='bounded_native_slice_incomplete',reason='time_limit')})))
            state['active']=dict(rep='orbit_0000',stage='native_original_solving',started=0,
                command=['batch','--output',str(out),'--charts','21','20','--seconds','300','--rss-gib','8'])
            report=eta.forecast(state,now=100)
            self.assertEqual(report['charts_certified'],31)
            self.assertEqual(report['active']['done'],1)
            self.assertEqual(report['active']['sampled_cpu_percent'],887)
            self.assertEqual(report['active']['live_charts'][0]['stage'],'exact_affine_preconditioning')
            self.assertIn('NOT a completion forecast',eta.render(report))
            self.assertIn('Legacy F4 fallback scenario',eta.render(report))


if __name__=='__main__':unittest.main()
