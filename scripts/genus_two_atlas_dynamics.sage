#!/usr/bin/env sage
"""Exact 33-point atlas export; no Groebner-basis computation is used.

Verify saved original-ideal linear certificates, reduce to a Frobenius
map of P1, and substitute the entire 33-dimensional solution algebra
back into all13 original equations.
"""
import json
from pathlib import Path

root=Path(__file__).resolve().parents[1]
data=root/'Research/computations'
k=GF(25,name='a',modulus=PolynomialRing(GF(5),'z')([2,4,1])); a=k.gen()
get=lambda s:k(sage_eval(s,locals={'a':a}))
d=json.loads((data/'genus_two_intrinsic_tensor.json').read_text())
R=PolynomialRing(k,names=['p0','p1','p2','p3','b0','b1','b2','b3'])
pp=R.gens()[:4]; bb=R.gens()[4:]
eq=[sum(get(d['I'][h][j])*bb[j] for j in range(4))+
    sum(get(d['tensor_plus_Jinverse_alpha5_p'][i][j][h])*pp[i]*bb[j]**5
        for i in range(4) for j in range(4)) for h in range(12)]
eq.append(sum(get(d['ell'][i][j])*pp[i]*bb[j]
              for i in range(4) for j in range(4))-1)
loc=dict(zip(R.variable_names(),R.gens())); loc['a']=a
parse=lambda s:R(sage_eval(s,locals=loc))
certified=[]
for stem in ['genus_two_linear_certificates','genus_two_p_linear_certificates']:
    c=json.loads((data/(stem+'.json')).read_text())
    entries=c.get('linear_consequences',c)
    for target,entry in entries.items():
        if 'lift' not in entry: continue
        lifts=[parse(s) for s in entry['lift']]
        assert len(lifts)==13
        assert sum(h*f for h,f in zip(lifts,eq))==parse(target)
        certified.append(parse(target))
assert len(certified)==4

S=PolynomialRing(k,'s,t,x,y'); s,t,x,y=S.gens()
values=[-(2*a+1)*t,a*s-t,s,t,
        -(2*a+1)*x+(2*a+2)*y,-(2*a+1)*x+(2*a+1)*y,x,y]
restrict=R.hom(values,S)
assert all(restrict(f)==0 for f in certified)
reduced=[restrict(f) for f in eq]
A=x**5+(a+2)*y**5
B=(-2*a+2)*x**5+(-a-1)*y**5
N=s*A+t*B
fx=-s*x**5+(-2*a-2)*t*x**5+(2*a+1)*s*y**5+(2*a-1)*t*y**5+x
fy=(-a-1)*s*x**5-2*a*t*x**5-2*s*y**5+(2*a-2)*t*y**5+y
base=[N,fx,fy]
mons=sorted(set(m for f in reduced[:12]+base for m in f.monomials()),reverse=True)
coeff=lambda f:vector(k,[f.monomial_coefficient(m) for m in mons])
Mb=matrix(k,[coeff(f) for f in base])
Mr=matrix(k,[coeff(f) for f in reduced[:12]])
assert Mb.rank()==Mr.rank()==3
assert Mb.row_space()==Mr.row_space()
ell=(-a-1)*s*x+(2*a-1)*t*x+(-2*a-1)*s*y-a*t*y
assert reduced[12]==ell-1

T=PolynomialRing(k,'x,y'); x,y=T.gens()
A=x**5+(a+2)*y**5; B=(-2*a+2)*x**5+(-a-1)*y**5
Q1=a*x**10-2*x**5*y**5+y**10
Q2=(a+1)*x**10+(-a+2)*x**5*y**5+2*a*y**10
E=-2*a*(x**5*y+x*y**5+y**6)
sub=S.hom([B,-A,x,y],T)
assert sub(fx)==x-Q1 and sub(fy)==y-Q2 and sub(ell)==E
assert gcd(Q1,Q2)==1
F=x*Q2-y*Q1
assert F.derivative(x)==Q2 and F.derivative(y)==-Q1
assert gcd(F,E)==1 and F(1,0)!=0

U=PolynomialRing(k,'z'); z=U.gen()
f=U(F(z,1)).monic(); e=U(E(z,1)); q2=U(Q2(z,1))
assert f.degree()==11 and gcd(f,f.derivative())==1
assert gcd(f,e)==gcd(f,q2)==1
q2inv=q2.inverse_mod(f); h=(e*q2inv)%f
assert gcd(f,h)==1
K=U.fraction_field()
phi=((a+1)*K(z)+3*a+4)/(K(z)+a+4)
dynamical_map=K(Q1(z,1))/q2
assert phi(dynamical_map)==phi**10

# The full solution algebra is a free rank3 algebra over the reduced
# degree11 base. lambda^3=h is etale since h is a unit and3!=0.
U0=U.quotient(f,names='xx'); xx=U0.gen()
PL=PolynomialRing(U0,'lam'); lam=PL.gen()
Sol=PL.quotient(lam**3-U0(h),names='ll'); ll=Sol.gen()
x0=Sol(xx); c0=Sol(U0(q2inv))
li=ll**2*Sol(U0(h.inverse_mod(f)))
assert ll*li==1
s0=c0*((-2*a+2)*x0**5+(-a-1))
t0=-c0*(x0**5+a+2)
sv=li**4*s0; tv=li**4*t0; xv=ll*x0; yv=ll
sol_values=[-(2*a+1)*tv,a*sv-tv,sv,tv,
            -(2*a+1)*xv+(2*a+2)*yv,
            -(2*a+1)*xv+(2*a+1)*yv,xv,yv]
evaluate=R.hom(sol_values,Sol)
assert all(evaluate(f)==0 for f in eq)

factors=[]; orbit_counts={}
for fac,mult in f.factor():
    assert mult==1
    deg=int(fac.degree()); Rf=U.quotient(fac,names='r')
    cube=Rf(h)**((25**deg-1)//3)==1
    residue=int(deg if cube else 3*deg)
    count=int(3 if cube else 1)
    orbit_counts[residue]=int(orbit_counts.get(residue,0)+count)
    factors.append({'polynomial':str(fac),'degree':deg,
                    'normalizing_scalar_is_cube_in_residue_field':bool(cube),
                    'normalized_closed_point_degree':residue,
                    'normalized_closed_point_count':count})
assert sum(deg*count for deg,count in orbit_counts.items())==33
out={'field':'F5[a]/(a^2+4a+2)',
     'basis':'genus_two_intrinsic_tensor.json, variables p0..p3,b0..b3',
     'all_four_original_ideal_certificates_verified':True,
     'all_twelve_equations_span_exact_three_after_linear_restriction':True,
     'projective_degree11_polynomial':str(f),
     'normalization_lambda_cubed':str(h),
     'coordinate_z_is_b2_over_b3':True,
     'all_original_equations_verified_in_full_solution_algebra':True,
     'solution_encoding':'For every root z of f and every lambda^3=h(z), use the formulas in Sol_genus_two_atlas_dynamics.md. Each choice is one distinct solution.',
     'all_geometric_multiplicities':int(1),
     'distinct_geometric_solutions':int(33),
     'projective_directions':int(11),
     'factors':factors,'normalized_F25_closed_point_counts':orbit_counts,
     'frobenius_dynamics_conjugacy':str(phi),
     'conjugate_map':'w -> w^10; fixed w=0,infinity, or w^9=1',
     'status':'Exact full export and reconstruction, no unverified Groebner claim; no Litt3 exclusion.'}
(data/'genus_two_intrinsic_solutions.json').write_text(json.dumps(out,indent=2)+'\n')
print(json.dumps(out,indent=2),flush=True)
