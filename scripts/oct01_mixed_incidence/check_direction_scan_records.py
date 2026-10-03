#!/usr/bin/env python3
"""Check final chunk coverage, aggregate counts and frozen scanner provenance.

This checks records, not the finite-field gcds again. The per-source hash
chain is a deterministic execution fingerprint; its discarded payloads are
reproducible from the source rather than independently checked here.
"""
import argparse, hashlib, json
from collections import Counter
from pathlib import Path


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--directory', required=True, type=Path)
    args = ap.parse_args()
    directory = args.directory
    state = json.loads((directory/'checkpoint.json').read_text())
    assert state['status'] == 'complete' and state['next_index'] == 602667
    assert state['total_source_count'] == 602667
    assert state['computation_cores'] == 1
    assert all(value == '1' for value in state['thread_environment'].values())
    source = Path(__file__).resolve().parent
    for name, expected in state['script_hashes'].items():
        assert hashlib.sha256((source/name).read_bytes()).hexdigest() == expected
    chunks = sorted(directory.glob('chunk_*.json'))
    assert len(chunks) == 603
    totals, sector = Counter(), {str(n): Counter() for n in (4,5,6)}
    cursor, seconds, cpu = 0, 0.0, 0.0
    manifests = []
    for path in chunks:
        raw = path.read_bytes()
        chunk = json.loads(raw)
        assert chunk['begin'] == cursor
        assert chunk['end'] == min(cursor+1000, 602667)
        assert chunk['counts']['sources'] == chunk['end']-cursor
        assert sum(s.get('sources',0) for s in chunk['by_support'].values()) == chunk['counts']['sources']
        combined = Counter()
        for n, values in chunk['by_support'].items():
            assert n in sector
            sector[n].update(values)
            combined.update(values)
        assert combined == Counter(chunk['counts'])
        totals.update(chunk['counts'])
        seconds += chunk['seconds']; cpu += chunk['cpu_seconds']
        manifests.append(dict(file=path.name, sha256=hashlib.sha256(raw).hexdigest()))
        cursor = chunk['end']
    assert cursor == 602667 and totals == Counter(state['counters'])
    assert all(sector[n] == Counter(state['by_support'][n]) for n in sector)
    assert {n: sector[n]['sources'] for n in sector} == {'4':49842,'5':236925,'6':315900}
    assert chunk['result_hash'] == state['result_hash']
    assert totals['row_relaxation_candidates'] == totals['rank_lift_survivors'] == 0
    assert not list(directory.glob('survivor_*.json'))
    result = dict(status='PASS', chunks_checked=len(chunks), coverage=[0,cursor],
                  counters=dict(totals), by_support={n:dict(v) for n,v in sector.items()},
                  total_recorded_seconds=seconds, total_recorded_cpu_seconds=cpu,
                  final_result_hash=state['result_hash'], script_hashes=state['script_hashes'],
                  chunk_manifest=manifests,
                  checked='contiguous coverage/count sums/frozen source hashes/final fingerprint/no survivor records',
                  not_repeated='finite-field gcd computations and per-source fingerprint payloads',
                  scope='complete NEW A=0 scalar-direction chart only; open chart remains')
    (directory/'integrity.json').write_text(json.dumps(result,indent=2)+'\n')
    print(json.dumps({k:v for k,v in result.items() if k!='chunk_manifest'}))


if __name__ == '__main__':
    main()
