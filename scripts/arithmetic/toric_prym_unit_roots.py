#!/usr/bin/env python3
"""Exact interior Hasse--Witt / two-digit unit roots of an actual toric carrier.

Lift the FINAL support-preserving toric equation, not its characteristic-five
birational identities. beta_m[u,v]=[x^(m*v-u)]f^(m-1). The positive Frobenius
product convention is checked against independently saved actual Prym Cartier.
No factor verdict is inferred merely from a matching mod-five polynomial.
"""
import sys
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parents[2]))
import argparse,time,json,hashlib
from pathlib import Path
from sage.all import GF,ZZ,Zq,Zmod,PolynomialRing,matrix,identity_matrix
from cysignals.alarm import alarm,cancel_alarm,AlarmInterrupt
from scripts.arithmetic.sieve_fixed_x_carriers import load_json,save_json
from scripts.atlases.opers.fixed_x_monomial_jacobian import FixedXMonomialJacobian
from scripts.arithmetic.fixed_x_prym_cartier import TrigonalArithmetic,cutoff


def multiply(a,b):
    out={}
    for (i,j),c in a.items():
        for (k,l),d in b.items():
            key=(i+k,j+l);out[key]=out.get(key,0)+c*d
    return {e:c for e,c in out.items() if c}


def power(a,n,one):
    out={(0,0):one}
    for _ in range(n):out=multiply(out,a)
    return out


class WittFrobenius:
    """Native polynomial modular composition of the TRUE lifted generator.

    q-adic element.frobenius(arg) takes a BOOLEAN, not an iterate number.
    This wrapper supplies arbitrary iterates and verifies the field order.
    """
    def __init__(self,O,modulus,digits,degree):
        self.O=O;self.degree=degree
        self.P=PolynomialRing(Zmod(5**digits),'v',implementation='FLINT')
        self.modulus=self.P(modulus)
        self.images={0:self.P.gen(),1:self.P(O.gen().frobenius()._flint_rep())}
        assert self.image(degree)==self.P.gen()
        test=O.gen()+2*O.gen()**3+5*O.gen()**7
        assert self(test,1)==test.frobenius()
        assert self(self(test,-1),1)==test

    def image(self,n):
        if n not in self.images:
            h=n//2;a=self.image(h);v=a.compose_mod(a,self.modulus)
            if n%2:v=v.compose_mod(self.images[1],self.modulus)
            self.images[n]=v
        return self.images[n]

    def __call__(self,c,n=1):
        result=self.P(c._flint_rep()).compose_mod(self.image(n%self.degree),self.modulus)
        return self.O(list(map(int,result.list())))


WITT_FROBENIUS={}


def frob_matrix(M,n):
    R=M.base_ring();phi=WITT_FROBENIUS.get(R)
    return matrix(R,M.nrows(),M.ncols(),
                  [phi(c,n) if phi else c.frobenius(n) for c in M.list()])


def positive_norm(M,n):
    if not n:return identity_matrix(M.base_ring(),M.nrows())
    if n==1:return M
    h=n//2;N=positive_norm(M,h);out=N*frob_matrix(N,h)
    return out*frob_matrix(M,2*h) if n%2 else out


def inverse_unit_matrix(M):
    R=M.base_ring();n=M.nrows();rows=[list(M[i])+list(identity_matrix(R,n)[i]) for i in range(n)]
    for j in range(n):
        pivot=next(i for i in range(j,n) if rows[i][j].is_unit())
        rows[j],rows[pivot]=rows[pivot],rows[j]
        inv=rows[j][j].inverse_of_unit();rows[j]=[inv*c for c in rows[j]]
        for i in range(n):
            if i==j:continue
            c=rows[i][j]
            if c:rows[i]=[a-c*b for a,b in zip(rows[i],rows[j])]
    ans=matrix(R,[r[n:] for r in rows]);assert M*ans==1 and ans*M==1
    return ans


def extract_beta(poly,m,points,R):
    return matrix(R,[[poly.get((m*v[0]-u[0],m*v[1]-u[1]),R.zero())
                      for v in points] for u in points])


def verify_kummer_twist(data,model_path,cartier_path,k):
    """Verify (P+Qy)*g = scalar*v^2; retain finite-field quadratic twist."""
    source=load_json(data['field_source']);J=FixedXMonomialJacobian(k,k(source['a']))
    ar=TrigonalArithmetic(J);wd=load_json(data['matrix_source'])
    w=matrix(k,wd['rows'],wd['columns'],[k(c) for c in wd['coefficients']])
    vv=cutoff(w,J.bases[3],19);assert vv.nrows()==1
    v=ar.row(vv[0],J.bases[3]);v2=ar.multiply(v,v)
    norm=load_json(model_path.parent/'norm.json.gz')
    P=ar.R([k(c) for c in norm['P']]);Q=ar.R([k(c) for c in norm['Q']])
    old=load_json(cartier_path.parent/'cartier_witness.json.gz')
    g=[ar.R([k(c) for c in z]) for z in old['trivialization']]
    product=ar.multiply([P,Q,ar.R.zero()],g)
    i=next(i for i in range(3) if v2[i]);j=v2[i].degree()
    scalar=product[i][j]/v2[i][j]
    assert scalar and all(a==scalar*b for a,b in zip(product,v2))
    sign=1 if scalar.is_square() else -1
    return sign,list(map(int,scalar.polynomial().list()))


def main():
    p=argparse.ArgumentParser(description=__doc__)
    p.add_argument('model',type=Path);p.add_argument('cartier_result',type=Path)
    p.add_argument('out',type=Path);p.add_argument('--digits',type=int,choices=[1,2],default=1)
    p.add_argument('--lift-variant',type=int,default=0,
                   help='Independent support-preserving5-adic coefficient-lift audit')
    p.add_argument('--seconds',type=int,default=300)
    args=p.parse_args();args.out.mkdir(exist_ok=True);start=time.monotonic();events=[]
    def report(stage,**kw):
        event=dict(stage=stage,seconds=time.monotonic()-start,**kw);events.append(event)
        print(json.dumps(event),flush=True);save_json(args.out/'progress.json',events)
    alarm(args.seconds)
    try:
        data=load_json(args.model);d=data['field_degree'];diag=data['diagnostics']
        assert data['exact_birational_substitution'] and diag['interior_count']==8
        assert diag['all_edges_transverse']
        k=GF(5**d,'b',modulus=PolynomialRing(GF(5),'v')(data['modulus']),impl='pari_ffelt')
        points=[tuple(v) for v in diag['interior_points']]
        f={tuple(e):k(c) for e,c in data['coefficients']}
        f4=power(f,4,k.one());beta5=extract_beta(f4,5,points,k)
        assert beta5.is_invertible()
        N=positive_norm(beta5,d);poly=N.charpoly('T')
        assert all(c**5==c for c in poly)
        coeff=[int(c.polynomial()[0]) for c in poly]
        expected=load_json(args.cartier_result)['coefficients']
        sign,scale=verify_kummer_twist(data,args.model,args.cartier_result,k)
        expected=[c*(sign**i)%5 for i,c in enumerate(expected)]
        assert coeff==expected,(coeff,expected)
        report('independent_toric_beta5_matches_actual_prym_cartier',coefficients=coeff,
               f4_terms=len(f4),rank=int(beta5.rank()),verified_quadratic_twist=sign)
        save_json(args.out/'kummer_twist.json',dict(sign=sign,scalar=scale,
            actual_function_identity='(P+Qy)*g = scalar*v^2',verified=True))
        if args.digits==1:return
        setup=time.monotonic()
        O=Zq(5**d,prec=2,type='fixed-mod',names='b',
             modulus=PolynomialRing(ZZ,'v')(data['modulus']),implementation='FLINT')
        lift=lambda c:O(list(map(int,c.polynomial().list())))
        residue=lambda c:k([int(a)%5 for a in c._flint_rep().list()])
        ff={e:lift(c)+5*args.lift_variant*(j+1)*O.gen()
            for j,(e,c) in enumerate(f.items())}
        phi=WittFrobenius(O,data['modulus'],2,d);WITT_FROBENIUS[O]=phi
        b=O.gen();assert phi(b,d)==b
        assert residue(phi(b))==k.gen()**5
        assert O(PolynomialRing(ZZ,'v')(data['modulus'])(phi(b)))==0
        report('true_witt_frobenius_setup',setup_seconds=time.monotonic()-setup,
               naive_fifth_power_is_frobenius=bool(b**5==phi(b)))
        f4w=power(ff,4,O.one());f5w=multiply(f4w,ff)
        f_sigma={e:phi(c) for e,c in ff.items()}
        for (i,j),c in f_sigma.items():
            e=(5*i,5*j);f5w[e]=f5w.get(e,O.zero())-c
        # f^5 = sigma(f)(x^5)+5G. Only G modulo5 is needed below.
        G={}
        for e,c in f5w.items():
            assert c.valuation()>=1
            g=residue(c>>1)
            if g:G[e]=g
        correction=multiply(f4,G)
        f3=power(f,3,k.one())
        f3s={e:c.frobenius() for e,c in f3.items()}
        f4s={e:phi(c) for e,c in f4w.items()}
        report('two_digit_ghost_polynomials',G_terms=len(G),correction_terms=len(correction))
        # f^24=f^4*(sigma(f)(x^5)+5G)^4
        #      =f^4*sigma(f^4)(x^5)+20*f^4*G*sigma(f^3)(x^5) mod25.
        rows=[]
        for u in points:
            row=[]
            for v in points:
                target=(25*v[0]-u[0],25*v[1]-u[1]);value=O.zero();carry=k.zero()
                for (i,j),c in f4s.items():
                    value+=c*f4w.get((target[0]-5*i,target[1]-5*j),O.zero())
                for (i,j),c in f3s.items():
                    carry+=c*correction.get((target[0]-5*i,target[1]-5*j),k.zero())
                row.append(value+20*lift(carry))
            rows.append(row)
        beta25=matrix(O,rows);beta5w=extract_beta(f4w,5,points,O)
        U=beta25*inverse_unit_matrix(frob_matrix(beta5w,1))
        assert matrix(k,8,8,[residue(c) for c in U.list()])==beta5
        report('two_digit_unit_root_matrix_ready')
        encode=lambda c:list(map(int,c._flint_rep().list()))
        save_json(args.out/'matrices.json.gz',dict(beta5=[encode(c) for c in beta5w.list()],
            beta25=[encode(c) for c in beta25.list()],unit_matrix=[encode(c) for c in U.list()],
            field_modulus=data['modulus'],digits=2,dimension=8))
        N2=positive_norm(U,d);pol2=N2.charpoly('T')
        assert all(phi(c)==c for c in pol2)
        coeff2=[]
        for c in pol2:
            a=encode(c);assert all(z==0 for z in a[1:]);coeff2.append(a[0] if a else 0)
        assert [c%5 for c in coeff2]==coeff
        result=dict(status='complete',digits=2,field_degree=d,coefficients=coeff2,
            lift_variant=args.lift_variant,
            model=str(args.model.resolve()),model_sha256=hashlib.sha256(args.model.read_bytes()).hexdigest(),
            actual_cartier_mod5_match=True,verified_quadratic_twist=sign,seconds=time.monotonic()-start,
            scope='Actual toric carrier unit-root characteristic polynomial modulo25; factor test separate')
        save_json(args.out/'result.json',result);report('two_digit_unit_root_polynomial',
            coefficients=coeff2,verified_quadratic_twist=sign)
    except AlarmInterrupt:report('time_limit_no_higher_precision_verdict')
    finally:cancel_alarm()


if __name__=='__main__':main()
