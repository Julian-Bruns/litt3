#!/usr/bin/env sage
"""Resumable complete traversal of the NEW A=0 scalar-direction chart.

The inherited epsilon_3=0/resolvent exclusions are not recomputed.
Only compact chunk records and any surviving exact point are saved.
"""
import argparse
import hashlib
import json
import os
import platform
import sys
import time
from collections import Counter
from itertools import combinations, combinations_with_replacement, permutations
from pathlib import Path

sys.path.insert(0, str(Path(__file__).parent))
from direction_boundary import build_boundary, marked_field, solve_boundary_quotient
from direction_system import build_direction, check_direct
from source_system import evaluate
from field import K, F, xi
from incidence import endpoint, f5rank, phase_polynomials, rank_graph, equations_hold
from source_mobius import reconstruct_endpoint
from support_gap_orbits import affine_representatives_free, phases


def canonical_root(ep):
    ep = tuple(tuple(sorted(p)) for p in ep)
    return min(ep[j:]+ep[:j] for j in range(4))


def templates(n):
    pairs = tuple(combinations_with_replacement(range(n), 2))
    result = set()
    for triple in combinations(pairs, 3):
        if set().union(*map(set, triple)) != set(range(n)):
            continue
        if set.intersection(*map(set, triple)):
            continue
        # For n>=4, the supplied sole collinear triple aa,ab,bb cannot occur.
        for repeated in triple:
            others = [p for p in triple if p != repeated]
            for ordered in set(permutations((repeated, repeated, *others))):
                result.add(canonical_root(ordered))
    if n == 4:
        four_sets = set()
        for a, b in combinations(range(4), 2):
            rest = tuple(i for i in range(4) if i not in (a, b))
            four_sets.add(tuple(sorted(((a, a), (a, b), (b, b), rest))))
        for cycle in permutations(range(4)):
            four_sets.add(tuple(sorted(tuple(sorted((cycle[j], cycle[(j+1) % 4])))
                                       for j in range(4))))
        assert len(four_sets) == 9
        for four in four_sets:
            for ep in permutations(four):
                qs = phase_polynomials(ep)
                if all(any(q) for q in qs) and f5rank(qs) == 2:
                    result.add(canonical_root(ep))
    expected = {4: 426, 5: 405, 6: 135}[n]
    assert len(result) == expected
    assert all(f5rank(phase_polynomials(ep)) == 2 and
               all(any(q) for q in phase_polynomials(ep)) for ep in result)
    return tuple(sorted(result))


def source_inputs():
    expected = {4: 49842, 5: 236925, 6: 315900}
    for n in (4, 5, 6):
        abstract = templates(n)
        supports = [phases(mask) for mask in affine_representatives_free(n)]
        assert len(abstract)*len(supports) == expected[n]
        for si, support in enumerate(supports):
            for ti, ep in enumerate(abstract):
                yield n, si, ti, tuple(tuple(support[j] for j in p) for p in ep)


def decode_survivor(ep, direction):
    original = check_direct(ep, direction)
    spec = build_direction(ep)
    vals = evaluate(spec, direction+[K.zero, K.zero])
    B = {name: tuple(vals[g] for g in row) for name, row in spec['prospective_rows'].items()}
    target = reconstruct_endpoint(B)
    point = dict(source=ep, direction=direction, original_inputs=original,
                 prospective_target_rows=B)
    if target is None:
        point['status'] = 'row-relaxation survivor; target not genuine'
        return point
    point['target'] = target
    span = f5rank(phase_polynomials(target))
    support = all(B['C'][l] != K.zero for l in (1, 2, 3))
    if span != 3 or not support:
        point.update(status='genuine target outside required phase/support', target_span=span, full_support=support)
        return point
    eps, X, Y = tuple(original[:4]), original[4], original[5]
    A = endpoint(ep)
    assert rank_graph(A, B)[0]
    assert all(equations_hold(A, B, eps, X, Y))
    assert not F.inK(eps)
    for shift in range(29):
        ee = F.scale(eps, K.pow(xi, -13*shift))
        if F.inE(ee):
            continue
        aa = tuple(tuple(sorted((j+shift) % 29 for j in p)) for p in ep)
        bb = tuple(tuple(sorted((j-shift) % 29 for j in p)) for p in target)
        xx, yy = K.mul(K.pow(xi, -8*shift), X), K.mul(K.pow(xi, 5*shift), Y)
        Ar, Br = endpoint(aa), endpoint(bb)
        assert f5rank(phase_polynomials(aa)) == 2 and f5rank(phase_polynomials(bb)) == 3
        assert rank_graph(Ar, Br)[0] and all(equations_hold(Ar, Br, ee, xx, yy))
        point.update(status='full-original-witness', restored_source=aa, restored_target=bb,
                     epsilon=ee, X=xx, Y=yy, opposite_shift=shift)
        return point
    raise AssertionError('opposite phase restoration failed')


def save_json(path, data):
    temporary = path.with_suffix(path.suffix+'.tmp')
    temporary.write_text(json.dumps(data, indent=2)+'\n')
    os.replace(temporary, path)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--output-dir', required=True, type=Path)
    parser.add_argument('--end', type=int, default=602667)
    parser.add_argument('--chunk-size', type=int, default=1000)
    args = parser.parse_args()
    args.output_dir.mkdir(parents=True, exist_ok=True)
    state_path = args.output_dir/'checkpoint.json'
    script_hashes = {name: hashlib.sha256((Path(__file__).parent/name).read_bytes()).hexdigest()
                     for name in ('scan_direction_boundary.py', 'direction_boundary.py', 'direction_system.py')}
    if state_path.exists():
        state = json.loads(state_path.read_text())
        assert state['script_hashes'] == script_hashes
    else:
        state = dict(format='source-A-zero-chart-v1', next_index=0, total_source_count=602667,
                     status='partial', result_hash=hashlib.sha256(b'source-A-zero-chart-v1').hexdigest(),
                     counters={}, by_support={}, script_hashes=script_hashes,
                     platform=platform.platform(), computation_cores=1,
                     thread_environment={name: os.environ.get(name) for name in
                                         ('OMP_NUM_THREADS','OPENBLAS_NUM_THREADS','MKL_NUM_THREADS','VECLIB_MAXIMUM_THREADS')})
        save_json(state_path, state)
    begin = state['next_index']; totals = Counter(state['counters'])
    sector_totals = {n: Counter(state['by_support'].get(str(n), {})) for n in (4, 5, 6)}
    data = marked_field()
    chunk_begin = begin; chunk_start = time.monotonic(); chunk_cpu = time.process_time()
    chunk_counts = Counter(); chunk_sector = {n: Counter() for n in (4, 5, 6)}
    for index, (n, si, ti, ep) in enumerate(source_inputs()):
        if index < begin:
            continue
        if index >= args.end:
            break
        out = build_boundary(ep, data)
        survivors, result = solve_boundary_quotient(out)
        counts = Counter(sources=1, finite_monodromy_roots=result.get('roots_K_before_semilinear_filter',0),
                         original_third_candidates=result.get('original_third_candidates',0),
                         row_relaxation_candidates=len(survivors))
        if 'empty_stage' in result:
            counts['linear_boundary_empty'] += 1
        counts['rank_lift_survivors'] += (result.get('residual_gcd_degrees') or [('none',0)])[0][1]
        record = dict(index=index, support_size=n, support_index=si, template_index=ti,
                      source=ep, result=result)
        payload = json.dumps(record, separators=(',', ':'), sort_keys=True).encode()
        state['result_hash'] = hashlib.sha256(bytes.fromhex(state['result_hash'])+payload).hexdigest()
        if survivors:
            points = [decode_survivor(ep, point) for point in survivors]
            save_json(args.output_dir/f'survivor_{index:07d}.json', dict(record=record, points=points))
            counts['genuine_witnesses'] += sum(point['status'] == 'full-original-witness' for point in points)
        totals.update(counts); sector_totals[n].update(counts)
        chunk_counts.update(counts); chunk_sector[n].update(counts)
        state['next_index'] = index+1
        if state['next_index'] % args.chunk_size == 0 or state['next_index'] == args.end or counts['genuine_witnesses']:
            completed = dict(begin=chunk_begin, end=state['next_index'], counts=dict(chunk_counts),
                             by_support={str(n): dict(v) for n,v in chunk_sector.items()},
                             seconds=time.monotonic()-chunk_start, cpu_seconds=time.process_time()-chunk_cpu,
                             result_hash=state['result_hash'])
            save_json(args.output_dir/f'chunk_{chunk_begin:07d}_{state["next_index"]:07d}.json', completed)
            state.update(counters=dict(totals), by_support={str(n): dict(v) for n,v in sector_totals.items()},
                         status='full-original-witness' if counts['genuine_witnesses'] else
                                ('complete' if state['next_index']==602667 else 'partial'))
            save_json(state_path, state)
            print(json.dumps(dict(end=state['next_index'], counts=dict(chunk_counts),
                                  seconds=completed['seconds'], status=state['status'])), flush=True)
            chunk_begin = state['next_index']; chunk_start = time.monotonic(); chunk_cpu = time.process_time()
            chunk_counts = Counter(); chunk_sector = {n: Counter() for n in (4,5,6)}
            if counts['genuine_witnesses']:
                break
    print(json.dumps(state), flush=True)


if __name__ == '__main__':
    main()
