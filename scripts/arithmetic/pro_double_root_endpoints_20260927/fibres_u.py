"""Complete geometric fibres over u in F25*, with unrestricted q and scale.
Uses the actual fraction-free residual.  A fibre certificate is an identity
in K[q, tau]/(g(q,u)), localized only at the original open conditions.
"""
import json,gzip,struct,time,sys,hashlib,subprocess
from exact import ROOT,DATA,add,mul,power,pa,ps,pm,pc,pp,pd,pgcd,pder,prem,inv
from extension import E,Poly,init
from residual import square_equations


def fibre_modulus(u0):
    m=pa(pa(pc(DATA['b'],mul(u0,u0)),pc(DATA['c'],mul(2,u0))),pc(DATA['e'],3))
    m=pc(m,inv(m[-1]));original=m[:]
    xi=pa(pc(DATA['b'],u0),DATA['c'])
    F=pa(pa(pc(DATA['a0'],power(u0,3)),pc(DATA['b'],power(u0,2))),pa(pc(DATA['c'],u0),DATA['e']))
    factors=[[0,1],DATA['d'],xi,F]+[[ps([0],[v])[0],1] for v in DATA['excluded_q']]
    # Compute the saturation by the original open product, retaining the entire
    # primary components on the open (including any surviving nilpotents).
    removed=[]
    for fac in factors:
        while True:
            d=pgcd(m,fac)
            if len(d)==1:break
            m,r=pd(m,d);assert not r;removed.append(d)
    return original,m,removed


def load_sample(u0,rebuild=False):
    path=ROOT/'work/global_samples'/f'{u0}.bin.gz'
    if rebuild:
        from global_residual import sample
        sample(u0)
    if path.exists():return gzip.open(path,'rb').read()
    # The global coefficient file was certified against every source fibre in
    # the interpolation set. This fast path requires no regenerable cache.
    from interpolate_global import library
    import ctypes as ct
    raw=gzip.open(ROOT/'evidence/global_residual.bin.gz','rb').read()
    flat=struct.unpack('<%dI'%(len(raw)//4),raw);m=7*141*9
    out=(ct.c_int*m)();library().ff_evaluate_rows((ct.c_int*len(flat))(*flat),133,m,u0,out)
    return struct.pack('<%dI'%m,*out)


def run(u0,verify=False,rebuild=False):
    assert 1<=u0<=24
    start=time.time();original,mod,removed=fibre_modulus(u0)
    raw=load_sample(u0,rebuild)
    init(mod);D=len(mod)-1
    data=struct.unpack('<%dI'%(len(raw)//4),raw)
    R=[]
    for a in range(7):
        R.append(Poly([E(prem(list(data[(a*141+i)*9:(a*141+i+1)*9]),mod)) for i in range(141)]))
    assert R[0].degree()==140 and R[0][140].inv()
    tails=square_equations(R,False)
    try:g,S,T=tails[0].xgcd(tails[1])
    except AssertionError:
        raise RuntimeError('a scale-pivot is a nonunit; split the quotient algebra before claiming this fibre')
    assert S*tails[0]+T*tails[1]==g
    out={'u_code':u0,'modulus_original':original,'modulus_on_original_open':mod,
         'removed_primary_factors':removed,'coefficient_ring':'K[q]/(modulus_on_original_open)',
         'scale_variable':'tau=q^3*d(q)*mu','residual':'R_tilde',
         'geometric_ratio_count':D-(len(pgcd(mod,pder(mod)))-1),
         'algebra_length':D,'square_tail_degrees':[p.degree() for p in tails],
         'residual_digest':hashlib.sha256(json.dumps([p.records() for p in R],separators=(',',':')).encode()).hexdigest()}
    if g==1:
        out.update(status='excluded_all_geometric_scales',tails=[p.records() for p in tails],bezout=[S.records(),T.records()])
    else:
        eq=square_equations(R,True)
        coefs=[Poly(1)]+[Poly() for _ in range(69)];G=eq[0]
        for j in range(1,70):
            gg,a,b=G.xgcd(eq[j]);coefs=[v*a for v in coefs];coefs[j]=coefs[j]+b;G=gg
            if G==1:break
        assert sum((a*b for a,b in zip(coefs,eq)),Poly())==G
        if G==1:out.update(status='excluded_all_geometric_scales',full_tails=[p.records() for p in eq],full_bezout=[p.records() for p in coefs])
        else:out.update(status='unresolved',common_scale_polynomial=G.records())
    p=ROOT/'evidence'/f'fibre_u_{u0}.json'
    if verify:assert out==json.loads(p.read_text())
    else:p.write_text(json.dumps(out,separators=(',',':'))+'\n')
    print('U FIBRE',u0,'length',D,'geometric points',out['geometric_ratio_count'],out['status'],round(time.time()-start,3),'seconds',flush=True)
    return out

if __name__=='__main__':
    if len(sys.argv)>1 and sys.argv[1]!='all':run(int(sys.argv[1]),'--verify' in sys.argv,'--rebuild' in sys.argv)
    else:
        for u0 in range(1,25):
            subprocess.run([sys.executable,__file__,str(u0)]+(['--verify'] if '--verify' in sys.argv else [])+(['--rebuild'] if '--rebuild' in sys.argv else []),check=True)
