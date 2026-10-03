#!/usr/bin/env sage
"""Exact bounded-width second-moment elimination at a fixed first moment.

The module decides the necessary original row/rank relaxation, not target
authentication. It is a building block for first-moment eliminants, not a
completed traversal over first moments or sources.
"""
import argparse
import json
import random
import sys
import time
from pathlib import Path
from sage.all import PolynomialRing, matrix, vector
sys.path.insert(0,str(Path(__file__).parent))
from direction_boundary import marked_field
from source_system import build, evaluate
from source_mobius import resolvent_matrix, m2det
from source_rank_resolvent import rank_lift_map, coupled_polynomials
from field import K,F
from incidence import endpoint
from finite import phi


def module_at_first_moment(ep,x):
    A=endpoint(ep);M,Rx=resolvent_matrix(A,x)
    if m2det(M)==K.zero:
        return None,dict(status='inherited-singular-first-moment',source=ep,x=x)
    J,aux=rank_lift_map(A,x,M,Rx);polys=coupled_polynomials(M,J)
    KK,b,embed,unembed=marked_field();P=PolynomialRing(KK,'T');T=P.gen()
    q=P([embed(c) for c in aux['special_eliminant']]).monic();d=q.degree()
    assert d in (5,6)
    AA=P.quotient(q,'z');z=AA.gen()
    def coords(a):
        coefficients=P(a.lift()).list()
        return vector(KK,coefficients+[KK.zero()]*(d-len(coefficients)))
    fromcoords=lambda v:AA(P(list(v)))
    frob=matrix(KK,[list(coords(z**(5*j))) for j in range(d)]).transpose()
    def ph(a,n):
        v=coords(a)
        for step in range(n%14):v=frob*vector(KK,[c**5 for c in v])
        return fromcoords(v)
    # Fourteen applications must NOT be reduced modulo14 for the field return.
    v=coords(z)
    for r in range(14):v=frob*vector(KK,[c**5 for c in v])
    field_return=fromcoords(v)-z
    assert field_return==z**(5**14)-z
    epsilon=[AA(embed(Rx[l]))*z+AA(embed(F.mul(Rx,A['V'])[l])) for l in range(4)]
    X=AA(embed(phi(x,10)));Y=ph(z,6)
    spec=build(ep);inputs=epsilon+[X,Y];values=[]
    for node in spec['nodes']:
        op,args=node['op'],node['args']
        if op=='constant':v=AA(embed(K.decode(args[0])))
        elif op=='input':v=inputs[args[0]]
        elif op=='add':v=values[args[0]]+values[args[1]]
        elif op=='multiply':v=values[args[0]]*values[args[1]]
        elif op=='Frobenius':v=ph(values[args[0]],args[1])
        elif op=='F5_coordinate':
            # Authentication/count/Moore gates are not needed or evaluated.
            v=AA.zero()
        else:raise ValueError(op)
        values.append(v)
    names=['G3','actual_rank_lift']+[f'actual_W_G_{i}' for i in range(3)]
    residuals={'actual_K_field_return':field_return}
    residuals.update({name:values[spec['K_equations'][name]] for name in names})
    assert all(values[spec['K_equations'][f'original_third_{l}']]==0 for l in (1,2,3))
    assert values[spec['K_equations']['original_third_0']]==field_return
    # Multiplication images generate the residual ideal. The quotient dimension
    # is the degree of the common gcd, including repeated-polynomial boundaries.
    matrices=[];stages=[];g=q
    for name,r in residuals.items():
        matrices.append(matrix(KK,[list(coords(r*z**j)) for j in range(d)]).transpose())
        g=g.gcd(P(r.lift())).monic();stages.append((name,int(g.degree())))
    block=matrix(KK,d,0)
    for mat in matrices:block=block.augment(mat)
    rank=block.rank();assert d-rank==g.degree()
    # Compact two-residual norm: identically zero in lambda exactly when the
    # two residues have a common root in the base polynomial over a closure.
    LR=PolynomialRing(KK,'lambda');lam=LR.gen()
    g3mat=matrices[1].change_ring(LR);wgmat=matrices[3].change_ring(LR)
    norm=(g3mat+lam*wgmat).det()
    pairgcd=q.gcd(P(residuals['G3'].lift())).gcd(P(residuals['actual_W_G_0'].lift()))
    assert (norm==0)==(pairgcd.degree()>0)
    roots=[unembed(a) for a,mult in g.roots()]
    assert len(roots)==g.degree(), 'field return makes the final gcd split and squarefree'
    # Every positive module point is rechecked in the original field circuit.
    for root in roots:
        eps=F.mul(Rx,F.add(A['V'],F.elt([root])))
        actual=list(eps)+[phi(x,10),phi(root,6)]
        direct=evaluate(spec,actual)
        for name in names+[f'original_third_{l}' for l in range(4)]:
            assert direct[spec['K_equations'][name]]==K.zero
    rng=random.Random(119)
    for sample in range(5):
        v=fromcoords([embed(K.decode(rng.randrange(5**14))) for j in range(d)])
        assert ph(v,1)==v**5
    meta=dict(source=ep,x=x,status='fixed-first-moment row/rank relaxation decided',
        module_dimension=int(d),frobenius_matrix_dimensions=[int(d),int(d)],
        field_return_iterations=14,field_return_native_check=True,frobenius_point_checks=5,
        residual_gcd_degrees=stages,multiplication_block_dimensions=[int(d),int(block.ncols())],
        multiplication_block_rank=int(rank),row_relaxation_candidates=roots,
        pair_norm_degree=int(norm.degree()) if norm else None,pair_norm_zero=norm==0,
        pair_common_gcd_degree=int(pairgcd.degree()),
        rank_map_degree=J.degree,involution_numerator_degree=len(polys['involution'])-1,
        scope='exact row/rank relaxation for ONE source and ONE first moment; target authentication absent')
    return dict(field=KK,ring=P,quotient=AA,polynomial=q,residuals=residuals,
        frobenius=frob,multiplication_matrices=matrices,block=block,pair_norm=norm,gcd=g),meta


def main():
    ap=argparse.ArgumentParser();ap.add_argument('--source',required=True);ap.add_argument('--first-moment',required=True)
    ap.add_argument('--output',required=True,type=Path);args=ap.parse_args();start=time.monotonic()
    aux,meta=module_at_first_moment(json.loads(args.source),tuple(json.loads(args.first_moment)))
    meta['seconds']=time.monotonic()-start
    args.output.parent.mkdir(parents=True,exist_ok=True);args.output.write_text(json.dumps(meta,indent=2)+'\n')
    print(json.dumps(meta),flush=True)


if __name__=='__main__':main()
