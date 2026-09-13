"""Cyclic-five covers of the bad double not pulled back from Y.

Characteristic-five diagnostic only. Reuse the already checked affine
and Laurent reductions, then retain both parity components explicitly.
"""
import sys
import time
import argparse
from pathlib import Path
import json

parser=argparse.ArgumentParser()
parser.add_argument('--covers',type=int,default=1)
parser.add_argument('--field-only',action='store_true')
parser.add_argument('--module-length',type=int,choices=[3,5],default=5)
parser.add_argument('--include-invariant',action='store_true')
parser.add_argument('--output',type=Path)
parser.add_argument('--parameter-polynomial',default='3,4,1,4,1')
parser.add_argument('--precision',type=int,default=160)
local_args=parser.parse_args()
saved_argv=sys.argv
sys.argv=['bad_double_cyclic5_defect.sage','--covers','0','--parameter-polynomial',local_args.parameter_polynomial,'--precision',str(local_args.precision)]
load('scripts/deformations/cyclic/bad_double_cyclic5_defect.sage')
sys.argv=saved_argv
diag_started=time.monotonic()

anti_frob=laurent_coefficient(reduce_anti(R**2*z**5)[0],1)
assert anti_frob
roots=(anti_frob*u**5-u).roots(multiplicities=False)
print('ANTI_FIXED_ROOT_COUNT',len(roots),flush=True)
print('ANTI_FROBENIUS_OVER_F625',prod(anti_frob**(5**j) for j in range(4)),flush=True)
if local_args.field_only or len(roots)!=5:
    print('FIELD_DIAGNOSTIC_ONLY',flush=True)
else:
    length=local_args.module_length
    dimension=6*length
    results=[]
    anti_root=next(a for a in roots if a)
    zero=LS.zero()
    def add(v,w):return (v[0]+w[0],v[1]+w[1])
    def neg(v):return (-v[0],-v[1])
    def mul(v,w):return (v[0]*w[0]+R*v[1]*w[1],v[0]*w[1]+v[1]*w[0])
    def scal(a,v):return (a*v[0],a*v[1])
    def power(v,n):
        answer=(LS.one(),zero)
        for _ in range(n):answer=mul(answer,v)
        return answer
    def fift(v):return (v[0]**5,R**2*v[1]**5)
    inv_orders=[-3,-1,1]
    anti_orders=[1,2,3]
    def canon_tangent(v):
        r0,_=reduce0(v[0]);r1,_=reduce_anti(v[1])
        c0=sum(laurent_coefficient(r0,j)*z**j for j in inv_orders)
        c1=sum(laurent_coefficient(r1,j)*z**j for j in anti_orders)
        assert (r0-c0).valuation()>=2 and (r1-c1).valuation()>=4
        return (c0,c1),(r0-c0,r1-c1)
    def reduce_vector(vec,shift):
        vec=list(vec)
        for j in range(length-1,-1,-1):
            canonical,tail=canon_tangent(vec[j])
            for i in range(j):
                vec[i]=add(vec[i],neg(scal(binomial(j,i),mul(power(neg(shift),j-i),tail))))
            vec[j]=canonical
        return vector(k,[laurent_coefficient(vec[j][p],n)
            for j in range(length) for p,orders in enumerate([inv_orders,anti_orders]) for n in orders])
    # All25 classes with nonzero anti coordinate, normalized to anti_root.
    # Together with the6 invariant classes these are P^2(F5)'s31covers.
    choices=[(0,0,1)]+[(a,b,1) for a in Fp for b in Fp if a or b]
    if local_args.include_invariant:
        choices=[(1,b,0) for b in Fp]+[(0,1,0)]+choices
    for number,(aa,bb,cc) in enumerate(choices[:local_args.covers]):
        cl=aa*fixed[0]+bb*fixed[1]
        shift=(sum(cl[i]*z**orders[i] for i in range(2)),cc*anti_root*z)
        discrepancy=add(fift(shift),neg(shift))
        rem0,aff0=reduce0(discrepancy[0]);rem1,aff1=reduce_anti(discrepancy[1])
        assert rem0.valuation()>=1 and rem1.valuation()>=2
        fu=(aff0,aff1)
        columns=[];deck_columns=[]
        for j in range(length):
            for p,orders0 in enumerate([inv_orders,anti_orders]):
                for exponent in orders0:
                    monomial=(z**exponent,zero) if p==0 else (zero,z**exponent)
                    leading=scal(A,fift(monomial))
                    vv=[scal(binomial(j,i),mul(power(fu,j-i),leading)) if i<=j else (zero,zero)
                        for i in range(length)]
                    columns.append(reduce_vector(vv,shift))
                    dd=[scal(binomial(j,i),monomial) if i<=j else (zero,zero) for i in range(length)]
                    deck_columns.append(reduce_vector(dd,shift))
        psi=matrix(k,columns).transpose();deck=matrix(k,deck_columns).transpose()
        assert deck**5==identity_matrix(k,dimension)
        assert (deck-identity_matrix(k,dimension)).rank()==6*(length-1)
        assert deck*psi==psi*deck.apply_map(lambda c:c**5)
        iterate=identity_matrix(k,dimension);ranks=[]
        for j in range(5):
            iterate=iterate*psi.apply_map(lambda c:c**(5**j))
            ranks.append(int(iterate.rank()))
        # The degree<length AS filtration is the ACTUAL submodule
        # e^(5-length) of the regular cochain module. H0(tangent)=0
        # makes its cohomology injection exact. Its group-algebra
        # Schur coefficient through e^(length-1) is obtained without
        # constructing unused high AS powers.
        XX=PolynomialRing(Fp,'X');xx=XX.gen();polys=[xx**(length-1)]
        for _ in range(length-1):polys.append(polys[-1](xx+1)-polys[-1])
        tri=matrix(Fp,length,length,lambda i,j:polys[j][i])
        conversion=tri.tensor_product(identity_matrix(Fp,6)).change_ring(k)
        reg=conversion.inverse()*psi*conversion
        PE=PolynomialRing(k,'e');ee=PE.gen();RR=PE.quotient(ee**length,names='s');ss=RR.gen()
        mr=matrix(RR,6,6,lambda i,j:sum(reg[6*h+i,j]*ss**h for h in range(length)))
        const=matrix(k,6,6,lambda i,j:mr[i,j].lift()[0]);assert const.rank()==5
        pivcols=list(const.pivots());pivrows=list(const.matrix_from_columns(pivcols).transpose().pivots())
        ii=next(i for i in range(6) if i not in pivrows)
        jj=next(j for j in range(6) if j not in pivcols)
        block=mr.matrix_from_rows_and_columns(pivrows,pivcols)
        inv0=const.matrix_from_rows_and_columns(pivrows,pivcols).inverse().change_ring(RR)
        nil=identity_matrix(RR,5)-inv0*block
        inv=sum((nil**j for j in range(length)),zero_matrix(RR,5))*inv0
        assert inv*block==identity_matrix(RR,5)
        relation=mr[ii,jj]-(matrix(RR,1,5,[mr[ii,j] for j in pivcols])*inv*matrix(RR,5,1,[mr[i,jj] for i in pivrows]))[0,0]
        assert relation.lift()[0]==0 and relation.lift()[1]==0
        encode=lambda c:[int(v) for v in coordinates(c)]
        item=dict(number=int(number),coordinates=[int(aa),int(bb),int(cc)],
            module_length=int(length),defect=int(dimension-psi.rank()),iterate_ranks=ranks,
            schur_coefficients=[encode(relation.lift()[i]) for i in range(length)])
        results.append(item)
        if local_args.output:
            local_args.output.write_text(json.dumps(dict(status='partial',field_modulus=[int(c) for c in k.modulus()],parameter=encode(t),covers=results),indent=2)+'\n')
        print('ACTUAL_NONINVARIANT_COVER',number,'COORDINATES',aa,bb,cc,
              'DEFECT',dimension-psi.rank(),'ITERATE_RANKS',ranks,
              'SECONDS',round(time.monotonic()-diag_started,3),flush=True)
    if local_args.output:
        local_args.output.write_text(json.dumps(dict(status='complete',field_modulus=[int(c) for c in k.modulus()],parameter=encode(t),covers=results),indent=2)+'\n')
