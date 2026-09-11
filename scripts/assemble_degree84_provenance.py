#!/usr/bin/env python3
"""Assemble and check every source edge of the final degree-84 certificate.

Polynomial identity receipts are accepted only with matching source and
certificate hashes. --replay reruns those standard-library verifiers too.
Affine pivots, localizations, subsets, merges and transports are recomputed.
The actual-map/cofactor coverage theorem is a separate geometric input.
"""
import argparse
import hashlib
import json
import subprocess
import sys
import time
from pathlib import Path
from sage.all import GF, PolynomialRing, matrix
from sparse_polynomial_substitution import SparsePolynomialTransport

p = argparse.ArgumentParser(description=__doc__)
p.add_argument('output', type=Path)
p.add_argument('--replay', action='store_true')
args = p.parse_args()
args.output.mkdir(exist_ok=False)
started = time.monotonic()
D = Path('/Users/julian/Documents/litt3-computation-data')
scripts = Path(__file__).resolve().parent
root = D/'degree84-recursive-linear-20260911/source.json'
final = D/'degree84-three-pole-final15-20260911/source.json'
data_cache, done, edges, artifacts, commands = {}, {}, [], {}, []
field_data = json.loads(root.read_text())
K = GF(5**15, 'a', modulus=PolynomialRing(GF(5), 'z')(field_data['field_modulus']))
rings = {}

def read(path):
    path = Path(path).resolve()
    if path not in data_cache:
        raw = path.read_bytes()
        data_cache[path] = json.loads(raw)
        artifacts[str(path)] = hashlib.sha256(raw).hexdigest()
    return data_cache[path]

def sha(path):
    read(path)
    return artifacts[str(Path(path).resolve())]

def ring(names):
    key = tuple(names)
    if key not in rings:
        rings[key] = PolynomialRing(K, len(key), names=key, order='degrevlex')
    return rings[key]

def decode(R, encoded):
    return R({tuple(e): K(c) for e,c in encoded})

def polys(data, key='equations', names='variables'):
    R = ring(data[names])
    return R, [decode(R, f) for f in data[key]]

def receipt(cert, source, embedded=None):
    cert, source = Path(cert), Path(source)
    c = read(cert)
    assert c['source_sha256'] == sha(source), ('certificate source', cert)
    possibilities = [cert.with_suffix('.replay.json'), cert.parent/'independent_replay.json']
    r = embedded
    if r is None:
        for candidate in possibilities:
            if candidate.exists():
                test = read(candidate)
                if test.get('certificate_sha256') == sha(cert):
                    r = test
                    break
    assert r and r['source_sha256'] == sha(source) and r['certificate_sha256'] == sha(cert), ('missing receipt', cert)
    assert r['status'] in ('independent_field_certificate_replay_pass', 'independent_polynomial_basis_identities_PASS')
    if 'polynomial_multipliers' in c and 'equations' in c:
        command = ['python3', str(scripts/'verify_polynomial_basis_identities.py'), str(source), str(cert)]
        command += [str(args.output/('replay-%d.json'%len(commands)))]
    else:
        assert r['kind'] == 'consequence'
        command = ['python3', str(scripts/'verify_field_macaulay_certificate.py'), str(source), str(cert), '--kind', 'consequence', '--receipt', str(args.output/('replay-%d.json'%len(commands)))]
    commands.append(command)
    if args.replay:
        with (args.output/('replay-%d.log'%(len(commands)-1))).open('x') as log:
            subprocess.run(command, check=True, stdout=log, stderr=subprocess.STDOUT)
    return c

def affine(data, incoming):
    R, original = polys(data, 'original_equations', 'original_variables')
    assert original == incoming, 'pre-substitution row list mismatch'
    current = original
    for stage in data.get('linear_substitution_stages', []):
        fresh = {R(name): decode(R,f) for name,f in stage.items()}
        linear = [f for f in current if f and f.total_degree() <= 1]
        columns = [R.one()]+list(R.gens())
        span = matrix(K, [[f.monomial_coefficient(c) for c in columns] for f in linear], implementation='generic').row_space()
        for x,f in fresh.items():
            assert (x-f).total_degree() <= 1
            assert span([ (x-f).monomial_coefficient(c) for c in columns ]) in span
        current = [f.subs(fresh) for f in current]
    subs = {R(name):decode(R,f) for name,f in data.get('substitutions',{}).items()}
    assert all(not set(f.variables()).intersection(subs) for f in subs.values())
    substituted = list(dict.fromkeys(f.subs(subs) for f in original if f.subs(subs)))
    assert substituted == list(dict.fromkeys(f for f in current if f))
    S, exported = polys(data)
    assert substituted == [R(f) for f in exported], 'whole affine export mismatch'
    return S, exported

transport_cache = {}
def visit(path):
    path = Path(path).resolve()
    if path in done:
        return done[path]
    data = read(path)
    assert data['field_modulus'] == field_data['field_modulus'] and data['field_degree'] == 15
    kind, parents = None, []
    if path == root:
        R, original = polys(data, 'original_equations', 'original_variables')
        v = R.gens_dict(); s = 3*v['b13']+2*v['c5']
        assert original[-3:] == [v['a%d'%j] for j in (4,9,14)]
        assert v['loc']*s-1 in original[:-3]
        for j in (4,9,14):
            assert s*v['a%d'%j] in original[:-3]
        result = affine(data, original)
        kind = 'actual_native_equations_plus_three_localized_derivative_consequences'
    elif (path.parent/'localization_provenance.json').exists():
        prov = read(path.parent/'localization_provenance.json')
        parent = Path(prov['previous_source']); R, incoming = visit(parent)
        assert prov['source_sha256'] == sha(parent)
        S = ring(data['original_variables']); new = [S(f) for f in incoming]
        new.append(S('pole0_inv')*S('c0')-1)
        for item in prov['derived']:
            c = receipt(item['certificate'], parent, item['replay'])
            f, g = decode(R,c['polynomial']), decode(R,item['polynomial'])
            if item['divide_by']:
                assert item['divide_by'] == 'c0' and f == R('c0')*g
            else:
                assert f == g
            new.append(S(g))
        result = affine(data, list(dict.fromkeys(f for f in new if f)))
        kind, parents = 'actual_C0_open_and_exact_factor_cancellation', [parent]
    elif (path.parent/'predecessors.json').exists():
        prov = read(path.parent/'predecessors.json')
        parent = Path(prov['previous_source']); R, incoming = visit(parent)
        new = list(incoming)
        for cert in prov['certificates']:
            c = read(cert); original_parent = Path(c['source'])
            visit(original_parent)
            receipt(cert, original_parent)
            assert read(original_parent)['variables'] == data['original_variables']
            new.append(decode(R,c['polynomial']))
        result = affine(data, list(dict.fromkeys(f for f in new if f)))
        kind, parents = 'append_independently_replayed_consequences', [parent]
    elif (path.parent/'subsystem_provenance.json').exists():
        prov = read(path.parent/'subsystem_provenance.json')
        parent = Path(prov['source']); R, incoming = visit(parent)
        assert prov['source_sha256'] == sha(parent)
        selected = [incoming[i] for i in prov['retained_equation_indices']]
        result = affine(data, selected)
        kind, parents = 'selected_subideal_and_affine_pivots', [parent]
    elif 'polynomial_multipliers' in data and 'equations' in data:
        parent = Path(data['source']); visit(parent); receipt(path, parent)
        result = polys(data)
        kind, parents = 'independently_replayed_polynomial_identities', [parent]
    elif 'provenance' in data:
        parent = Path(data['provenance']); R, expected = visit(parent)
        result = polys(data)
        assert result[0] == R and result[1] == expected
        kind, parents = 'exact_identity_rows', [parent]
    elif 'full_source' in data and 'affine_source' in data and 'basis' in data:
        full, aff, basis = (Path(data[k]) for k in ('full_source','affine_source','basis'))
        R, incoming = visit(full); visit(aff); S, basis_rows = visit(basis)
        for key,target in [('full_source',full),('affine_source',aff),('basis',basis)]:
            assert data[key+'_sha256'] == sha(target)
        cachekey = (sha(full),sha(aff))
        if cachekey not in transport_cache:
            a = read(aff)
            assert a['original_variables'] == read(full)['variables']
            subs = {name:decode(R,f) for name,f in a['substitutions'].items()}
            images = [S(subs.get(name,R.gen(i))) for i,name in enumerate(read(full)['variables'])]
            transport = SparsePolynomialTransport(R,S,images)
            transport_cache[cachekey] = [transport(f) for f in incoming]
        result = polys(data)
        assert result[0] == S and result[1] == basis_rows+transport_cache[cachekey]
        kind, parents = 'complete_original_system_transport_plus_verified_basis', [full,aff,basis]
    elif 'previous_source' in data and 'original_row_indices' in data:
        parent = Path(data['previous_source']); R, incoming = visit(parent)
        assert data['previous_source_sha256'] == sha(parent)
        result = polys(data)
        assert result[0] == R and result[1] == [incoming[i] for i in data['original_row_indices']]
        kind, parents = 'exact_selected_rows', [parent]
    elif 'substitution_images' in data and 'cofactor_lead' in data:
        parent = Path(data['source']); R, incoming = visit(parent)
        assert data['source_sha256'] == sha(parent)
        S = ring(data['variables'])
        transport = SparsePolynomialTransport(R,S,[decode(S,f) for f in data['substitution_images']])
        expected = list(dict.fromkeys(transport(f) for f in incoming if transport(f)))
        expected.append(S('lead_inv')*decode(S,data['cofactor_lead'])-1)
        result = polys(data)
        assert result[1] == list(dict.fromkeys(expected))
        kind, parents = 'cofactor_chart_full_transport_and_leading_inverse', [parent]
    elif 'first_source' in data and 'second_source' in data:
        first, second = Path(data['first_source']),Path(data['second_source'])
        R, one = visit(first); S, two = visit(second)
        assert R == S and data['first_source_sha256'] == sha(first) and data['second_source_sha256'] == sha(second)
        result = polys(data)
        assert result[1] == one+[two[i] for i in data['second_source_indices']]
        kind, parents = 'exact_merge', [first,second]
    else:
        raise AssertionError(('unrecognized provenance root',str(path),list(data)))
    done[path] = result
    edges.append(dict(path=str(path),sha256=sha(path),kind=kind,parents=[str(q) for q in parents],rows=len(result[1]),variables=len(result[0].gens())))
    print(json.dumps(dict(completed=len(done),path=str(path),kind=kind,seconds=time.monotonic()-started)),flush=True)
    return result

visit(final)
dag = D/'degree84-three-pole-dag-snapshot-20260911/dag.json'
dag_receipt = args.output/'unit_replay.json'
subprocess.run(['python3',str(scripts/'verify_polynomial_identity_dag.py'),str(final),str(dag),str(dag_receipt)],check=True)
read(dag);read(dag_receipt)
manifest = dict(status='complete_provenance_chain_PASS',root=str(root),root_sha256=sha(root),final_source=str(final),final_source_sha256=sha(final),unit_dag=str(dag),unit_dag_sha256=sha(dag),unit_replay=str(dag_receipt),edges=edges,artifacts=artifacts,replay_commands=commands,identity_replays_executed_now=args.replay,seconds=time.monotonic()-started,scope='Complete algebraic necessity chain. Actual native-map dictionary, dormant-orbit coverage and cofactor nonvanishing are separate audited geometric inputs.')
with (args.output/'manifest.json').open('x') as f:
    json.dump(manifest,f,indent=2);f.write('\n')
print(json.dumps({k:v for k,v in manifest.items() if k not in ('edges','artifacts','replay_commands')}),flush=True)
