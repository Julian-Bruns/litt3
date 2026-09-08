#!/usr/bin/env sage
"""Four exact Bol rank tests exhaust all 400 nontrivial cubic-twist pairs.

Reuse the already audited atlas field/oper/torsion representatives, not
their equations. Compute on the actual cubic torsor z^3=v-A. The complete
quadratic character basis is z*(1,u,(v+V)/U)*(du/v)^2. A saved 3x3 unit
minor is replayed without rank, kernel, root or Groebner calculations.
"""
import argparse, hashlib, json, time
from pathlib import Path
from cysignals.alarm import alarm, cancel_alarm


def run(args):
    started=time.monotonic(); root=Path(__file__).resolve().parents[1]
    prep=json.loads((root/'Research/computations/backup_genus_two_preparation.json').read_text())['opers']
    tors=json.loads((root/'Research/computations/backup_genus_two_torsion.json').read_text())
    saved=json.loads(Path(args.output).read_text()) if args.verify else None
    rows=[]; alarm(args.seconds)
    try:
      for twist in range(4):
        path=Path(args.data)/('tensor_twist%s_p500.json'%twist)
        raw=path.read_bytes(); data=json.loads(raw)
        prime_poly=PolynomialRing(GF(5),'x')
        k=GF(5**data['field_degree'],name='c',modulus=prime_poly(data['field_modulus']))
        dec=lambda cs:k(prime_poly(cs))
        enc=lambda value:[int(cc) for cc in value.polynomial().list()]
        a=dec(data['alpha']); assert a**3+a+1==0
        R=PolynomialRing(k,'u');u=R.gen();K=R.fraction_field()
        F=u*(u-1)*(u-2)*(u-3)*(u-a)
        b0,b1,b2=[dec(cs) for cs in data['oper_b']]
        dc=lambda cs:sum((k(cc)*a**i for i,cc in enumerate(cs)),k.zero())
        evaluate=lambda cs:sum((dc(cc)*b2**i for i,cc in enumerate(cs)),k.zero())
        assert evaluate(prep['separator_coefficients'])==0
        assert evaluate(prep['b0_coefficients'])==b0 and evaluate(prep['b1_coefficients'])==b1
        pot=K(F.derivative(2))/(4*F)-3*K(F.derivative()**2)/(16*F**2)+(2*u**3+b0+b1*u+b2*u**2)/F
        assert pot.derivative(2)==3*pot**2
        U=R([dec(cc) for cc in data['twist']['U']])
        A=R([dec(cc) for cc in data['twist']['A']])
        V=R([dec(cc) for cc in data['twist']['V']])
        assert U.is_monic() and U.degree()==2 and U.gcd(U.derivative())==U.gcd(F)==1
        assert A%U==V and A**2-F==A[3]**2*U**3
        td=tors['closed_points'][twist]['class_orbit_degree']
        assert td in [8,24] and gcd(td,5)==1
        # The audited census proves the four torsion orbit representatives
        # complete. Replay also checks their actual exact Frobenius periods.
        vals=U.list()+V.list()
        assert all(c**(125**td)==c for c in vals)
        assert all(any(c**(125**(td//ell))!=c for c in vals) for ell in prime_divisors(td))
        assert b2**(125**5)==b2 and b2**125!=b2
        def add(f,g): return (f[0]+g[0],f[1]+g[1])
        def mul(f,g): return (f[0]*g[0]+F*f[1]*g[1],f[0]*g[1]+f[1]*g[0])
        def scale(c,f): return (c*f[0],c*f[1])
        def deriv(f): return (f[0].derivative(),f[1].derivative()+K(F.derivative())*f[1]/(2*F))
        def inv(f):
            norm=f[0]**2-F*f[1]**2; assert norm
            return (f[0]/norm,-f[1]/norm)
        h=(-K(A),K.one())
        ell=add(scale(k(1)/3,mul(deriv(h),inv(h))),(-K(F.derivative())/F,K.zero()))
        rho=add(add(deriv(ell),mul(ell,ell)),(-pot,K.zero()))
        basis=[(K.one(),K.zero()),(K(u),K.zero()),(K(V)/U,K.one()/U)]
        images=[add(add(deriv(deriv(f)),scale(k(2),mul(ell,deriv(f)))),mul(rho,f)) for f in basis]
        denominator=lcm([R(part.denominator()) for image in images for part in image])
        blocks=[[R(denominator*image[j]) for image in images] for j in range(2)]
        degree=max(f.degree() for block in blocks for f in block)
        coefficients=[[block[j][i] for j in range(3)] for block in blocks for i in range(degree+1)]
        if args.verify:
            row=saved['representatives'][twist]
            assert row['twist']==twist and row['tensor_sha256']==hashlib.sha256(raw).hexdigest()
            assert row['joint_orbit_size']==5*td and row['degree_bound']==degree
            selected=row['minor_rows']; assert len(set(selected))==3
            M=matrix(k,[coefficients[i] for i in selected],implementation='generic')
            assert M==matrix(k,[[dec(cc) for cc in line] for line in row['minor']],implementation='generic')
            assert M.det()*dec(row['inverse_determinant'])==1
        else:
            M=matrix(k,coefficients,implementation='generic')
            assert M.rank()==3, ('NONZERO KERNEL',twist,M.right_kernel().basis())
            selected=list(M.transpose().pivots())[:3]; minor=M.matrix_from_rows(selected)
            row={'twist':twist,'tensor_sha256':hashlib.sha256(raw).hexdigest(),
                 'joint_orbit_size':int(5*td),'degree_bound':int(degree),
                 'minor_rows':[int(i) for i in selected],
                 'minor':[[enc(cc) for cc in line] for line in minor.rows()],
                 'inverse_determinant':enc(1/minor.det())}
        rows.append(row)
        print('PASS cubic twist',twist,'pairs',5*td,'seconds',round(time.monotonic()-started,3),flush=True)
      assert sum(row['joint_orbit_size'] for row in rows)==400
      result={'status':'PASS exact original Bol minors for all400 nontrivial cubic oper/twist pairs',
              'representatives':rows,'nontrivial_pairs':400,'elapsed_seconds':time.monotonic()-started,
              'scope':'Endpoint twisted tangent calculation; geometry in Sol_radical_quadratic_atlas_obstruction. No arbitrary common-cover exclusion.'}
      if args.verify:
          print('PASS no-solver replay of all four unit minors',flush=True)
      else:
          Path(args.output).write_text(json.dumps(result,indent=1,default=int)+'\n')
    finally: cancel_alarm()


if __name__=='__main__':
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--data',default='/Users/julian/Documents/litt3-computation-data/backup-genus-two')
    parser.add_argument('--output',default='Research/computations/backup_genus_two_cubic_tangents.json')
    parser.add_argument('--seconds',type=int,default=60)
    parser.add_argument('--verify',action='store_true')
    run(parser.parse_args())
