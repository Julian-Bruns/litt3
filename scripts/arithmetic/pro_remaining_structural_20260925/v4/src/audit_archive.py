#!/usr/bin/env python3
"""Check internal evidence links and status labels; not a mathematical proof checker."""
from pathlib import Path
import ast
import json

ROOT = Path(__file__).resolve().parents[1]

if __name__ == '__main__':
    for p in ROOT.rglob('*.json'):
        json.loads(p.read_text(encoding='utf-8'))
    index = json.loads((ROOT/'claims.json').read_text(encoding='utf-8'))
    references = json.loads((ROOT/'references.json').read_text(encoding='utf-8'))
    ids = {c['id'] for c in index['claims']}
    assert len(ids) == len(index['claims'])
    rids = {r['id'] for r in references['references']}
    evidence_count = 0
    for claim in index['claims']:
        assert claim['status'] in index['status_legend']
        assert set(claim['dependencies']) <= ids | rids
        for evidence in claim['evidence']:
            path, _, anchor = evidence.partition('#')
            path, _, function = path.partition(':')
            target = ROOT/path
            assert target.is_file(), evidence
            if anchor:
                assert f'id="{anchor}"' in target.read_text(encoding='utf-8'), evidence
            if function:
                tree = ast.parse(target.read_text(encoding='utf-8'))
                names = {x.name for x in ast.walk(tree) if isinstance(x, (ast.FunctionDef, ast.AsyncFunctionDef))}
                assert function in names, evidence
            evidence_count += 1
    for p in (ROOT/'src').glob('*.py'):
        ast.parse(p.read_text(encoding='utf-8'))
    profiles = json.loads((ROOT/'data/numerical_profiles.json').read_text())
    assert [r['n'] for r in profiles] == list(range(14,183))
    assert all('NO ENDPOINT FUNCTIONS' in r['interpretation'] for r in profiles)
    result = json.loads((ROOT/'data/check_results.json').read_text())
    assert result['status'] == 'UNRESOLVED'
    assert result['geometric_existence_search_executed'] is False
    print(f'PASS: {len(index["claims"])} claim records and {evidence_count} evidence links')
    print(f'PASS: {len(rids)} standard-reference records; dependencies resolve')
    print('PASS: JSON parsing, Python syntax, and 169 explicit non-geometric profile labels')
    print('SCOPE: documentation/data audit only; not a proof checker or an existence decision')
