"""Bounded local tests: finite-deck reconstruction and abstract absorption.

These are algebra tests, not new geometric obstruction calculations.
The returned immutable universal-trace directory supplies exact F625
arithmetic and the already audited polynomial action.
"""
import sys
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parents[3]))
import argparse
from fractions import Fraction
import importlib.util
import itertools
import json
from pathlib import Path
import sys
import time
import zipfile


def absorption_counterexample():
    group=list(itertools.product(range(5),repeat=2))
    ix={g:i for i,g in enumerate(group)}
    def conv(a,b):
        c=[Fraction(0)]*25
        for (i,j),v in zip(group,a):
            for (h,k),w in zip(group,b):
                c[ix[(i+h)%5,(j+k)%5]]+=v*w
        return c
    one=[Fraction(0)]*25;one[0]=1
    def logarithm(axis):
        e=[-v for v in one];e[ix[(1,0) if axis==0 else (0,1)]]=1
        z=[Fraction(0)]*25;power=one
        for j in range(1,5):
            power=conv(power,e)
            z=[u+Fraction((-1)**(j+1),j)*v for u,v in zip(z,power)]
        return z
    a,b=logarithm(0),logarithm(1)
    f=[u+2*v for u,v in zip(conv(a,a),conv(b,b))]
    x=[2*i**4+4*i*i*j*j+3*j**4 for i,j in group]
    x2=[v*v for v in x]
    shifts=[[x2[ix[(i+h)%5,(j+k)%5]] for h,k in group] for i,j in group]
    fx=[sum(c*x[ix[(i+h)%5,(j+k)%5]] for (h,k),c in zip(group,f)) for i,j in group]
    assert all(v.numerator%5==0 and v.denominator%5 for v in fx)
    target=[v/5 for v in fx]
    def mod(v,n):
        v=Fraction(v)
        return v.numerator*pow(v.denominator,-1,n)%n
    def solve(n):
        mat=[[int(v)%n for v in row]+[mod(v,n)] for row,v in zip(shifts,target)]
        for col in range(25):
            pivot=next(j for j in range(col,25) if mat[j][col]%5)
            mat[col],mat[pivot]=mat[pivot],mat[col]
            z=pow(mat[col][col],-1,n);mat[col]=[u*z%n for u in mat[col]]
            for j in range(25):
                if j!=col:
                    z=mat[j][col];mat[j]=[(u-z*v)%n for u,v in zip(mat[j],mat[col])]
        return [r[-1] for r in mat]
    sols={n:solve(5**n) for n in range(1,7)}
    for n,sol in sols.items():
        assert all((sum(a*b for a,b in zip(row,sol))-mod(v,5**n))%5**n==0 for row,v in zip(shifts,target))
        if n>1:assert [v%5**(n-1) for v in sol]==sols[n-1]
    assert sum(x2)%5==3
    assert len(set(v%5 for v in x))>1
    assert all((i*i+2*j*j)%5 for i,j in group if (i,j)!=(0,0))
    return {
        'status':'PASS: abstract unrestricted nonlinear absorption is FALSE',
        'ring':'Z5[C5 x C5], acting by translations on Fun(C5 x C5,Z5)',
        'L':'(log_4(sigma1)^2+2*log_4(sigma2)^2)*Phi; Phi fixes all displayed coefficients',
        'quadratic_symbol':'e1^2+2e2^2, nonzero at every nonzero F5 vector',
        'x':'2*w1^4+4*w1^2*w2^2+3*w2^4 evaluated at representatives0,...,4',
        'trace_x_squared_mod5':3,
        'normal_basis_matrix_invertible_mod5':True,
        'construction':'Choose the UNIQUE convolution C with C(x^2)=Lx/5. Its matrix is integral with unit determinant. Thus Lx=5*C(x^2) exactly over Z5, x is not invariant mod5, and0 is also a solution.',
        'compatible_C_lifts_checked_through_modulus':5**6,
        'C_mod625':sols[4],
        'scope':'Not an actual higher-Hodge operator/counterexample. It rules out a proof using arbitrary equivariance, quadratic symbol and p-adic nonlinear weights alone.'}


def invariant_ranks(root,max_degree):
    sys.path.insert(0,str(root/'lib'))
    sys.path.insert(0,str(root/'inputs'))
    spec=importlib.util.spec_from_file_location('universal_verify',root/'verify.py')
    v=importlib.util.module_from_spec(spec);spec.loader.exec_module(v)
    import numpy as np
    from locus import P,U,A,B,q,v1,v2,Up,Ap,Bp,v1p,v2p,exps,reduce_s
    import finite_field as F
    xs=[U,v1,v2,A,B,q];xp=[Up,v1p,v2p,Ap,Bp,q]
    pw=[[x**j for j in range(max_degree+1)] for x in xs]
    pp=[[x**j for j in range(max_degree+1)] for x in xp]
    orig=[];delta=[];surface=[];full_delta=[];rows=[]
    for d in range(max_degree+1):
        for e in exps(6,d):
            a=P(1);b=P(1)
            for i,j in enumerate(e):a*=pw[i][j];b*=pp[i][j]
            orig.append(a);delta.append(reduce_s(b-a));full_delta.append(b-a)
            surface.append(P({k:c for k,c in a.d.items() if k[1]==k[2]==0}))
        o,_=v.coefficient_matrix(orig);g,_=v.coefficient_matrix(delta);s,_=v.coefficient_matrix(surface)
        ga,_=v.coefficient_matrix(full_delta)
        ro=len(F.rref(o,False)[1]);rg=len(F.rref(g,False)[1]);rga=len(F.rref(ga,False)[1])
        rst=len(F.rref(np.vstack([g,s]),False)[1])
        row={'degree':d,'monomials':len(orig),'representation_rank':ro,'finite_deck_difference_rank':rg,'additive_group_difference_rank':rga,'invariant_dimension':ro-rg,'additive_invariant_dimension':ro-rga,'invariants_vanishing_on_surface':ro-rst}
        rows.append(row);print(json.dumps(row),flush=True)
    return rows


def constant_gradient_test():
    """Can a fixed target identification make the whole fourth map a gradient?"""
    import numpy as np
    import finite_field as F
    from scripts.deformations.rank25 import rank25_pro_data_model as m
    packet=Path(__file__).resolve().parents[3]/'Research/pro_inputs/rank25_all_fifth_lifts_inputs.zip'
    with zipfile.ZipFile(packet) as z:data=m.unpack(json.loads(z.read('fourth.json')))['obstruction']
    def code(v):return sum(a*5**i for i,a in enumerate(v))
    jac=[np.array([[code(c) for c in col] for col in data['frobenius']],dtype=np.uint16).T]
    jac += [np.zeros((9,9),dtype=np.uint16) for _ in range(9)]
    for i,j,row in data['quadratic']:
        col=np.array([code(c) for c in row],dtype=np.uint16)
        jac[j+1][:,i]=F.ADD[jac[j+1][:,i],col]
        jac[i+1][:,j]=F.ADD[jac[i+1][:,j],col]
    equations=[]
    for j in jac:
        for a in range(9):
            for b in range(a+1,9):
                row=np.zeros(81,dtype=np.uint16)
                row[9*a:9*a+9]=j[:,b]
                row[9*b:9*b+9]=F.NEG[j[:,a]]
                equations.append(row)
    ns=F.nullspace(np.array(equations));basis=ns.reshape((-1,9,9))
    ranks=[len(F.rref(v,False)[1]) for v in basis]
    common_kernel=9-len(F.rref(np.vstack(basis),False)[1]) if len(basis) else 9
    image_bound=len(F.rref(np.hstack(basis),False)[1]) if len(basis) else 0
    best=max(ranks,default=0);rng=np.random.default_rng(20260913)
    witness=None
    for _ in range(100):
        coefs=rng.integers(0,625,len(basis));v=np.zeros((9,9),dtype=np.uint16)
        for c,b in zip(coefs,basis):v=F.ADD[v,F.MUL[c,b]]
        r=len(F.rref(v,False)[1]);best=max(best,r)
        if r==9:witness=coefs.tolist();break
    potential=None; pairing=None
    if len(basis)==1 and ranks==[9]:
        pairing=basis[0]
        first=int(pairing[np.nonzero(pairing)][0]);pairing=F.MUL[F.INV[first],pairing]
        def mv(v):
            ans=np.zeros(9,dtype=np.uint16)
            for j,c in enumerate(v):ans=F.ADD[ans,F.MUL[int(c),pairing[:,j]]]
            return ans
        fields={}
        zero=(0,)*9
        fields[zero]=mv([code(c) for c in data['constant']])
        for j,col in enumerate(data['frobenius']):
            e=tuple(int(i==j) for i in range(9));fields[e]=mv([code(c) for c in col])
        for i,j,col in data['quadratic']:
            e=tuple(int(k==i)+int(k==j) for k in range(9));fields[e]=mv([code(c) for c in col])
        potential={}
        for e,vec in fields.items():
            inv=F.inv(sum(e)+1)
            for i,c in enumerate(vec):
                if c:
                    k=tuple(a+int(j==i) for j,a in enumerate(e))
                    potential[k]=F.add(potential.get(k,0),F.mul(int(c),inv))
        potential={e:c for e,c in potential.items() if c}
        for i in range(9):
            der={}
            for e,c in potential.items():
                if e[i]:
                    k=tuple(a-int(j==i) for j,a in enumerate(e))
                    der[k]=F.add(der.get(k,0),F.mul(e[i],c))
            assert {e:c for e,c in der.items() if c}=={e:int(v[i]) for e,v in fields.items() if v[i]}
        potential=[{'exponents':list(e),'coefficient':F.fmt(c)} for e,c in sorted(potential.items())]
        pairing=[[F.fmt(c) for c in row] for row in pairing]
    return {'symmetrizer_space_dimension':len(basis),'basis_matrix_ranks':ranks,
            'common_right_kernel_dimension':common_kernel,'common_image_dimension':image_bound,
            'largest_tested_rank':best,'invertible_witness':witness,
            'exact_pairing':pairing,'exact_cubic_potential':potential,
            'scope':'Constant linear target identification only; excludes neither nonlinear coordinates nor more general cyclic/derived structures.'}


def main():
    ap=argparse.ArgumentParser(description=__doc__)
    ap.add_argument('evidence',type=Path)
    ap.add_argument('--degree',type=int,default=4)
    ap.add_argument('--output',type=Path,required=True)
    args=ap.parse_args();start=time.time()
    result={'abstract_nonlinear_counterexample':absorption_counterexample(),'invariant_tests':invariant_ranks(args.evidence,args.degree),'constant_gradient_test':constant_gradient_test(),'seconds':time.time()-start}
    args.output.write_text(json.dumps(result,indent=2)+'\n')
    print(json.dumps(result['abstract_nonlinear_counterexample'],indent=2))


if __name__=='__main__':main()
