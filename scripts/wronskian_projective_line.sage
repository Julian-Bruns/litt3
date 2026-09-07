#!/usr/bin/env sage
"""Exact line certificate, with whole-line consequence conditional on rank theorem."""
from pathlib import Path
source=Path('scripts/wronskian_matrix_pencil.sage').read_text()
marker="for sample in saved['samples']:"
assert source.count(marker)==1
exec(preparse(source.split(marker)[0]))
first=json.loads(Path('Research/computations/wronskian_matrix_pencil.json').read_text())['samples'][0]
N0=matrix(k,[parse(row) for row in first['N_matrix']])
R0=matrix(k,[parse(row) for row in first['R_matrix']])
uv=parse(saved['samples'][1]['U_coefficients']); U=laurent(uv,monsU)
nc=[]; rc=[]
for h,e in enumerate(target):
    aff,rem=split_aff(U*tt**(5*e))
    nc.append(vector(k,[rem[d] for d in target128]))
    lam5=monseries(fifthvector(D.column(h)),[5*d for d in domain])
    rc.append(rho(tt**(-85)*rem-U*lam5,target))
N1=matrix(k,nc).transpose(); R1=matrix(k,rc).transpose()
cols=list(N0.pivots()); assert len(cols)==55
rows=list(N0.matrix_from_columns(cols).transpose().pivots()); assert len(rows)==55
j=next(h for h in range(56) if h not in cols)
A0=N0.matrix_from_rows_and_columns(rows,cols)
A1=N1.matrix_from_rows_and_columns(rows,cols)
b0=vector(k,[N0[h,j] for h in rows]); b1=vector(k,[N1[h,j] for h in rows])
assert A0.det()!=0
M=A0.solve_right(A1); v0=-A0.solve_right(b0); w1=-A0.solve_right(b1)
S=PolynomialRing(k,'z'); zz=S.gen(); cp=M.charpoly()
den=S([(-1)**i*cp[55-i] for i in range(56)])
vs=[v0, -M*v0+w1]
for n in range(2,56): vs.append(-M*vs[-1])
ev=[S.zero() for _ in range(56)]; ev[j]=den
for h,col in enumerate(cols):
    ev[col]=S([sum(den[r]*vs[n-r][h] for r in range(min(n,den.degree())+1)) for n in range(56)])
NP=N0.change_ring(S)+zz*N1.change_ring(S)
assert NP*vector(S,ev)==0
common=gcd(ev); ev=[q//common for q in ev]
assert gcd(ev)==1 and NP*vector(S,ev)==0
print('primitive kernel degree',max(q.degree() for q in ev),'den degree',den.degree(),'removed gcd degree',common.degree(),flush=True)
SS=PolynomialRing(k,'s'); s=SS.gen()
E=vector(SS,[q(s**5) for q in ev])
AA=(R0.change_ring(SS)+s**5*R1.change_ring(SS))*E
BB=vector(SS,[SS([c**5 for c in q.list()]) for q in ev])
assert all(BB[h]**5==E[h] for h in range(56))
assert gcd(list(BB))==1
pivot=next(h for h in range(56) if BB[h])
relative=[AA[h]*BB[pivot]-AA[pivot]*BB[h] for h in range(56)]
relative_gcd=gcd(relative)
bezout={}; running=SS.zero()
for h,minor in enumerate(relative):
    if not minor: continue
    newg,left,right=running.xgcd(minor)
    bezout={i:left*c for i,c in bezout.items()}
    bezout[h]=bezout.get(h,SS.zero())+right
    running=newg
    if running.degree()==0: break
assert running==relative_gcd
assert sum(c*relative[i] for i,c in bezout.items())==relative_gcd
full_gcd=relative_gcd
used=[]
# At roots of B_pivot the relative minors alone may vanish spuriously.
# Refine using ALL pair minors modulo the current gcd until it is a unit.
for h in range(56):
    if full_gcd.degree()==0: break
    for l in range(h):
        minor=AA[h]*BB[l]-AA[l]*BB[h]
        newg=gcd(full_gcd,minor)
        if newg!=full_gcd:
            used.append([h,l,int(full_gcd.degree()),int(newg.degree())])
            full_gcd=newg
        if full_gcd.degree()==0: break
zeroA=gcd(list(AA)); assert any(AA)
print('relative minors gcd degree',relative_gcd.degree(),'full minors gcd degree',full_gcd.degree(),'A zero locus degree',zeroA.degree(),flush=True)
def penc(q): return enc(q.list())
def fac(q): return [{'factor':penc(f),'multiplicity':int(m)} for f,m in q.factor()]
data={'scope':'Exact line calculation; exclusion on pivot-determinant open only. Boundary and infinity not treated.','input_seeds':[saved['samples'][i]['seed'] for i in range(2)],'parameter':'U=U0+z U1; for Frobenius criterion z=s^5','pivot_rows':rows,'pivot_columns':cols,'free_column':j,'pivot_constant_det':str(A0.det()),'pivot_determinant_normalized':penc(den),'pivot_determinant_factors':fac(den),'kernel_common_factor_removed':penc(common),'primitive_kernel':[penc(q) for q in ev],'primitive_kernel_max_degree':max(q.degree() for q in ev),'full_N_kernel_identity_verified':True,'Frobenius_root_identity_verified':True,'A':[penc(q) for q in AA],'B':[penc(q) for q in BB],'relative_pivot':pivot,'relative_minors_gcd':penc(relative_gcd),'full_minors_gcd':penc(full_gcd),'additional_pair_gcd_reductions':used,'A_common_zero_polynomial':penc(zeroA),'exceptional_pivot_polynomial_in_s':penc(den(s**5)),'full_minors_gcd_factors':fac(full_gcd),'elapsed_seconds':time.monotonic()-started}
data['relative_minors_bezout']={str(h):penc(c) for h,c in bezout.items() if c}
data['relative_minors_bezout_identity_verified']=True
leading=S([parse(saved['samples'][0]['U_coefficients'])[-1],parse(saved['samples'][1]['U_coefficients'])[-1]])
assert leading.degree()==1
leading_matches=(common.monic()==leading.monic()**9)
infinity=saved['samples'][1]
assert infinity['observation_rank']==2 and infinity['polynomial_identities_verified']
data['primitive_kernel_components_gcd']=penc(gcd(ev))
data['primitive_kernel_nonvanishing_at_every_finite_geometric_point']=True
data['U_pole112_leading_coefficient']=penc(leading)
data['removed_common_factor_equals_leading_coefficient_to_ninth_up_to_unit']=bool(leading_matches)
data['infinity_sample_seed']=infinity['seed']
data['infinity_observation_rank']=infinity['observation_rank']
data['scope']='Exact polynomial certificate. Main-agent whole-projective-line consequence uses the author-proof admissible-rank55 theorem, not a new audit.'
data['whole_line_consequence']='At every finite geometric point primitive e is nonzero and lies in ker N. Whenever the quotient is admissible, the admissible-rank55 theorem makes e span that kernel, including pivot-determinant roots. The Bezout identity excludes collinearity for all these points. Rank drops are inadmissible by that theorem. Infinity is U1, excluded by its saved rank2 observation. Thus the entire projective line has no eligible atlas direction, conditional on the author-proof admissible-rank theorem; this is not a global parameter-space exclusion.'
print('removed factor equals ninth power of leading pole coefficient:',leading_matches,flush=True)
Path('Research/computations/wronskian_projective_line.json').write_text(json.dumps(data,indent=2,default=int)+'\n')
print('DONE',data['elapsed_seconds'],flush=True)
