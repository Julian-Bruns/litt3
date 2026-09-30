"""Independent format, support, factorization and leading-coefficient checks.
The complete Bezout identities are separately checked by the GMP programs.
"""
from pathlib import Path
import gzip,hashlib,importlib.util,json
ROOT=Path(__file__).resolve().parents[2]
spec=importlib.util.spec_from_file_location('independent_field',ROOT/'src/verify_evidence.py')
k=importlib.util.module_from_spec(spec);spec.loader.exec_module(k)
def read(p): return json.loads(gzip.decompress(p.read_bytes()) if p.suffix=='.gz' else p.read_bytes())
def rem(a,m):return k.pr(a,m)[1]
def power(a,n,m):
    b=[1]
    while n:
        if n&1:b=rem(k.pm(b,a),m)
        n//=2
        if n:a=rem(k.pm(a,a),m)
    return b
a0=[89654,311173,214299,163299,315361,33043,356725,245794]
factors=[[372885,1],[219733,262411,63559,1],[288706,229183,188479,1]]
assert k.sc(k.pm(k.pm(factors[0],factors[1]),factors[2]),245794)==a0
for i in range(3):
    for j in range(i):assert k.pgcd(factors[i],factors[j])==[1]
for f in factors[1:]:assert k.pgcd(f,k.ps(power([0,1],390625,f),[0,1]))==[1]
assert k.pw(196636,3)==115265 and k.pe(a0,115265)==0
cw=k.mul(2,k.div(k.pw(359499,24),k.pw(299619,6)))
for name,idx in [('q115265',None),('a0_cubic0',0),('a0_cubic1',1)]:
    d=ROOT/'decision/evidence'/name
    for rec in read(d/'hashes.json'):
        z=(d/(rec['name']+'.gz')).read_bytes();b=gzip.decompress(z)
        assert hashlib.sha256(z).hexdigest()==rec['compressed_sha256']
        assert len(b)==rec['bytes'] and hashlib.sha256(b).hexdigest()==rec['sha256']
    zero=0 if idx is None else [0,0,0]
    def check(c):
        cs=[c] if idx is None else c
        assert len(cs)==(1 if idx is None else 3)
        assert all(type(v) is int and 0<=v<390625 for v in cs)
    inp=read(d/('fiber_input.json.gz' if idx is None else 'input.json.gz'))
    seen=set();lead=[]
    for h,m,t,c in inp['terms']:
        check(c);assert c!=zero and 0<=h<=36 and 0<=m<=6 and 0<=t<=140
        assert (h,m,t) not in seen;seen.add((h,m,t))
        if t==0:lead.append((h,m,c))
    if idx is None:
        a1=k.mul(115265,k.add(299833,k.mul(232505,115265)))
        f6=k.div(k.mul(a1,196636),k.mul(115265,k.pw(299619,2)))
        lc=k.pw(k.mul(3,k.mul(k.pw(359499,8),f6)),3)
        assert lead==[(12,0,lc)] and inp['w']==196636 and inp['q']==115265
    else:
        mod=factors[idx+1]
        assert inp['modulus_ascending_K_codes']==mod
        a1=rem(k.pm([0,1],[299833,232505]),mod);assert a1
        lc=rem(k.sc(k.pm(power([0,1],42,mod),power(a1,3,mod)),cw),mod)
        lc+= [0]*(3-len(lc));assert lead==[(12,0,lc)]
    tailfile=d/('tails_71_73.jsonl.gz' if idx is None else 'tails.jsonl.gz')
    stats={m:[0,-1,-1,-1] for m in [71,72,73]};seen=set()
    with gzip.open(tailfile,'rt') as f:
        for line in f:
            m,h,l,c=json.loads(line);check(c);assert c!=zero and m in stats and h>=0 and l>=0
            assert (m,h,l) not in seen;seen.add((m,h,l))
            s=stats[m];s[0]+=1;s[1]=max(s[1],h);s[2]=max(s[2],l);s[3]=max(s[3],h+5*l)
    assert list(stats.values())==[[8366,313,47,328],[8581,316,47,331],[8797,320,48,336]]
    res=read(d/'resultants.json.gz');cert=read(d/'gcd_certificate.json.gz')
    assert res['h_degree_bounds' if idx is None else 'H_degree_bounds']==[19928,20256]
    vals=cert['h_valuations' if idx is None else 'H_valuations'];assert vals==[2024,2087]
    for j,(a,v) in enumerate(zip(res['polynomials'],vals)):
        assert len(a)-1==[19315,19622][j] and a[-1]!=zero and a[v]!=zero and all(c==zero for c in a[:v])
        for c in a:check(c)
    for a in cert['multipliers']:
        assert a and a[-1]!=zero
        for c in a:check(c)
    assert cert['gcd']==([1] if idx is None else [[1,0,0]])
    print('PASS:',name,': hashes, exact coefficient conventions, leading identity, all supports and weighted resultant bounds.')
print('PASS: pairwise-coprime factorization, cubic irreducibility, and coverage of all seven a0 roots.')
print('These integrity checks supplement, not replace, full resultant reconstruction and independent Bezout identity checks.')
