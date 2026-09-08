#!/usr/bin/env python3
"""Operational recovery accepts exact evidence, never mathematical timeouts."""
import copy
import json
from pathlib import Path
import tempfile
import unittest
from unittest.mock import Mock,patch
import atlas_native_recovery as recovery
from atlas_native_tensor_input import sha


def atomic(path,data):Path(path).write_text(json.dumps(data))


class RecoveryTests(unittest.TestCase):
    def test_packing_recovery_is_exact_and_retains_attempts(self):
        with tempfile.TemporaryDirectory() as td:
            folder=Path(td);tensor=folder/'tensor.json';tensor.write_text('{}')
            log=folder/'failed.log';log.write_text('a precisely recorded packing failure')
            binding_paths={}
            for i in range(32):
                path=folder/('binding-%02d.json'%i);path.write_text('{}');binding_paths[str(path)]=sha(path)
            report=folder/'report.json';atomic(report,dict(status='verified',controller_or_chart_state_changed=False,
                representatives=[dict(representative='test',failed_log=str(log),failed_log_sha256=sha(log),
                    tensor_sha256=sha(tensor),all32_original_coordinate_roundtrips_verified=True,
                    all_preexisting_binary_and_original_hashes_preserved=True,
                    bindings=binding_paths,preserved={str(tensor):sha(tensor),str(log):sha(log)})]))
            state=dict(jobs={'test':dict(id='test',stage='needs_attention',reason='exit_1',
                last_log=str(log),tensor=str(tensor),native_original_attempts={'0':dict(reason='time_limit')})})
            before=copy.deepcopy(state['jobs']['test']['native_original_attempts'])
            with patch.object(recovery,'APPROVED_PACKING_TARGETS',{'test'}),patch.object(
                    recovery,'APPROVED_PACKING_REPORT_SHA256',sha(report)):
                self.assertEqual(recovery.recover_verified_packing(state,report),['test'])
                self.assertEqual(recovery.recover_verified_packing(state,report),[])
            self.assertEqual(state['jobs']['test']['native_original_attempts'],before)
            self.assertEqual(state['jobs']['test']['stage'],'paused')

    def fixture(self,folder):
        tensor=folder/'tensor.json';tensor.write_text('{}')
        log=folder/'cleanup.log';log.write_text('exact controlled failure')
        batch=dict(source_sha256=sha(tensor),charts={'28':dict(status='bounded_native_slice_incomplete',reason='time_limit')},active={})
        atomic(folder/'batch.json',batch)
        for chart in [31,30,29]:
            p=folder/f'chart-{chart:02d}';p.mkdir()
            atomic(p/'result.json',dict(source_sha256=sha(tensor),chart=chart,
                status='verified_polynomial_certificate',identity_sum_original_rows_times_multipliers_equals_one_verified=True))
            atomic(p/'replay.json',dict(source_sha256=sha(tensor),certificate_sha256=sha(p/'result.json'),
                verified_original_unit_identity=True,search_or_groebner_solver_used=False))
        job=dict(id='test',stage='needs_attention',reason='exit_1',tensor=str(tensor),last_log=str(log))
        expected=dict(tensor=sha(tensor),log=log.name,log_sha256=sha(log),batch_sha256=sha(folder/'batch.json'))
        return job,expected

    def test_exact_recovery_retains_all_search_limits(self):
        with tempfile.TemporaryDirectory() as td:
            folder=Path(td);job,expected=self.fixture(folder);before=(folder/'batch.json').read_bytes()
            adopt=Mock(return_value=True)
            with patch.dict(recovery.APPROVED_CLEANUP_FAILURES,{'test':expected}):
                self.assertTrue(recovery.recover_cleanup(job,folder,adopt))
                self.assertFalse(recovery.recover_cleanup(job,folder,adopt))
            self.assertEqual(adopt.call_count,3);self.assertEqual(job['stage'],'paused')
            self.assertEqual((folder/'batch.json').read_bytes(),before)

    def test_wrong_log_or_replay_cannot_adopt_anything(self):
        for what in ['log','replay']:
            with tempfile.TemporaryDirectory() as td:
                folder=Path(td);job,expected=self.fixture(folder);original=copy.deepcopy(job);adopt=Mock()
                if what=='log':(folder/'cleanup.log').write_text('different failure')
                else:
                    p=folder/'chart-29/replay.json';r=json.loads(p.read_text());r['certificate_sha256']='wrong';atomic(p,r)
                with patch.dict(recovery.APPROVED_CLEANUP_FAILURES,{'test':expected}):
                    with self.assertRaises(AssertionError):recovery.recover_cleanup(job,folder,adopt)
                adopt.assert_not_called();self.assertEqual(job,original)

    def test_only_unstarted_user_stop_is_resumed_and_archived(self):
        with tempfile.TemporaryDirectory() as td:
            folder=Path(td);tensor=folder/'tensor.json';tensor.write_text('{}');records={}
            for chart,reason in [(31,'user_stop'),(30,'time_limit'),(29,'memory_limit'),(28,'user_stop')]:
                p=folder/f'chart-{chart:02d}';p.mkdir()
                (p/'events.jsonl').write_text(json.dumps(dict(stage='original_input_started'))+'\n')
                records[str(chart)]=dict(status='bounded_native_batch_interrupted',reason=reason)
            (folder/'chart-28/native-input.sing').write_text('preserved completed input')
            atomic(folder/'batch.json',dict(source_sha256=sha(tensor),charts=records))
            before=(folder/'batch.json').read_bytes();job=dict(tensor=str(tensor),native_original_attempts=copy.deepcopy(records))
            self.assertEqual(recovery.resume_unstarted_user_stop(job,folder,atomic),['31'])
            after=json.loads((folder/'batch.json').read_text());self.assertEqual(set(after['charts']),{'30','29','28'})
            self.assertEqual(next(folder.glob('batch-user-stop-*.json')).read_bytes(),before)
            self.assertEqual(set(job['native_original_attempts']),{'30','29','28'})


if __name__=='__main__':unittest.main()
