#!/usr/bin/env sage
"""Polynomial two-K-variable source direction, on fixed-source L!=0.

Actual X,Y and all row constants are retained. This constructs a necessary
row/rank relaxation; target pair authentication is not included.
"""
import argparse
import json
import random
import sys
import time
from pathlib import Path
from sage.all import PolynomialRing, matrix
sys.path.insert(0, str(Path(__file__).parent))
from direction_boundary import marked_field
from direction_system import build_direction
from source_system import evaluate
from field import K
from incidence import endpoint, f5rank, phase_polynomials


def build_parametric(ep):
    if f5rank(phase_polynomials(ep)) != 2:
        raise ValueError('span-two actual source required')
    KK, b, embed, unembed = marked_field()
    A = endpoint(ep)
    base = {name: [embed(x) for x in row] for name, row in A.items()}
    C, U, V = [base[n] for n in ('C','U','V')]
    m = b(21); k = V[2]/V[1]; d = (U[2]-k*U[1])/U[3]
    aa, bb = 1-2*k*d, d*d+m*k*k
    L, constant = U[1]*aa-U[3]*bb, m*U[3]*aa-U[1]*bb
    if not L:
        raise ValueError('fixed-source L=0 branch requires the explicit K* x K chart')
    ell = V[1]*L
    bs = -constant/L
    alpha = -U[1]/(U[3]**2*V[1])
    delta = -(k*U[1]+U[2])/U[3]
    eta = -2*U[1]*d/U[3]-k*m
    R = PolynomialRing(KK, names=[f'a{r:02d}' for r in range(14)]+
                       [f'c{r:02d}' for r in range(14)], order='degrevlex')
    av, cv = R.gens()[:14], R.gens()[14:]
    rows = {name: [[x**(5**r) for x in row] for r in range(14)] for name, row in base.items()}
    dirs, f, x, Y, en = [], [], [], [], []
    for r in range(14):
        ph = lambda value: value**(5**r)
        r1 = ph(bs)+av[r]*cv[r]
        r2 = ph(k)*r1+ph(d)+av[r]/ph(U[3]*V[1])
        r0 = ph(alpha)*av[r]+ph(delta*bs+eta)+(ph(delta)*av[r]+ph(ell))*cv[r]
        direction = [r0,r1,r2,R.one()]
        Cr, Ur, Vr = [rows[n][r] for n in ('C','U','V')]
        xr = Ur[0]+Ur[3]*r0+Ur[2]*r1+Ur[1]*r2
        assert xr == ph(U[0]-U[1]*d-k*m*U[3])+ph(U[3]*ell)*cv[r]
        yr = Cr[0]+Cr[3]*r0+Cr[2]*r1+Cr[1]*r2
        fr = (Ur[1]-Ur[3]*r1)*r0+(ph(m)*Ur[3]-Ur[1]*r1)*r2+Ur[2]*(ph(m)-r1*r1)
        assert fr.degree(av[r]) <= 1 and fr.degree(cv[r]) <= 2
        dirs.append(direction); f.append(fr); x.append(xr); Y.append(yr)
        en.append([-Vr[1]*value for value in direction])
    X = [x[(r+10)%14] for r in range(14)]
    def product(left,right,r):
        values = [R.zero() for i in range(4)]
        for i in range(4):
            for j in range(4):
                values[(i+j)%4] += left[i]*right[j]*(b(21)**(5**r) if i+j>=4 else 1)
        return values
    D,G,third = [],[],[]
    for r in range(14):
        Dr = product(en[r],rows['E1'][r],r)
        Gr = product(en[r],rows['C'][r],r)
        Tr = product(en[r],rows['U'][r],r)
        for l in range(4):
            Dr[l] -= X[(r+7)%14]*en[r][l]
            Gr[l] -= Y[r]*en[r][l]
            Tr[l] += -x[r]*en[r][l]+rows['V'][r][l]*f[r]
        Dr[0] += Y[(r+7)%14]*f[r]
        Gr[0] += X[r]*f[r]
        Tr[0] += Y[(r+8)%14]*f[r]
        assert Gr[3] == 0 and all(Tr[l] == 0 for l in (1,2,3))
        D.append(Dr);G.append(Gr);third.append(Tr[0])
    Z = [[b(gamma)**(5**r)*D[(r+8)%14][l] for l,gamma in enumerate((13,17,7))]+[R.zero()] for r in range(14)]
    W = []
    for r in range(14):
        zr = Z[r][:];zr[0] += Y[(r+1)%14]*f[(r+8)%14]
        wr = [-v for v in product(en[r],zr,r)]
        wr[0] += X[(r+11)%14]*f[r]*f[(r+8)%14]
        W.append(wr)
    Ti = matrix(KK, [base[n][1:] for n in ('E1','C','U')]).transpose().inverse()
    eq, labels = [],[]
    for r in range(14):
        def put(name, value):
            eq.append(value); labels.append((name,r))
        put('original_third_0',third[r])
        sh = (rows['E1'][r][0]-X[(r+7)%14],rows['C'][r][0]-Y[r],rows['U'][r][0]-x[r])
        functional = [sum((sh[i]*Ti[i,j]**(5**r) for i in range(3)),R.zero()) for j in range(3)]
        put('actual_rank_lift',Z[r][0]+Y[(r+1)%14]*f[(r+8)%14]-
            sum((functional[j]*Z[r][j+1] for j in range(3)),R.zero()))
        for l,delta_l in enumerate((8,18,15)):
            put(f'actual_W_G_{l}',W[r][l]*f[(r+11)%14]-
                b(delta_l)**(5**r)*G[(r+11)%14][l]*f[r]*f[(r+8)%14])
    for r in range(14):
        for name, values in [('a',av),('c',cv)]:
            eq.append(values[r]**5-values[(r+1)%14]);labels.append((f'{name}_field',r))
    return R,eq,labels,dict(field=KK,embed=embed,unembed=unembed,rows=dict(C=D,E1=G,U=W,V=Z),
                          directions=dirs,denominators=f,X=X,Y=Y,L=L,parameters=(av,cv))


def main():
    parser=argparse.ArgumentParser();parser.add_argument('--source',required=True)
    parser.add_argument('--output',required=True,type=Path)
    parser.add_argument('--solve',action='store_true');parser.add_argument('--algorithm',default='singular:slimgb')
    args=parser.parse_args();ep=json.loads(args.source);start=time.monotonic()
    R,eq,labels,aux=build_parametric(ep);rng=random.Random(108);spec=build_direction(ep)
    for sample in range(5):
        while True:
            a = aux['embed'](K.zero if sample==0 else K.decode(rng.randrange(5**14)))
            c = aux['embed'](K.decode(rng.randrange(5**14)))
            point = [a**(5**r) for r in range(14)]+[c**(5**r) for r in range(14)]
            fs = [pol(*point) for pol in aux['denominators']]
            if fs[0]:break
        direction = [pol(*point) for pol in aux['directions'][0]][:3]+[-aux['embed'](endpoint(ep)['V'][1])/fs[0]]
        original_direction = [aux['unembed'](value) for value in direction]
        vals=evaluate(spec,original_direction+[K.zero,K.zero])
        for i,(name,r) in enumerate(labels[:70]):
            expected=aux['embed'](vals[spec['K_equations'][name]])**(5**r)
            denominator=fs[r] if name=='original_third_0' else fs[(r+8)%14] if name=='actual_rank_lift' else fs[r]*fs[(r+8)%14]*fs[(r+11)%14]
            assert eq[i](*point)==expected*denominator
        assert all(pol(*point)==0 for pol in eq[70:])
        for name,rows in aux['rows'].items():
            denominator=fs[0] if name in ('C','E1') else fs[8] if name=='V' else fs[0]*fs[8]
            actual=tuple(aux['unembed'](pol(*point)/denominator) for pol in rows[0])
            assert actual==tuple(vals[gate] for gate in spec['prospective_rows'][name])
    meta=dict(source=ep,variables=R.ngens(),equations=len(eq),terms=sum(len(pol.monomials()) for pol in eq),
              maximum_degree=int(max(pol.total_degree() for pol in eq)),point_checks=5,
              includes_boundary_A_zero=True,fixed_source_L_nonzero=True,
              build_check_seconds=time.monotonic()-start,
              scope='exact source row/rank relaxation on fixed-source L!=0; target authentication not imposed')
    args.output.parent.mkdir(parents=True,exist_ok=True);args.output.write_text(json.dumps(meta,indent=2)+'\n');print(json.dumps(meta),flush=True)
    if args.solve:
        start=time.monotonic();gb=R.ideal(eq).groebner_basis(algorithm=args.algorithm)
        meta.update(solver_seconds=time.monotonic()-start,basis_length=len(gb),unit_ideal=gb==[R.one()])
        args.output.write_text(json.dumps(meta,indent=2)+'\n');print(json.dumps(meta),flush=True)


if __name__=='__main__':main()
