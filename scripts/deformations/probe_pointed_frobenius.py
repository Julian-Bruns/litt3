#!/usr/bin/env sage -python
"""Exact evaluation resultant or finite point probe for pointed Frobenius.

Reuse the exact Laurent/cohomology builder in verify_pointed_extensions.sage
up to (but excluding) its resultant code. Change only P=5^height and the
requested precision. The points mode is only a finite probe; the resultant
mode uses proved unisolvent interpolation of every maximal minor.
A rank-drop witness is recorded with its complete kernel and actual block.
Generated artifacts must be written outside the litt3 workspace.
"""
import argparse
import hashlib
import itertools
import json
from pathlib import Path
import sys
import time
from sage.all import *
from sage.repl.preparse import preparse

parser = argparse.ArgumentParser(description=__doc__)
parser.add_argument('--height', type=int, default=3)
parser.add_argument('--field', choices=['prime', 'cubic'], default='prime')
parser.add_argument('--test', choices=['points', 'resultant'], default='points')
parser.add_argument('--torsions', default=','.join(map(str,range(16))))
parser.add_argument('--precision-extra', type=int, default=0)
parser.add_argument('--output', type=Path, required=True)
args = parser.parse_args()
assert args.height>=2 and args.precision_extra>=0
torsions=[int(i) for i in args.torsions.split(',')]
assert all(0<=i<16 for i in torsions)
workspace=Path(__file__).resolve().parents[2]
output=args.output.resolve()
assert not output.is_relative_to(workspace), 'Raw output belongs outside litt3.'
output.parent.mkdir(parents=True,exist_ok=True)

source=workspace/'scripts/deformations/verify_pointed_extensions.sage'
text=source.read_text()
prefix=text.split('\ndef verify_block(block):',1)[0]
assert prefix.count('P = 25')==1
prefix=prefix.replace('P = 25','P = '+str(5**args.height))
assert prefix.count('precision = 6*P+30')==1
prefix=prefix.replace('precision = 6*P+30',
                      'precision = 6*P+30+'+str(args.precision_extra))
saved_argv=sys.argv
sys.argv=[str(source)]
env=dict(globals())
try:
    exec(preparse(prefix),env)
finally:
    sys.argv=saved_argv
k_source=env['k']; raw_build_blocks=env['build_blocks']
k=k_source
field_embedding=None
field_inverse=None
if args.test=='resultant':
    # Sage 10.9's dense kernel failed direct multiplication over this
    # custom modulus. Transport through an explicit field isomorphism
    # to the canonical modulus; check EVERY resulting kernel as well.
    k=GF(125,'b')
    root=k_source.modulus().change_ring(k).roots(multiplicities=False)[0]
    field_embedding=k_source.hom([root],k)
    field_inverse={field_embedding(c):c for c in k_source}
    assert len(field_inverse)==125

def build_blocks(torsion):
    blocks=raw_build_blocks(torsion)
    if field_embedding is not None:
        for block in blocks:
            block['matrices']=[matrix(k,A.nrows(),A.ncols(),
                                      [field_embedding(c) for c in A.list()])
                               for A in block['matrices']]
    return blocks
P=5**args.height
elements=[k(i) for i in range(5)] if args.field=='prime' else list(k)
points=[(k(1),b,c) for b in elements for c in elements]
points += [(k(0),k(1),c) for c in elements]+[(k(0),k(0),k(1))]

def code(x):
    original=field_inverse[k(x)] if field_inverse is not None else k_source(x)
    cs=list(original.polynomial())
    return sum(int(c)*5**i for i,c in enumerate(cs))

def checkpoint():
    output.write_text(json.dumps(receipt,indent=2,default=int)+'\n')

started=time.monotonic()
receipt=dict(kind='finite_point_probe_not_geometric_exclusion',
             source=str(source),source_sha256=hashlib.sha256(text.encode()).hexdigest(),
             evaluator_sha256=hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
             height=int(args.height),P=int(P),precision=int(env['precision']),
             field='F125=T3+T+1',parameter_field=args.field,
             parameter_count=len(points),torsions=torsions,blocks=[],witnesses=[])
if args.test=='resultant':
    receipt['kind']='exact_pluecker_evaluation_resultant'
    receipt['parameter_field']='F125 unisolvent triangular grid'
    receipt['calculation_modulus']=list(map(int,k.modulus().list()))
    receipt['calculation_basis_in_original_codes']=[int(code(k.gen()**i)) for i in range(3)]
    receipt['node_codes_in_order']=[int(code(c)) for c in k]
    receipt.pop('parameter_count')

def evaluation_resultant(block,torsion,index):
    B=block['matrices']; n=int(B[0].ncols())
    q=(n+1)*(n+2)//2
    nodes=list(k)
    assert len(nodes)>=n+1
    pairs=list(itertools.combinations(range(n+2),2))
    assert len(pairs)==q
    value_rows=[]
    for total in range(n+1):
        for i in range(total+1):
            j=total-i
            point=(k(1),nodes[i],nodes[j])
            M=B[0]+point[1]*B[1]+point[2]*B[2]
            kernel=M.left_kernel().basis()
            assert all((v*M).is_zero() for v in kernel)
            if len(kernel)!=2:
                assert len(kernel)>2
                right=M.right_kernel().basis()
                assert right and all((M*v).is_zero() for v in right)
                receipt['witnesses'].append(dict(
                    kind='evaluated_rank_drop',torsion=torsion,block=index,
                    parameter=[int(code(c)) for c in point],
                    rank=n+2-len(kernel),columns=n,
                    weights=list(map(int,block['weights'])),
                    exponents=list(map(int,block['exponents'])),
                    kernel=[[int(code(c)) for c in v] for v in right],
                    matrix=[[int(code(c)) for c in row] for row in M.rows()]))
                return dict(torsion=torsion,block=index,columns=n,
                            coefficient_size=q,verdict='geometric_rank_drop_at_node')
            u,v=kernel
            row=vector(k,[u[i]*v[j]-u[j]*v[i] for i,j in pairs])
            assert not row.is_zero()
            value_rows.append(row)
            if len(value_rows)%256==0:
                receipt['active']=dict(torsion=torsion,block=index,
                                       nodes_built=len(value_rows),nodes_total=q)
                checkpoint()
    values=matrix(k,value_rows)
    assert values.nrows()==values.ncols()==q
    receipt['active']=dict(torsion=torsion,block=index,phase='exact_rank',size=q)
    checkpoint()
    rank=int(values.rank())
    record=dict(torsion=torsion,block=index,columns=n,coefficient_size=q,
                rank=rank,
                seconds=round(time.monotonic()-started,3))
    if rank<q:
        relations=values.right_kernel()
        basis=relations.basis()
        assert q-len(basis)==rank
        assert all(not v.is_zero() and (values*v).is_zero() for v in basis)
        v=basis[0]
        record['verdict']='geometric_rank_drop_exists'
        receipt['witnesses'].append(dict(
            kind='exact_resultant_relation',torsion=torsion,block=index,
            coefficient_size=q,rank=record['rank'],
            pair_order=[list(pair) for pair in pairs],
            pluecker_relation=[int(code(c)) for c in v]))
    else:
        record['verdict']='all_geometric_parameters_full_rank'
    return record

for torsion in torsions:
    blocks=build_blocks(torsion)
    for index,block in enumerate(blocks):
        if args.test=='resultant':
            record=evaluation_resultant(block,torsion,index)
            receipt['blocks'].append(record)
            receipt.pop('active',None)
            checkpoint()
            print(json.dumps(record,default=int),flush=True)
            if receipt['witnesses']:
                receipt['verdict']='Exact geometric failure; independent replay and proof audit required.'
                checkpoint()
                print(receipt['verdict'],flush=True)
                sys.exit(0)
            continue
        B=block['matrices']; n=B[0].ncols()
        assert B[0].nrows()==n+2
        ranks={}
        for point in points:
            M=sum((c*A for c,A in zip(point,B)),matrix(k,n+2,n))
            M=matrix(k,M.nrows(),M.ncols(),M.list(),sparse=True)
            rank=int(M.rank()); ranks[rank]=ranks.get(rank,0)+1
            if rank<n:
                kernel=M.right_kernel().basis()
                assert kernel and all((M*v).is_zero() for v in kernel)
                receipt['witnesses'].append(dict(
                    torsion=torsion,block=index,parameter=[code(c) for c in point],
                    rank=rank,columns=n,weights=list(map(int,block['weights'])),
                    exponents=list(map(int,block['exponents'])),
                    kernel=[[code(c) for c in v] for v in kernel],
                    matrix=[[code(c) for c in row] for row in M.rows()]))
                break
        record=dict(torsion=torsion,block=index,rows=n+2,columns=n,
                    ranks=ranks,seconds=round(time.monotonic()-started,3))
        receipt['blocks'].append(record)
        checkpoint()
        print(json.dumps(record,default=int),flush=True)
        if receipt['witnesses']:
            print('EXACT RANK-DROP WITNESS; independent replay and proof audit required.',flush=True)
            sys.exit(0)
receipt['verdict']=('All requested blocks have geometric constant rank.' if args.test=='resultant'
                    else 'No rank drop among tested points; no all-geometric conclusion.')
checkpoint()
print(receipt['verdict'],flush=True)
