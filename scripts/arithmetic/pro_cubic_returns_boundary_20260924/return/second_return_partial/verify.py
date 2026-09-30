#!/usr/bin/env python3
"""Verify input reconstruction and every new geometric exclusion certificate."""
from __future__ import annotations
import argparse
import hashlib
import itertools
import json
from pathlib import Path
import platform
import sys
import tempfile
import time
import numpy as np
import numba
ROOT=Path(__file__).resolve().parent
sys.path.insert(0,str(ROOT/'src'))
import graded_module as gm

def file_hash(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()

def verify_manifest(required=False):
    manifest=ROOT/'SHA256SUMS.json'
    if not manifest.exists():
        if required:
            raise AssertionError('SHA256SUMS.json is missing')
        print('Manifest not yet present (pre-packaging verification run).',flush=True)
        return
    expected=json.loads(manifest.read_text())
    for rel,h in expected.items():
        assert file_hash(ROOT/rel)==h, f'Manifest mismatch: {rel}'
    actual={p.relative_to(ROOT).as_posix() for p in ROOT.rglob('*')
            if p.is_file() and '__pycache__' not in p.parts
            and p.name!='SHA256SUMS.json'}
    assert actual==set(expected), f'File inventory differs: {actual.symmetric_difference(expected)}'
    print('PASS manifest SHA-256 and file inventory',flush=True)

def verify_vendor():
    vendor=ROOT/'vendor/full_return_inputs'
    hashes=json.loads((vendor/'SHA256.json').read_text())
    for rel,h in hashes.items():
        assert file_hash(vendor/rel)==h,rel
    print('PASS unchanged supplied source hashes',flush=True)

def verify_reconstruction():
    import compute as c
    import geometry as g
    import negative_quotient as nq
    original=c.ROOT
    original_g=g.ROOT
    with tempfile.TemporaryDirectory(prefix='second_return_rebuild_') as temp:
        c.ROOT=g.ROOT=Path(temp)
        try:
            tensor=c.build()
            actual=np.load(Path(temp)/'hom_tensor.npz')
            stored=np.load(ROOT/'data/hom_tensor.npz')
            assert set(actual.files)==set(stored.files)
            for key in stored.files:
                assert np.array_equal(actual[key],stored[key]),key
            _,_,Q,_,_=nq.build_negative(25,-1)
            assert np.array_equal(Q,np.load(ROOT/'data/negative_second.npz')['Q'])
            g.stability_sections()
            assert json.loads((Path(temp)/'stability_sections.json').read_text())==json.loads((ROOT/'data/stability_sections.json').read_text())
            g.regression()
        finally:
            c.ROOT=original
            g.ROOT=original_g
    print('PASS exact reconstruction of T, Q, eliminations, and dual sections',flush=True)

def verify_minor(M,evidence):
    rows=np.asarray(evidence['row_indices'],dtype=np.int64)
    cols=np.asarray(evidence['column_indices'],dtype=np.int64)
    rank=int(evidence['rank'])
    assert len(rows)==len(cols)==rank
    assert len(set(rows.tolist()))==len(set(cols.tolist()))==rank
    assert np.all((rows>=0)&(rows<M.shape[0]))
    assert np.all((cols>=0)&(cols<M.shape[1]))
    det=gm.determinant(M[np.ix_(rows,cols)])
    assert det==int(evidence['determinant_code'])!=0
    return rank,det

def verify_P4(T):
    certificates=json.loads((ROOT/'certificates/P4.json').read_text())
    outside=[i for i in range(19) if i not in (0,6,7)]
    wanted={(0,6,7,*pair) for pair in itertools.combinations(outside,2)}
    assert len(certificates)==120
    assert {tuple(x['support']) for x in certificates}==wanted
    for index,record in enumerate(certificates,1):
        M=gm.macaulay(T[record['support']],record['degree'])
        assert list(M.shape)==record['matrix_shape']==[2800,2450]
        rank,det=verify_minor(M,record['minor'])
        assert rank==M.shape[1]==2450
        print('PASS P4',index,record['support'],'rank',rank,'minor determinant',det,flush=True)
    print('PASS all 120 mixed coordinate P4 spaces over every field extension',flush=True)

def verify_large(T):
    records=json.loads((ROOT/'certificates/large.json').read_text())
    expected={
      'pure_u_P5':[0,1,2,3,4,5],
      'mixed_a_P5':[0,6,7,1,2,3],
      'mixed_b_P5':[0,6,7,8,9,10],
      'mixed_c_P5':[0,6,7,13,14,15],
      'mixed_d_P5':[0,6,7,1,8,13],
      'mixed_P6':[0,6,7,1,8,13,2],
    }
    assert {r['name']:r['support'] for r in records}==expected
    for record in records:
        support=record['support'];n=len(support);d=record['degree']
        M=gm.macaulay(T[support],d)
        assert list(M.shape)==record['matrix_shape']
        rank,_=verify_minor(M,record['minor'])
        h=record['quotient_dimension']
        assert h==M.shape[1]-rank
        if h==0:
            assert record['vanishing_degree']==d
            print('PASS',record['name'],'degree',d,'full rank',rank,flush=True)
            continue
        data=np.load(ROOT/record['normal_form_file'])
        N,free=data['N'],data['free']
        assert N.shape==(M.shape[1],h) and free.shape==(h,)
        assert len(set(free.tolist()))==h
        assert np.all((free>=0)&(free<M.shape[1]))
        assert np.array_equal(N[free],np.eye(h,dtype=np.uint8))
        assert not gm.arithmetic.matmul(M,N).any()
        # The minor and these two identities prove that N is EXACTLY the
        # degree-d quotient map, without trusting stored RREF output.
        evidence=record['commutator']
        assert evidence['full_relation_count']==gm.relation_count(n,d,35)
        indices=np.asarray(evidence['selected_relation_indices'],dtype=np.int64)
        assert len(indices)==len(set(indices.tolist()))==n*h==evidence['square_size']
        B=gm.commutator_relations(N,n,d,35,indices)
        assert B.shape==(n*h,n*h)
        det=gm.determinant(B)
        assert det==evidence['determinant_code']!=0
        assert record['vanishing_degree']==d+1
        print('PASS',record['name'],'M_d rank',rank,'quotient dimension',h,
              'commutator rank',n*h,'minor determinant',det,
              'therefore degree',d+1,'quotient zero',flush=True)
    print('PASS pure-u P5, four mixed P5 spaces, and mixed P6',flush=True)

def main():
    parser=argparse.ArgumentParser()
    parser.add_argument('--manifest-only',action='store_true')
    parser.add_argument('--skip-rebuild',action='store_true',
                        help='Check certificates against stored tensors only; not a source reconstruction')
    args=parser.parse_args()
    if args.manifest_only:
        verify_manifest(required=True)
        return
    started=time.monotonic()
    print('Python',platform.python_version(),'NumPy',np.__version__,'Numba',numba.__version__,flush=True)
    verify_manifest()
    verify_vendor()
    gm.field_self_test()
    print('PASS field arithmetic and nonzero-minor bookkeeping self-tests',flush=True)
    if not args.skip_rebuild:
        verify_reconstruction()
    else:
        print('SKIPPED input reconstruction by explicit --skip-rebuild option',flush=True)
    T=np.load(ROOT/'data/hom_tensor.npz')['T']
    Q=np.load(ROOT/'data/negative_second.npz')['Q']
    portable=json.loads((ROOT/'data/tensors.json').read_text())
    assert np.array_equal(T,np.array(portable['T'],dtype=np.uint8))
    assert np.array_equal(Q,np.array(portable['Q'],dtype=np.uint8))
    print('PASS portable tensor data agree with NPZ arrays',flush=True)
    verify_P4(T)
    verify_large(T)
    print('PASS ALL NEW EXCLUSION CERTIFICATES',flush=True)
    print('Completion status: PARTIAL; the full stable second-return decision is unresolved.',flush=True)
    print('Elapsed seconds:',round(time.monotonic()-started,3),flush=True)

if __name__=='__main__':
    main()
