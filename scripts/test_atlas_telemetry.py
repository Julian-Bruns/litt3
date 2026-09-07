#!/usr/bin/env python3
"""Logging engineering tests, not mathematical atlas certificates."""
import json
from pathlib import Path
import tempfile
import unittest
import atlas_telemetry as T


class TelemetryTests(unittest.TestCase):
    def test_all_representative_contexts(self):
        manifest=json.loads((T.ROOT/'Research/computations/oper_representatives_manifest.json').read_text())
        for rep in manifest['representatives']:
            # Schema test at both permitted degree bounds. No field computation claimed.
            bounds=rep.get('coefficient_field_degree_F5_bounds',[2])
            for degree in bounds:
                with tempfile.TemporaryDirectory() as tmp:
                    m=dict(oper_representative=rep['id'],chart=23,source_sha256='test',
                        input_sha256='testinput',field_degree_F5=degree,
                        field_description={'test_only':True,'degree':degree},
                        final_variables=['v0','b24','w','alpha','t'])
                    (Path(tmp)/'metadata.json').write_text(json.dumps(m))
                    c=T.context(tmp,'f4_encoded')
                    self.assertEqual(c['representative'],rep['id'])
                    self.assertEqual(c['coefficient_field_degree_F5'],degree)
                    self.assertEqual(c['encoded_coefficient_variables'],['alpha','t'])

    def test_resume_not_double_counted(self):
        with tempfile.TemporaryDirectory() as tmp:
            log=Path(tmp)/'events.jsonl'
            for value in (3,7):
                T.start_run(log,{'backend':'test'})
                event=dict(event='granular_round',counter_scope='test',matrix_nnz=10,
                    checkpoint_seconds=.1,coefficient_updates=value)
                for k in ('row_subtractions','row_reducer_calls','reducer_column_probes',
                          'reducer_zero_returns','symbol_queries','symbol_mask_skips','symbol_full_divisibility_rejects',
                          'symbol_generated_rows','symbol_generated_terms','zero_rows','gm_criterion_rejections','redundant_basis_elements'):
                    event[k]=1
                with log.open('a') as f:f.write(json.dumps(event)+'\n')
            with log.open('a') as f:f.write('{"incomplete":')
            runs=T.summarize(log)['invocations']
            self.assertEqual([r['counts']['coefficient_updates'] for r in runs],[3,7])


if __name__=='__main__':unittest.main()
