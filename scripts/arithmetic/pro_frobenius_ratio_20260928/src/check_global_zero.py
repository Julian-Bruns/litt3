"""Independent replay of the whole-curve model and compact zero-scale certificate.

The 625 values reconstruct a polynomial under a proved degree bound: they
are not a search for rational points.  The zero-scale identity is verified
by polynomial multiplication and exact division, without invoking half-GCD
or the factorization routine that found it.  No global square decision is
claimed.
"""
import argparse, hashlib, json, time
from pathlib import Path
from concurrent.futures import ProcessPoolExecutor, as_completed
import numpy as np
from ff import Poly,add,mul,power,GENERATOR
from global_curve import QC,ssquare,smul
from global_model import one,load_interp,N,WIDTH
from residual import RATIO
from reconstruct import epsilon
from global_units import known_q_units
ROOT=Path(__file__).resolve().parents[1]


def degree_proof_check():
    data=json.loads((ROOT/'data/source_cramer.json').read_text())
    maxima=[];terms=0
    for gi in data['G_numerators']:
        weights=[]
        for j,row in enumerate(gi):
            for termlist in row:
                for (ha,wb,ka,kb),cf in termlist:
                    assert ka==kb==0 and 0<=ha<=2 and cf
                    k=wb-2*ha+j-1;assert k%3==0
                    qp=k//3+1;assert qp>=0 and 2+qp-j>=0
                    # Three times wt(z^ha b^(2-ha) q^(2+qp-j) Y^j).
                    wt3=21*ha+15*(2-ha)+3*(2+qp-j)+2*j
                    assert wt3<=52;weights.append(wt3);terms+=1
        maxima.append(max(weights))
    # wt_3(t_scaled)=41; wt_3(v_scaled)=42; wt_3(Q)=0.
    # The compact resultant has bounds 624,614,604 before taking the norm.
    return {'source_terms_checked':terms,'three_times_source_weight_maxima':maxima,
            'three_times_resultant_weight_bounds':[624,614,604],
            'q_degree_bound':624,'z_coefficient_q_degree_bound':617}


def generate_model(workers=4):
    spec=json.loads((ROOT/'data/global_model_spec.json').read_text())
    assert spec['coset_offset']==25 and spec['number_of_nodes']==625
    gen=power(GENERATOR,626)
    ns=[add(25,x) for x in [0]+[power(gen,i) for i in range(624)]]
    assert len(set(ns))==625 and all(power(x,625)==x for x in [0]+[power(gen,i) for i in range(624)])
    at={q:i for i,q in enumerate(ns)};vals=np.empty((N,WIDTH),dtype=np.uint32)
    with ProcessPoolExecutor(max_workers=workers) as pool:
        futures=[pool.submit(one,n) for n in ns]
        for count,f in enumerate(as_completed(futures),1):
            qv,v=f.result();vals[at[qv]]=v
            if count%125==0:print('WHOLE_CURVE_SOURCE_EVALUATIONS',count,'of',625,flush=True)
    nn=np.array(ns,dtype=np.uint32);out=np.zeros_like(vals);ll=load_interp()
    assert ll.ff_interpolate_batch(nn,vals.ravel(),N,WIDTH,out.ravel())==1
    coeff=out.reshape((N,2,141,7)).transpose(1,2,3,0).copy()
    assert not coeff[1,:,:,618:].any()
    # Recheck all interpolation equalities; uniqueness follows from the degree proof.
    buf=np.empty(WIDTH,dtype=np.uint32)
    for i,qv in enumerate(ns):
        ll.ff_eval_batch(out.ravel(),N,WIDTH,qv,buf);assert np.array_equal(buf,vals[i])
    for qv in spec['additional_check_nodes']:
        _,v=one(qv);ll.ff_eval_batch(out.ravel(),N,WIDTH,qv,buf);assert np.array_equal(v,buf)
    digest=hashlib.sha256(np.asarray(coeff,dtype='<u4').tobytes(order='C')).hexdigest()
    assert digest==spec['canonical_coefficients_sha256']
    return coeff,{'nodes':625,'additional_nodes':spec['additional_check_nodes'],'coefficient_sha256':digest}


def factored_poly(data,fs):
    assert 0<data['scalar']<390625 and len(data['exponents'])==len(fs)
    p=Poly(data['scalar'])
    for f,e in zip(fs,data['exponents']):
        assert isinstance(e,int) and e>=0
        if e:p=p*f**e
    return p


def verify_zero(g):
    t=time.time();cert=json.loads((ROOT/'data/zero_scale_compact.json').read_text())
    assert cert['status']=='global zero-scale square locus excluded on old proved open'
    old=known_q_units();fs=[Poly(f) for f in cert['unit_factors']]
    # Irreducibility is unnecessary: every factor is explicitly a divisor of a proved unit.
    for f in fs:assert f.degree()>0 and f[f.degree()]==1 and not old%f
    ic=factored_poly(cert['input_content'],fs);assert ic==Poly([0]*48+[1])
    assert not g[:,:,0,:48].any(), 'q^48 must divide every scale-zero coefficient'
    aa=[QC(g[0,n,0],g[1,n,0])//ic for n in range(74)]
    a0,b,c,e,d=[Poly(RATIO[k]) for k in ('a0','b','c','e','d')]
    q=Poly([0,1]);z=QC(0,1)
    jv=z**3*a0+z**2*(b*b)+z*(c*b*b)+QC(e*b**3)
    leading=(z**9)*(jv**3)*(b**54*q**36*d**33)*mul(2,power(epsilon,24))
    assert aa[0]==leading
    # leading = 2 eps^24 b^54 q^36 d^33 z^9 (b^3 V)^3 is an original/proved unit.
    a2=ssquare(aa,74);a3=smul(aa,a2,74)
    p5=[a.frob() for a in a2[:15]];p25=[a.frob(2) for a in a2[:3]]
    norms=[];summ=[];primitives={}
    for n in (71,72):
        val=QC()
        for j in range(n//25+1):
            inner=QC()
            for i in range((n-25*j)//5+1):inner=inner+a3[n-25*j-5*i]*p5[i]
            val=val+inner*p25[j]
        dta=cert['tails'][str(n)];content=factored_poly(dta['content'],fs)
        p=val//content;assert list(p.degrees())==dta['primitive_degrees'];primitives[n]=p
        unit=factored_poly(dta['norm_unit'],fs)
        nn=p.norm()//unit;assert nn.degree()==dta['normalized_norm_degree'] and nn[nn.degree()]==1
        norms.append(nn)
        summ.append({'tail':n,'raw_degrees':list(val.degrees()),'content_degree':content.degree(),
                     'primitive_degrees':list(p.degrees()),'norm_unit_degree':unit.degree(),
                     'normalized_norm_degree':nn.degree()})
        print('GLOBAL_ZERO_TAIL_REPLAYED',n,'normalized norm degree',nn.degree(),flush=True)
    bz=cert['bezout'];assert bz['indices']==[71,72]
    U,V=Poly(bz['U']),Poly(bz['V']);assert U*norms[0]+V*norms[1]==1
    print('GLOBAL_ZERO_NORM_BEZOUT_VERIFIED',flush=True)
    from reciprocal_model import checks
    regress=checks(primitives,cert)
    print('RECIPROCAL_MONIC_REGRESSIONS_VERIFIED',len(regress),flush=True)
    return {'status':'exact global zero-scale identity verified; nonzero-scale decision remains open',
            'unit_divisors':len(fs),'tails':summ,'reciprocal_model_regressions':regress,'bezout_degrees':[U.degree(),V.degree()],
            'seconds':round(time.time()-t,3),'half_gcd_or_factorization_used_by_this_verifier':False}


def run(workers=4,cache=None,reuse=False,save=False):
    t=time.time();degree=degree_proof_check()
    if reuse:
        assert cache is not None and Path(cache).is_file()
        g=np.load(cache)['coefficients'];spec=json.loads((ROOT/'data/global_model_spec.json').read_text())
        assert hashlib.sha256(np.asarray(g,dtype='<u4').tobytes(order='C')).hexdigest()==spec['canonical_coefficients_sha256']
        model={'status':'explicitly requested hash-checked cache reuse; source interpolation not replayed in this command'}
    else:
        g,model=generate_model(workers)
        if cache:
            Path(cache).parent.mkdir(parents=True,exist_ok=True);np.savez_compressed(cache,coefficients=g)
    zero=verify_zero(g)
    result={'status':'passed; requested global square decision unresolved','degree_proof':degree,
            'model_verification':model,'zero_scale_verification':zero,'seconds':round(time.time()-t,3)}
    if save:(ROOT/'checks/global_zero_verification.json').write_text(json.dumps(result,indent=2)+'\n')
    print('GLOBAL_ZERO_VERIFICATION_SUMMARY_JSON='+json.dumps(result,sort_keys=True),flush=True)
    return result

if __name__=='__main__':
    ap=argparse.ArgumentParser();ap.add_argument('--workers',type=int,default=4);ap.add_argument('--cache',default=str(ROOT/'data/global_residual.npz'))
    ap.add_argument('--reuse-model',action='store_true');ap.add_argument('--save-summary',action='store_true');args=ap.parse_args()
    run(args.workers,args.cache,args.reuse_model,args.save_summary)
