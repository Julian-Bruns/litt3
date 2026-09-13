#!/usr/bin/env python3
"""Exact anti-invariant Cartier matrix of an ACTUAL fixed-X etale double.

Input is a verified Khuri--Makdisi two-torsion matrix, not a free norm
ansatz.  The output alone is not a geometric isogeny-factor exclusion.
For div(g)=2D-20O the anti-forms are h*(dx/y^2)/sqrt(g),
h in L(26O-D). Cartier sends h to C_X(g^2 h theta)/theta.
"""
import sys
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parents[2]))
import argparse
import json
import time
from pathlib import Path
from sage.all import GF, PolynomialRing, FunctionField, matrix, identity_matrix
from cysignals.alarm import alarm, cancel_alarm, AlarmInterrupt
from scripts.atlases.opers.fixed_x_monomial_jacobian import FixedXMonomialJacobian, FROBENIUS_COEFFICIENTS


def pole_basis(bound):
    return sorted(((i,j) for j in range(3) for i in range((bound-10*j)//3+1)),
                  key=lambda ij:3*ij[0]+10*ij[1])


def cutoff(w,basis,bound):
    high=[j for j,(i,k) in enumerate(basis) if 3*i+10*k>bound]
    return w.matrix_from_columns(high).left_kernel_matrix()*w


class TrigonalArithmetic:
    def __init__(self,J):
        self.J=J;self.k=J.k;self.R=J.f.parent();self.F=J.f
        self.F3=self.F**3;self.inverse_frob=self.k.frobenius_endomorphism(-1)

    def row(self,w,basis):
        result=[self.R.zero() for _ in range(3)];x=self.R.gen()
        for (i,j),c in zip(basis,w):
            if c:result[j]+=c*x**i
        return result

    def vector(self,f,basis):
        assert all(3*i+10*j<=max(3*a+10*b for a,b in basis)
                   for j,p in enumerate(f) for i,c in enumerate(p.list()) if c)
        return [f[j][i] for i,j in basis]

    def multiply(self,f,g):
        r=[self.R.zero() for _ in range(5)]
        for i in range(3):
            for j in range(3):r[i+j]+=f[i]*g[j]
        r[0]+=self.F*r[3];r[1]+=self.F*r[4]
        return r[:3]

    def cartier_polynomial(self,p):
        return self.R([self.inverse_frob(p[5*i+4])
                       for i in range(max(0,(p.degree()-4)//5+1))])

    def cartier(self,f):
        return [self.cartier_polynomial(f[1]*self.F3),
                self.cartier_polynomial(f[0]*self.F),
                self.cartier_polynomial(f[2])]


def torsion_trivialization(J,w,report=lambda *a,**k:None):
    """Return g with div(g)=2D-20O and a basis of L(26O-D)."""
    ar=TrigonalArithmetic(J);b3=J.bases[3];b6=J.bases[6]
    rows=[ar.row(row,b3) for row in w]
    products=matrix(J.k,0,len(b6));rank=0
    for f in rows:
        new=matrix(J.k,[ar.vector(ar.multiply(f,g),b6) for g in rows])
        products=products.stack(new).echelon_form();rank=products.rank()
        products=products.matrix_from_rows(range(rank))
        if rank==32:break
    assert rank==32
    gg=cutoff(products,b6,20);assert gg.nrows()==1
    h=cutoff(w,b3,26);assert h.nrows()==8
    report('actual_anti_form_space',dimension=8,product_space_dimension=rank)
    return ar.row(gg[0],b6),h,ar


def matrix_frob(M,power):
    k=M.base_ring();phi=k.frobenius_endomorphism(power)
    return matrix(k,M.nrows(),M.ncols(),[phi(c) for c in M.list()])


def semilinear_norm(M,n):
    """Rows act as v -> phi^-1(v) M. Return its n-fold matrix."""
    if n==0:return identity_matrix(M.base_ring(),M.nrows())
    if n==1:return M
    h=n//2;N=semilinear_norm(M,h)
    result=matrix_frob(N,-h)*N
    return matrix_frob(result,-1)*M if n%2 else result


def backup_factor_sieve(coefficients):
    """Necessary GEOMETRIC factor test, specifically at F5^342.

    The proof is the canonical backup_prym_cartier_factor_sieve theorem.
    A passing divisor is not evidence that an isogeny factor exists.
    """
    R=PolynomialRing(GF(5),'T');T=R.gen();p=R(coefficients)
    filters=[T**2-1,T**4+T**2+1,(T**2+1)**2,
             (T**4+1)**2,(T**4-T**2+1)**2]
    passing=[i for i,f in enumerate(filters) if p%f==0]
    return dict(required_constant_degree=342,filters=[list(map(int,f)) for f in filters],
                passing_filter_indices=passing,geometric_backup_factor_excluded=not passing)


def prym_matrix(J,w,report=lambda *a,**k:None):
    g,h,ar=torsion_trivialization(J,w,report)
    g2=ar.multiply(g,g);out=[];b3=J.bases[3]
    for row in h:
        f=ar.cartier(ar.multiply(g2,ar.row(row,b3)))
        vector=matrix(J.k,1,len(b3),ar.vector(f,b3))[0]
        coordinate=h.transpose().solve_right(vector)
        assert coordinate*h==vector
        out.append(list(coordinate))
    M=matrix(J.k,out);report('actual_cartier_matrix',rank=int(M.rank()))
    return M,g,h


def audit_base(out):
    k=GF(25,'a',modulus=PolynomialRing(GF(5),'z')([2,4,1]),impl='givaro')
    J=FixedXMonomialJacobian(k,k.gen());ar=TrigonalArithmetic(J);basis=pole_basis(16)
    K=FunctionField(k,'x');x=K.gen();R=PolynomialRing(K,'Y')
    E=K.extension(R.gen()**3-K(J.f),'y');y=E.gen();theta=y**(-2)*E(x).differential()
    rows=[]
    for i,j in basis:
        f=[ar.R.zero() for _ in range(3)];f[j]=ar.R.gen()**i
        c=ar.cartier(f)
        exact=(E(x)**i*y**j*theta).cartier()
        predicted=sum(E(p)*y**a for a,p in enumerate(c))*theta
        assert exact==predicted
        rows.append(ar.vector(c,basis))
    M=matrix(k,rows);N=semilinear_norm(M,2)
    assert N==matrix_frob(M,-1)*M
    Z=PolynomialRing(k,'T');T=Z.gen();P=Z(FROBENIUS_COEFFICIENTS)
    assert P==T**9*N.charpoly('T')
    # Fast norm is checked against the direct product beyond one recursion.
    direct=identity_matrix(k,9)
    for n in range(1,14):
        direct=matrix_frob(direct,-1)*M
        assert direct==semilinear_norm(M,n)
    out.write_text(json.dumps(dict(status='PASS',independent_function_field_cartier_forms=9,
        frobenius25_characteristic_polynomial_matches=True,
        fast_semilinear_norm_checked_through=13,cartier_rank=int(M.rank())),indent=2)+'\n')


def main():
    p=argparse.ArgumentParser(description=__doc__)
    p.add_argument('input',type=Path);p.add_argument('out',type=Path)
    p.add_argument('--seconds',type=int,default=300);p.add_argument('--audit-base',action='store_true')
    args=p.parse_args();args.out.mkdir(exist_ok=False);events=[];start=time.monotonic()
    def report(stage,**kw):
        event=dict(stage=stage,seconds=time.monotonic()-start,**kw);events.append(event)
        print(json.dumps(event),flush=True)
        (args.out/'progress.json').write_text(json.dumps(events,indent=2)+'\n')
    alarm(args.seconds)
    try:
        if args.audit_base:
            audit_base(args.out/'base_audit.json');report('independent_base_audit_passed');return
        data=json.loads(args.input.read_text());d=data['field_degree']
        assert data['nonzero'] and data['doubling_zero']
        k=GF(5**d,'a' if d==2 else 'b',modulus=PolynomialRing(GF(5),'z')(data['modulus']),
             impl='givaro' if d==2 else 'pari_ffelt')
        J=FixedXMonomialJacobian(k,k(data['a']));wdata=data['point']
        w=matrix(k,wdata['rows'],wdata['columns'],[k(c) for c in wdata['coefficients']])
        assert J.km.equal(J.km.multiple(w,2),J.zero)
        report('verified_actual_torsion_input')
        M,g,h=prym_matrix(J,w,report)
        # Retain the actual matrix before the potentially slower full norm.
        (args.out/'cartier.json').write_text(json.dumps(dict(field_degree=d,modulus=data['modulus'],
            source=str(args.input.resolve()),matrix=J.serialize(M),
            anti_basis=J.serialize(h),trivialization=[[[int(c) for c in a.polynomial().list()]
            for a in f.list()] for f in g]),indent=2)+'\n')
        N=semilinear_norm(M,d);report('full_coefficient_field_cartier_norm')
        polynomial=N.charpoly('T')
        assert all(c**5==c for c in polynomial)
        coefficients=[int(c.polynomial()[0]) for c in polynomial]
        result=dict(status='complete',
            characteristic=5,constant_degree=d,cartier_rank=int(M.rank()),
            linear_cartier_characteristic_polynomial=coefficients,
            scope='One actual Prym; not all1533 carriers or the complete degree2 row')
        if d==342:result['backup_factor_sieve']=backup_factor_sieve(coefficients)
        (args.out/'result.json').write_text(json.dumps(result,indent=2)+'\n')
        report('complete',coefficients=coefficients,
               factor_sieve=result.get('backup_factor_sieve'))
    except AlarmInterrupt:report('time_limit_no_verdict')
    finally:cancel_alarm()


if __name__=='__main__':main()
