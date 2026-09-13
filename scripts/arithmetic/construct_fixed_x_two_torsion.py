#!/usr/bin/env python3
"""Construct actual two-torsion by a Frobenius-assisted exact division.

If P is the established Frob25 polynomial, choose binary Q with
Pbar*Qbar=T^171-1.  For f=P modulo2 with 0/1 coefficients, put
S=(T^171-1-fQ)/2 and H=(P-f)/2. Then B=S(F)-H(F)Q(F) satisfies
2B=F^171-1. This maps J(F_(25^171)) onto J[2]. It avoids multiplying
by the enormous odd part of the entire Jacobian group order.
Every returned norm is checked in the ORIGINAL fixed curve polynomial.
"""
import sys
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parents[2]))
import argparse,json,time
from pathlib import Path
from sage.all import GF,PolynomialRing,matrix,ZZ
from cysignals.alarm import alarm,cancel_alarm,AlarmInterrupt
from scripts.atlases.opers.fixed_x_monomial_jacobian import FixedXMonomialJacobian,FROBENIUS_COEFFICIENTS


def projection_polynomials():
    R=PolynomialRing(ZZ,'T');T=R.gen();P=R(FROBENIUS_COEFFICIENTS)
    R2=PolynomialRing(GF(2),'T');q,r=(R2.gen()**171-1).quo_rem(R2(P))
    assert not r
    Q=R([ZZ(c) for c in q]);f=R([ZZ(c%2) for c in P])
    S=R((T**171-1-f*Q)/2);H=R((P-f)/2)
    assert 2*(S-H*Q)==T**171-1-P*Q
    return P,Q,S,H


class FrobeniusEvaluator:
    def __init__(self,J,report):
        self.J=J;self.report=report;self.operations=0;self.frobenius_operations=0
        self.started=time.monotonic()

    def flip(self,a,b):
        value=self.J.km.addflip(a,b);self.operations+=1
        if self.operations%20==0:
            self.report('projection_arithmetic_progress',addflips=self.operations,
                frobenius=self.frobenius_operations,arithmetic_seconds=time.monotonic()-self.started)
        return value

    def negate(self,a):return self.flip(a,self.J.zero)

    def frob(self,a):
        self.frobenius_operations+=1
        return self.J.frobenius(a)

    def small_polynomial(self,poly,w):
        """Horner in Frobenius, carrying the addflip sign explicitly."""
        coefficients=list(map(int,poly));needed={abs(c) for c in coefficients if c}
        multiples={1:w,-1:self.negate(w)}
        for c in sorted(needed-{1}):
            multiples[c]=self.J.km.multiple(w,c)
            multiples[-c]=self.negate(multiples[c])
        result=None;sign=1
        for c in reversed(coefficients):
            if result is None:
                if c:result=multiples[c]
                continue
            result=self.frob(result)
            if c:result=self.flip(result,multiples[sign*c]);sign=-sign
        if result is None:return self.J.zero
        return result if sign==1 else self.negate(result)

    def wide_polynomial(self,poly,w,width=4):
        """Joint signed-window scalar evaluation of its eighteen Frobenius terms."""
        def naf(n):
            result=[]
            while n:
                if n%2:
                    digit=n%(1<<width)
                    if digit>=(1<<(width-1)):digit-=1<<width
                    n-=digit
                else:digit=0
                result.append(digit);n//=2
            return result
        digits=[naf(int(c)) for c in poly]
        needed={abs(v) for d in digits for v in d if v}
        base={1:w,-1:self.negate(w)}
        for c in sorted(needed-{1}):
            base[c]=self.J.km.multiple(w,c);base[-c]=self.negate(base[c])
        tables=[base]
        for i in range(1,len(digits)):
            tables.append({c:self.frob(v) for c,v in tables[-1].items()})
        result=None;sign=1
        for bit in reversed(range(max(map(len,digits),default=0))):
            if result is not None:result=self.flip(result,result);sign=-sign
            for i,d in enumerate(digits):
                c=d[bit] if bit<len(d) else 0
                if not c:continue
                if result is None:result=tables[i][c];sign=1
                else:result=self.flip(result,tables[i][sign*c]);sign=-sign
        if result is None:return self.J.zero
        return result if sign==1 else self.negate(result)


def recover_norm(J,w):
    """Recover the unique degree-nine norm from an actual nonzero 2-torsion class."""
    k=J.k;b3=J.bases[3];b6=J.bases[6];idx6=J.indices[6]
    def intersect(matrix0,basis,bound):
        high=[j for j,(x,y) in enumerate(basis) if 3*x+10*y>bound]
        coefficients=matrix0.matrix_from_columns(high).left_kernel_matrix()
        return coefficients*matrix0
    vv=intersect(w,b3,19);assert vv.nrows()==1
    def dictionary(row,basis):return {b:c for b,c in zip(basis,row) if c}
    def multiply(f,g):
        result={}
        for (i,j),c in f.items():
            for (ii,jj),cc in g.items():
                x=i+ii;y=j+jj
                if y<3:result[(x,y)]=result.get((x,y),k.zero())+c*cc
                else:
                    for h,fc in enumerate(J.f.list()):
                        key=(x+h,y-3);result[key]=result.get(key,k.zero())+c*cc*fc
        return {e:c for e,c in result.items() if c}
    products=matrix(k,0,len(b6));rank=0
    for row in w:
        left=dictionary(row,b3);rows=[]
        for other in w:
            product=multiply(left,dictionary(other,b3))
            rows.append([product.get(b,k.zero()) for b in b6])
        products=products.stack(matrix(k,rows)).echelon_form()
        rank=products.rank();products=products.matrix_from_rows(range(rank))
        if rank==32:break
    assert rank==32
    gg=intersect(products,b6,20);assert gg.nrows()==1
    v=dictionary(vv[0],b3);g=dictionary(gg[0],b6);v2=multiply(v,v)
    b18=sorted(((i,j) for j in range(2) for i in range((18-10*j)//3+1)),key=lambda ij:3*ij[0]+10*ij[1])
    b38=sorted(((i,j) for j in range(3) for i in range((38-10*j)//3+1)),key=lambda ij:3*ij[0]+10*ij[1])
    multiplication=[]
    for b in b18:
        product=multiply({b:k.one()},g)
        multiplication.append([product.get(t,k.zero()) for t in b38])
    A=matrix(k,multiplication)
    right=matrix(k,1,len(b38),[v2.get(t,k.zero()) for t in b38])[0]
    solution=A.transpose().solve_right(right)
    f={b:c for b,c in zip(b18,solution) if c}
    assert multiply(f,g)==v2
    R=J.f.parent();x=R.gen()
    P=sum((c*x**i for (i,j),c in f.items() if j==0),R.zero())
    Q=sum((c*x**i for (i,j),c in f.items() if j==1),R.zero())
    assert Q and Q.degree() in (1,2)
    norm=P**3+J.f*Q**3
    assert norm.degree()%2==0
    lc=norm.leading_coefficient()
    square_class_rescale=k.one()
    if not lc.is_square():
        square_class_rescale=lc;P*=lc;Q*=lc;norm=P**3+J.f*Q**3
    degree=norm.degree()//2;lead=norm.leading_coefficient().sqrt();root=lead*x**degree
    for i in reversed(range(degree)):
        root+=(norm[degree+i]-(root*root)[degree+i])/(2*lead)*x**i
    assert root*root==P**3+J.f*Q**3
    common=P.gcd(Q);odd=R.one()
    for factor,multiplicity in common.factor():
        if multiplicity%2:odd*=factor
    assert not J.f%odd
    encode=lambda f:[list(map(int,c.polynomial().list())) for c in f.list()]
    return dict(P=encode(P),Q=encode(Q),R=encode(root),
        square_class_rescale=list(map(int,square_class_rescale.polynomial().list())),
        twist_from_original_trivialization=1 if square_class_rescale.is_square() else -1,
        degrees=[int(P.degree()),int(Q.degree()),int(root.degree())],
        odd_common_part_divides_F=True,original_norm_identity=True)


def main():
    p=argparse.ArgumentParser(description=__doc__);p.add_argument('input',type=Path);p.add_argument('out',type=Path)
    p.add_argument('--seconds',type=int,default=1800)
    p.add_argument('--audit-evaluator',action='store_true')
    args=p.parse_args();args.out.mkdir(exist_ok=False);events=[];started=time.monotonic()
    def report(stage,**kw):
        item=dict(stage=stage,seconds=time.monotonic()-started,**kw);events.append(item)
        print(json.dumps(item),flush=True)
        (args.out/'progress.json').write_text(json.dumps(events,indent=2)+'\n')
    alarm(args.seconds)
    try:
        data=json.loads(args.input.read_text());d=data['field_degree']
        k=GF(5**d,'a' if d==2 else 'b',modulus=PolynomialRing(GF(5),'z')(data['modulus']),
             impl='givaro' if d==2 else 'pari_ffelt')
        a=k(data['a']);J=FixedXMonomialJacobian(k,a)
        xy=[k(c) for c in data['xy']];w=J.point(*xy)
        assert J.serialize(w)==data['point']
        P,Q,S,H=projection_polynomials();ev=FrobeniusEvaluator(J,report)
        report('actual_input_reconstructed',constant_degree=d,projection_Q_terms=len(Q.dict()),
               projection_S_terms=len(S.dict()),projection_H_bits=max(abs(c).nbits() for c in H))
        if args.audit_evaluator:
            assert d==2
            for poly in [Q,S,H]:
                fast=ev.small_polynomial(poly,w) if poly in [Q,S] else ev.wide_polynomial(poly,w)
                slow=J.km.multiple(w,poly(1))
                assert J.km.equal(fast,slow)
            report('signed_horner_and_window_independent_scalar_audit_passed')
        qw=ev.small_polynomial(Q,w);report('binary_quotient_evaluated')
        sw=ev.small_polynomial(S,w);report('small_carry_evaluated')
        hqw=ev.wide_polynomial(H,qw);report('large_coefficient_part_evaluated')
        answer=J.km.subtract(sw,hqw)
        assert J.km.equal(J.km.multiple(answer,2),J.zero)
        nonzero=not J.km.equal(answer,J.zero)
        (args.out/'torsion.json').write_text(json.dumps(dict(input=str(args.input.resolve()),
            field_degree=d,modulus=data['modulus'],a=data['a'],point=J.serialize(answer),
            nonzero=nonzero,doubling_zero=True,projection_identity=True),indent=2)+'\n')
        report('two_torsion_verified',nonzero=nonzero,addflips=ev.operations)
        if nonzero:
            norm=recover_norm(J,answer)
            (args.out/'norm.json').write_text(json.dumps(norm,indent=2)+'\n')
            report('actual_etale_norm_recovered',degrees=norm['degrees'])
        report('complete',scope='One actual two-torsion class and norm, not all carriers or degree2 exclusion')
    except AlarmInterrupt:report('time_limit_no_verdict')
    finally:cancel_alarm()


if __name__=='__main__':main()
