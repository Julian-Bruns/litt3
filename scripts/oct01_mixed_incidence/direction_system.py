#!/usr/bin/env python3
"""Exact scalar-direction reduction on the proved epsilon_3 != 0 chart.

Only the row/rank relaxation is built here: target authentication is deliberately
absent. It contains necessary constraints with the actual X,Y and row constants.
"""
import sys
from pathlib import Path
sys.path.insert(0,str(Path('/Users/julian/Documents/litt3-computation-data/october01_audited_replies/mixed_span_incidence/src')))
from field import K,F,BINV,mat_inv,transpose
from source_system import Circuit, evaluate
from incidence import endpoint,check_endpoint,phase_polynomials,f5rank
from finite import phi

CW,EW,UW,VW=(13,3,9,2),(4,3,14,0),(22,24,12,11),(6,21,11,0)


def build_direction(ep):
    ep=check_endpoint(ep)
    qs=phase_polynomials(ep)
    if f5rank(qs)!=2 or not all(any(q) for q in qs):raise ValueError('full-support span-two source required')
    A=endpoint(ep)
    cc=Circuit()
    r=tuple(cc.input(f'r_{i}') for i in range(3))+(cc.one,)
    h=cc.input('h')
    epsilon=tuple(cc.mul(h,z) for z in r)
    rows={n:tuple(cc.const(z) for z in row) for n,row in A.items()}
    E,C,U,V=(rows[n] for n in ('E1','C','U','V'))
    emb=lambda z:(z,cc.zero,cc.zero,cc.zero)
    add=lambda a,b:tuple(cc.add(x,y) for x,y in zip(a,b))
    sub=lambda a,b:tuple(cc.sub(x,y) for x,y in zip(a,b))
    def product(a,b):
        out=[cc.zero]*4
        for i in range(4):
            for j in range(4):
                term=cc.mul(a[i],b[j])
                if i+j>=4:term=cc.scale(term,21)
                out[(i+j)%4]=cc.add(out[(i+j)%4],term)
        return tuple(out)
    x=cc.add(U[0],cc.sum(cc.mul(U[3-i],r[i]) for i in range(3)))
    X=cc.frob(x,10)
    Y=cc.add(C[0],cc.sum(cc.mul(C[3-i],r[i]) for i in range(3)))
    D=add(product(epsilon,sub(E,emb(cc.frob(X,7)))),emb(cc.frob(Y,7)))
    G=add(product(epsilon,sub(C,emb(Y))),emb(X))
    Z=tuple(cc.scale(cc.frob(cc.scale(D[l],BINV[CW[l]]),8),VW[l]) if l<3 else cc.zero for l in range(4))
    W=sub(emb(cc.frob(X,11)),product(epsilon,add(Z,emb(cc.frob(Y,1)))))
    third=add(add(product(epsilon,sub(U,emb(x))),V),emb(cc.frob(Y,8)))
    inverse=mat_inv(transpose((A['E1'][1:],A['C'][1:],A['U'][1:])))
    sh=(cc.sub(E[0],cc.frob(X,7)),cc.sub(C[0],Y),cc.sub(U[0],x))
    ell=tuple(cc.sum(cc.mul(sh[i],cc.const(inverse[i][j])) for i in range(3)) for j in range(3))
    out={f'original_third_{l}':third[l] for l in range(3)}
    out['actual_rank_lift']=cc.sub(cc.add(Z[0],cc.frob(Y,1)),cc.sum(cc.mul(ell[i],Z[i+1]) for i in range(3)))
    for l in range(3):out[f'actual_W_G_{l}']=cc.sub(W[l],cc.scale(cc.frob(cc.scale(G[l],BINV[EW[l]]),11),UW[l]))
    assert len(out)==7 and len(cc.names)==4
    return {'format':'marked-K-circuit-v1','status':'necessary row relaxation; not solved',
            'source_phase_pairs':ep,'inputs':cc.names,'nodes':cc.nodes,'K_equations':out,'F5_equations':{},
            'prospective_rows':{'C':D,'E1':G,'U':W,'V':Z},'original_inputs':(*epsilon,X,Y),
            'automatic_zero':(third[3],G[3]),'F5_variables':56,
            'total_F5_equations_with_field':154,'maximum_F5_degree':5,
            'epsilon3_nonzero':'automatic from original_third_1 and V1 nonzero',
            'scope':'exact row relaxation on inherited nonzero epsilon3 chart; target pairs not authenticated'}


def check_direct(ep,inputs):
    from source_system import build
    reduced=build_direction(ep)
    # The inherited gate evaluator checks six inputs even for a circuit that
    # only references four. The two padding values are not circuit inputs.
    vals=evaluate(reduced,list(inputs)+[K.zero,K.zero])
    actual=[vals[g] for g in reduced['original_inputs']]
    expanded=build(ep)
    v=evaluate(expanded,actual)
    for name,g in reduced['K_equations'].items():
        assert vals[g]==v[expanded['K_equations'][name]]
    assert all(vals[g]==K.zero for g in reduced['automatic_zero'])
    for name,row in reduced['prospective_rows'].items():
        assert tuple(vals[g] for g in row)==tuple(v[g] for g in expanded['prospective_rows'][name])
    assert max(reduced['nodes'][g]['F5_degree_bound'] for g in reduced['K_equations'].values())<=5
    return actual
