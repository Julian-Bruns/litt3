#!/usr/bin/env python3
"""Bounded orchestration tests; no production solver or census mutation."""
import argparse
import hashlib
import tempfile
import unittest
from pathlib import Path
from unittest.mock import patch

import run_all_atlases as all18
from atlas_resources import fork_workers
from atlas_native_batch import reservation,indexed_reservation


class All18Tests(unittest.TestCase):
    def test_native_batch_reservation_and_independent_replay_guard(self):
        self.assertEqual(reservation(10,10,8*1024**3,1024**2)[0],10)
        with tempfile.TemporaryDirectory(prefix='atlas-adoption-test-') as td:
            folder=Path(td);tensor=folder/'tensor.json';tensor.write_text('{}')
            source=all18.f4.sha(tensor);path=folder/'result.json'
            all18.f4.atomic(path,dict(status='verified_polynomial_certificate',source_sha256=source,
                chart=28,identity_sum_original_rows_times_multipliers_equals_one_verified=True,
                elapsed_seconds=1,engine='native_field_liftstd_original'))
            job=dict(tensor=str(tensor),charts=str(folder/'charts'))
            self.assertFalse(all18.adopt_certificate(job,path))

            replay=dict(source_sha256=source,certificate_sha256=all18.f4.sha(path),
                verified_original_unit_identity=True,search_or_groebner_solver_used=False)
            all18.f4.atomic(folder/'replay.json',replay)
            self.assertTrue(all18.adopt_certificate(job,path))
            record=all18.f4.read_json(folder/'charts/run.json')['jobs']['28']
            self.assertEqual(record['backend'],'native_field_liftstd_original')
            self.assertTrue(record['independent_replay_verified'])
            replay['certificate_sha256']='wrong';all18.f4.atomic(folder/'replay.json',replay)
            self.assertFalse(all18.adopt_certificate(job,path))

    def test_indexed_actual_prefix_fits_ten_but_original_replay_reserves_its_JSON(self):
        size=800*1024**2
        estimates=[indexed_reservation(c,'solve',1320,size) for c in range(31,21,-1)]
        self.assertLessEqual(sum(estimates),8*1024**3)
        self.assertGreater(indexed_reservation(31,'replay',1320,size),estimates[0])
        self.assertGreater(indexed_reservation(0,'solve',14648,size),8*1024**3)

    def test_native_batch_precedes_unnecessary_export(self):
        with tempfile.TemporaryDirectory(prefix='atlas-native-priority-test-') as td:
            q=all18.Queue(self.args(td));job=q.state['jobs']['orbit_0000']
            job['charts']=str(Path(td)/'charts')
            with patch.object(q,'native_batch',return_value=True) as native,patch.object(q,'command') as command:
                self.assertFalse(q.prepare(job));native.assert_called_once();command.assert_not_called()

    def test_bounded_native_failures_are_not_retried(self):
        with tempfile.TemporaryDirectory(prefix='atlas-native-terminal-test-') as td:
            q=all18.Queue(self.args(td));q.args.native_batch=10
            job=q.state['jobs']['invariant_3'];folder=Path(td)
            tensor=folder/'tensor.json';tensor.write_text('{}')
            job.update(tensor=str(tensor),tensor_sha256=all18.f4.sha(tensor),charts=str(folder/'charts'),
                native_original_attempts={str(i):dict(status='bounded_native_slice_incomplete') for i in range(32)})
            with patch.object(all18,'ROOT',folder/'workspace'),patch.object(q,'command') as command:
                self.assertFalse(q.native_batch(job));command.assert_not_called()

    def test_worker_reservation_uses_ten_when_measured_memory_fits(self):
        count,estimate=fork_workers(10,32,441483264,8*1024**3)
        self.assertEqual(count,10)
        self.assertLessEqual(441483264+count*estimate,8*1024**3)
        self.assertEqual(fork_workers(10,4,441483264,8*1024**3)[0],4)
        self.assertEqual(fork_workers(10,32,1024**3,8*1024**3)[0],7)

    def args(self, directory):
        return argparse.Namespace(directory=Path(directory), threads=10,
            slice_minutes=.001, pairs=1024, rss_gib=8, min_free_gib=0,
            checkpoint_rounds=5, engine=all18.f4.ENGINE, sage='sage')

    def test_all18_coverage_and_persistent_initialization(self):
        with tempfile.TemporaryDirectory(prefix='atlas-queue-test-') as td:
            s=all18.initialize(Path(td))
            self.assertEqual(len(s['jobs']),18)
            self.assertEqual(sum(j['geometric_coverage'] for j in s['jobs'].values()),28990)
            self.assertEqual(sum(j['scheme_length'] for j in s['jobs'].values()),29375)
            self.assertTrue(s['no_agent_wakeup'])
            self.assertEqual(all18.initialize(Path(td)),s)

    def test_entire_queue_and_no_unproved_exclusion(self):
        with tempfile.TemporaryDirectory(prefix='atlas-queue-test-') as td:
            q=all18.Queue(self.args(td)); visited=[]
            def solve(job):
                visited.append(job['id'])
                job['stage']='calculation_finished_verification_required'
            with patch.object(q,'prepare',return_value=True),patch.object(q,'solve',side_effect=solve):
                q.run()
            self.assertEqual(len(set(visited)),18)
            self.assertEqual(q.state['status'],'calculation_finished_verification_required')

    def test_failed_job_not_retried_or_omitted(self):
        with tempfile.TemporaryDirectory(prefix='atlas-queue-test-') as td:
            q=all18.Queue(self.args(td)); calls=[]
            def prepare(job):
                calls.append(job['id']); job['stage']='needs_attention'; job['reason']='test_failure'
                return False
            with patch.object(q,'prepare',side_effect=prepare):
                q.run()
            self.assertEqual(len(calls),18)
            self.assertEqual(q.state['status'],'needs_attention')
            self.assertIn('orbit_0011',q.state['reason'])

    def test_restart_fairness(self):
        with tempfile.TemporaryDirectory(prefix='atlas-queue-test-') as td:
            q=all18.Queue(self.args(td)); visited=[]
            q.state['jobs']['orbit_0000']['visits']=1
            def solve(job):
                visited.append(job['id']); job['stage']='calculation_finished_verification_required'
            with patch.object(q,'prepare',return_value=True),patch.object(q,'solve',side_effect=solve):
                q.run()
            self.assertEqual(visited[-1],'orbit_0000')

    def test_deferred_jobs_preserved_and_not_scheduled(self):
        with tempfile.TemporaryDirectory(prefix='atlas-queue-test-') as td:
            args=self.args(td)
            args.defer=[f'orbit_{i:04d}' for i in range(8,12)]
            q=all18.Queue(args);visited=[]
            q.state['jobs']['orbit_0011']['checkpoint_marker']='keep'
            def solve(job):
                visited.append(job['id']);job['stage']='calculation_finished_verification_required'
            with patch.object(q,'prepare',return_value=True),patch.object(q,'solve',side_effect=solve):
                q.run()
            self.assertEqual(len(visited),14)
            self.assertFalse(set(visited)&set(args.defer))
            self.assertEqual(q.state['jobs']['orbit_0011']['stage'],'pending')
            self.assertEqual(q.state['jobs']['orbit_0011']['checkpoint_marker'],'keep')
            saved=all18.initialize(Path(td))
            all18.select_representatives(saved)
            self.assertEqual(len(saved['selected_representatives']),14)
            all18.select_representatives(saved,resume=['orbit_0011'])
            self.assertEqual(len(saved['selected_representatives']),15)

    def test_invalid_selection_does_not_mutate_state(self):
        with tempfile.TemporaryDirectory(prefix='atlas-queue-test-') as td:
            s=all18.initialize(Path(td))
            for defer,resume in [(['typo'],[]),(['orbit_0000'],['orbit_0000']),(list(s['jobs']),[])]:
                with self.assertRaises(ValueError):all18.select_representatives(s,defer,resume)
            self.assertNotIn('selected_representatives',s)

    def test_finished_representative_not_recomputed_or_promoted_to_proved(self):
        with tempfile.TemporaryDirectory(prefix='atlas-queue-test-') as td:
            q=all18.Queue(self.args(td));visited=[]
            def progress(job):return (32,4,{}, {}) if job['id']=='orbit_0000' else (0,0,{}, {})
            def solve(job):
                visited.append(job['id']);job['stage']='calculation_finished_verification_required'
            with patch.object(all18,'chart_progress',side_effect=progress),patch.object(q,'prepare',return_value=True),patch.object(q,'solve',side_effect=solve):
                q.run()
            self.assertEqual(len(visited),17)
            self.assertNotIn('orbit_0000',visited)
            self.assertEqual(q.state['jobs']['orbit_0000']['stage'],'calculation_finished_verification_required')

    def test_verified_partial_export_reaches_solver_without_exporting_rest(self):
        with tempfile.TemporaryDirectory(prefix='atlas-queue-test-') as td:
            q=all18.Queue(self.args(td)); job=q.state['jobs']['orbit_0000']
            folder=Path(td)/'charts'; folder.mkdir(); job['charts']=str(folder)
            digest=all18.f4.sha(Path(job['tensor']))
            all18.f4.atomic(folder/'manifest.json',dict(source_sha256=digest,all_32_complete=False,
                jobs=[dict(chart=31,status='linear_certificate_verified'),dict(chart=30,status='ready')]))
            with patch.object(q,'command') as command:
                self.assertTrue(q.prepare(job))
                command.assert_not_called()
            self.assertEqual(job['exported_charts'],2)

    def test_partial_queue_finish_is_not_whole_atlas_completion(self):
        with tempfile.TemporaryDirectory(prefix='atlas-queue-test-') as td:
            q=all18.Queue(self.args(td)); job=q.state['jobs']['invariant_0']; calls=[]
            manifest=dict(all_32_complete=False,jobs=[dict(chart=31,status='linear_certificate_verified'),
                dict(chart=30,status='ready')])
            def command(job,stage,cmd): calls.append(cmd); return True
            progress=[(1,1,manifest,{}),(2,1,manifest,dict(status='queue_finished'))]
            with patch.object(q,'pencil',return_value=False),patch.object(q,'command',side_effect=command),\
                 patch.object(all18,'chart_progress',side_effect=progress):
                q.solve(job)
            self.assertEqual(job['stage'],'ready')
            self.assertEqual(calls[0][calls[0].index('--chart')+1],'30')

    def test_partial_export_with_only_done_charts_exports_bounded_batch(self):
        with tempfile.TemporaryDirectory(prefix='atlas-queue-test-') as td:
            q=all18.Queue(self.args(td)); job=q.state['jobs']['orbit_0000']; calls=[]
            folder=Path(td)/'charts'; folder.mkdir(); job['charts']=str(folder)
            manifest=dict(source_sha256=all18.f4.sha(Path(job['tensor'])),all_32_complete=False,
                jobs=[dict(chart=31,status='linear_certificate_verified')])
            all18.f4.atomic(folder/'manifest.json',manifest)
            def command(job,stage,cmd):
                calls.append(cmd); manifest['jobs'].append(dict(chart=30,status='ready'))
                all18.f4.atomic(folder/'manifest.json',manifest); return True
            with patch.object(q,'command',side_effect=command): self.assertTrue(q.prepare(job))
            self.assertEqual(calls[0][calls[0].index('--workers')+1],'10')
            self.assertEqual(calls[0][calls[0].index('--max-charts')+1],'10')

    def test_partial_export_rejects_wrong_source(self):
        with tempfile.TemporaryDirectory(prefix='atlas-queue-test-') as td:
            q=all18.Queue(self.args(td)); job=q.state['jobs']['orbit_0000']
            folder=Path(td)/'charts'; folder.mkdir(); job['charts']=str(folder)
            all18.f4.atomic(folder/'manifest.json',dict(source_sha256='wrong',all_32_complete=False,
                jobs=[dict(chart=30,status='ready')]))
            with patch.object(q,'command') as command:
                self.assertFalse(q.prepare(job)); command.assert_not_called()
            self.assertEqual(job['reason'],'wrong_source_export')


if __name__=='__main__':
    unittest.main()
