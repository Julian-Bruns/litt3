#!/usr/bin/env sage
"""Exact scalar residual Frobenius ranks for two invariant F25 opers.

This samples both Frobenius blocks, not the inhomogeneous obstruction.
All arithmetic is exact; no conclusions about actual covers are drawn.
"""
import json, random, time, sys
from pathlib import Path

started = time.monotonic()
k = GF(25, name='a', modulus=PolynomialRing(GF(5), 'z')([2,4,1]))
a = k.gen()
R = PolynomialRing(k, 'x')
x = R.gen()
F = (x**10+(4*a+2)*x**9+(a+4)*x**8+(3*a+1)*x**7+3*a*x**6
     +4*a*x**5+(3*a+4)*x**4+a*x**3+(3*a+3)*x**2+(4*a+2)*x+2*a+1)
Fp = F.derivative()

def basis(bound):
    return sorted([(i,j) for j in range(3) for i in range(bound//3+1)
                   if 3*i+10*j <= bound], key=lambda ij: 3*ij[0]+10*ij[1])

def delta(v):
    ans = [R.zero() for _ in range(3)]
    for j,f in enumerate(v):
        ans[(j+2)%3] += f.derivative()*F**((j+2)//3)
        if j:
            ans[j-1] += 2*j*f*Fp
    return tuple(ans)

def times_P(v,B):
    ans = [R.zero() for _ in range(3)]
    for j,f in enumerate(v):
        ans[(j+1)%3] += f*(B+2*x**8)*F**((j+1)//3)
    return tuple(ans)

if '--verify-reduced-only' in sys.argv:
    destination=Path('Research/computations/scalar_residual_rank.json')
    saved=json.loads(destination.read_text())
    Q=PolynomialRing(k,names=['xx','yy'])
    qx,qy=Q.gens()
    def parse(c):
        return k(sage_eval(c,locals={'a':a}))
    for oper in saved['opers']:
        sample=next(s for s in oper['samples'] if s['rank']==31)
        km=matrix(k,[[parse(c) for c in row] for row in oper['kernel_basis']])
        uv=vector(k,[parse(c) for c in sample['kernel_coordinates']])*km
        polys=[R.zero() for _ in range(3)]
        for c,(i,j) in zip(uv,saved['monomial_basis_L112']):
            polys[j]+=c*x**i
        U=sum(polys[j](qx)*qy**j for j in range(3))
        dU=sum(f(qx)*qy**j for j,f in enumerate(delta(polys)))
        affine=Q.ideal([qy**3-F(qx),U,dU])
        unit=affine.groebner_basis()==[Q.one()]
        infinity_order=112-sample['U_pole_order']
        sample['reduced_zero_check']={
            'affine_ideal_generators':'y^3-F, U, delta(U)',
            'affine_groebner_basis':[str(g) for g in affine.groebner_basis()],
            'affine_ideal_is_unit':bool(unit),
            'theta7_U_order_at_O':int(infinity_order),
            'global_zero_divisor_reduced':bool(unit and infinity_order in [0,1])}
        print('orbit',oper['orbit_id'],'seed',sample['seed'],
              'affine_unit',unit,'order_at_O',infinity_order,flush=True)
    destination.write_text(json.dumps(saved,indent=2,default=int)+'\n')
    sys.exit(int(0))

mons = basis(112)
assert len(mons)==104
gaps = [1,2,4,5,7,8,11,14,17]
domain = [-g for g in gaps]+list(range(1,32))
target = [-g for g in gaps]+list(range(1,48))
assert len(domain)==40 and len(target)==56

# z=1/x satisfies z=t^3 Ftilde(z); Newton in exact truncated series.
# Precision400 leaves more than48 terms after max pole214 reductions.
precision = 400
PS = PowerSeriesRing(k,'t',default_prec=precision)
t = PS.gen()
Ft = R(list(reversed(F.list())))
z = t**3+O(t**precision)
for iteration in range(10):
    z -= (z-t**3*Ft(z))/(1-t**3*Ft.derivative()(z))
assert (z-t**3*Ft(z)).valuation() >= precision
LS = LaurentSeriesRing(k,'t',default_prec=precision)
tt = LS.gen()
xx = 1/LS(z)
yy = xx**3/tt
assert (yy**3-F(xx)).valuation() >= 48
expansions = {(i,j):xx**i*yy**j for i,j in basis(214)}
reducers = {3*i+10*j:expansions[i,j] for i,j in basis(214)}
assert all(v[-p]==1 and v.precision_absolute()>48 for p,v in reducers.items())
delta_t=yy**2/xx.derivative()
assert delta_t.valuation()==-16 and delta_t[-16]==3

def remainder(s):
    assert s.precision_absolute()>48
    for p in sorted(reducers, reverse=True):
        c = s[-p]
        if c:
            s -= c*reducers[p]
    assert all(s[-p]==0 for p in reducers)
    return s

def rho48(s):
    s=remainder(s)
    return vector(k,[s[e] for e in target])

def rho32(s):
    s=remainder(s)
    return vector(k,[s[e] for e in domain])

derivative_graph=matrix(k,[rho32(-delta_t*(tt**e).derivative())
                          for e in target]).transpose()
assert derivative_graph.dimensions()==(40,56)

data = json.loads(Path('Research/computations/invariant_oper_solutions.json').read_text())
results = {'field':'F_5[a]/(a^2+4*a+2)',
    'source':'invariant_oper_solutions.json: first two F25 rows',
    'equation':'delta^2 U=(B+2*x^8)*y*U; delta x=y^2, delta y=2Fprime',
    'domain_exponents':domain,'target_exponents':target,
    'matrix_shape':[56,40], 'precision':precision,
    'reduction':'Subtract x^i*y^j with j<3 in descending nongap pole order through214, including constant; retain negative gaps and t^1..t^47.',
    'differential_graph_map':[[str(c) for c in row] for row in derivative_graph.rows()],
    'graph_convention':'Dbar=-rho32 delta on P48; upper Frobenius block equals Dbar times lower block.',
    'monomial_basis_L112':mons,
    'kernel_basis_convention':'Rows of Sage right_kernel().basis_matrix() in ascending pole monomial basis',
    'random_convention':'Python random.Random(seed), coefficient randrange(5)+a*randrange(5)',
    'structural_prediction':'rank<=31; any observed equality certifies the sampled lower block reaches the predicted bound only',
    'opers':[]}
for row in data['solutions'][:2]:
    assert data['orbits'][row['orbit_id']]['degree']==1
    B=R([sage_eval(c,locals={'a':a}) for c in row['coordinates'][:8]])
    images=[]
    for i,j in mons:
        v=tuple(x**i if h==j else R.zero() for h in range(3))
        images.append(tuple(f-g for f,g in zip(delta(delta(v)),times_P(v,B))))
    degree=max(f.degree() for im in images for f in im)
    mat=matrix(k, [[im[j][i] for im in images] for j in range(3) for i in range(degree+1)])
    ker=mat.right_kernel().basis_matrix()
    assert ker.nrows()==32 and mat*ker.transpose()==0
    # Persist an exact kernel basis so every random U is directly recoverable.
    item={'orbit_id':row['orbit_id'],'B_coefficients':row['coordinates'][:8],
          'kernel_dimension':int(ker.nrows()),
          'kernel_basis':[[str(c) for c in v] for v in ker.rows()], 'samples':[]}
    for seed in range(202609060,202609068):
        rng=random.Random(seed)
        coeff=vector(k,[k(rng.randrange(5))+a*rng.randrange(5) for _ in range(32)])
        uv=coeff*ker
        U=sum((c*expansions[ij] for c,ij in zip(uv,mons)),LS.zero())
        columns=[rho48(U*tt**(5*e)) for e in domain]
        M=matrix(k,columns).transpose()
        upper_columns=[]
        dU=delta_t*U.derivative()
        for e in domain:
            zz=U*tt**(5*e)
            first=rho32(-dU*tt**(5*e))
            first[domain.index(31)]-=remainder(zz)[48]
            upper_columns.append(first)
        upper=matrix(k,upper_columns).transpose()
        assert upper==derivative_graph*M
        rank=int(M.rank())
        item['samples'].append({'seed':seed,'kernel_coordinates':[str(c) for c in coeff],
                                'U_pole_order':int(-U.valuation()),'rank':rank,
                                'full_matrix_graph_identity_verified':True})
        print('orbit',row['orbit_id'],'seed',seed,'rank',rank,flush=True)
    results['opers'].append(item)
results['elapsed_seconds']=time.monotonic()-started
results['all_observed_ranks']=sorted(set(s['rank'] for o in results['opers'] for s in o['samples']))
Path('Research/computations/scalar_residual_rank.json').write_text(json.dumps(results,indent=2,default=int)+'\n')
print('DONE ranks',results['all_observed_ranks'],flush=True)
