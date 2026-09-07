#!/usr/bin/env sage
"""Two exact projective-line comparisons of H and cup determinant loci."""
from pathlib import Path
source=Path('scripts/wronskian_trace_linearization.sage').read_text()
marker='Hs=[traceH('
assert source.count(marker)==1
exec(preparse(source.split(marker)[0]))
trace=json.loads(Path('Research/computations/wronskian_trace_linearization.json').read_text())
Hs=[mat(M) for M in trace['H_tensor']]
Ks=[fifth(cup(Bc.column(h))) for h in range(32)]
Z=PolynomialRing(k,'z'); zz=Z.gen()
def detline(M0,M1):
    n=M0.nrows()
    if M0.det():
        cp=M0.solve_right(M1).charpoly()
        p=M0.det()*Z([(-1)**i*cp[n-i] for i in range(n+1)])
    else:p=(M0.change_ring(Z)+zz*M1.change_ring(Z)).det()
    assert p[0]==M0.det() and p[n]==M1.det()
    return p
def combo(Ms,g):return sum((c*M for c,M in zip(g,Ms)),zero_matrix(k,Ms[0].nrows()))
def fact(q):return [{'degree':f.degree(),'multiplicity':m,'factor':enc(f.list())} for f,m in q.factor()]
out={'scope':'Two exact determinant-locus comparisons only; no atlas or oper exclusion','parameter':'gamma(z)=gamma0+z gamma1, gamma=beta^[5] over algebraic closure','lines':[]}
for seed in range(202609111,202609113):
    rng=random.Random(seed)
    gammas=[vector(k,[k(rng.randrange(5))+a*rng.randrange(5) for _ in range(32)]) for _ in range(2)]
    H0,H1=[combo(Hs,g) for g in gammas]; K0,K1=[combo(Ks,g) for g in gammas]
    hd=detline(H0,H1); kd=detline(K0,K1); gd=gcd(hd,kd)
    hf=fact(hd); kf=fact(kd)
    print('line',seed,'degrees',hd.degree(),kd.degree(),'gcddegree',gd.degree(),'Hfactors',[(f['degree'],f['multiplicity']) for f in hf],'Kfactors',[(f['degree'],f['multiplicity']) for f in kf],flush=True)
    out['lines'].append({'seed':seed,'gamma0':enc(gammas[0]),'gamma1':enc(gammas[1]),'det_H':enc(hd.list()),'det_K':enc(kd.list()),'H_affine_degree':hd.degree(),'K_affine_degree':kd.degree(),'H_infinity_multiplicity':32-hd.degree(),'K_infinity_multiplicity':24-kd.degree(),'H_infinity_rank':H1.rank(),'K_infinity_rank':K1.rank(),'gcd':enc(gd.list()),'gcd_degree':gd.degree(),'H_factors':hf,'K_factors':kf,'H_divides_K':bool(kd%hd==0),'K_divides_H':bool(hd%kd==0),'proportional':bool(hd.degree()==kd.degree() and hd*kd.leading_coefficient()==kd*hd.leading_coefficient())})
out['elapsed_seconds']=time.monotonic()-started
Path('Research/computations/wronskian_polar_determinant_lines.json').write_text(json.dumps(out,indent=2,default=int)+'\n')
