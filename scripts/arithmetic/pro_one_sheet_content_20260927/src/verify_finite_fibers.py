"""Independent Python ideal-reduction checks for complete exceptional fibres.
Tail values are regenerated from Ehat by finite_fibers.cpp; this verifier
independently verifies saturation coverage, opens, coordinates and unit identities.
"""
from integral_chart import *
import argparse,glob

def read_certificate(path):
    lines=iter(Path(path).read_text().splitlines()); head=next(lines).split()
    meta={'r':int(head[1]),'factor':int(head[3]),'branch':int(head[5])}
    assert next(lines)=='v_modulus'
    bits=list(map(int,next(lines).split()));assert bits[0]==len(bits)-1
    meta['vf']=bits[1:]; fields={};status=None
    for line in lines:
        words=line.split()
        if not words:continue
        if words[0] in ['PASS','empty_allowed_fiber','excluded_base']:
            status=words;break
        n=int(words[1]);p=[]
        for _ in range(n):
            row=list(map(int,next(lines).split()));assert row[0]==len(row)-1;p.append(row[1:])
        fields[words[0]]=p
    assert status is not None, 'Incomplete certificate'
    return meta,fields,status

def check(path):
    meta,z,status=read_certificate(path);vf=meta['vf'];r=meta['r'];branch=meta['branch']
    def br(a):return ur(a,vf)
    def bm(a,b):return br(um(a,b))
    def bi(a):
        g,u,v=uxg(a,vf);assert g==[1];return br(u)
    def st(a):
        a=list(a)
        while a and not a[-1]:a.pop()
        return a
    def sa(a,b):
        a=a+[[] for _ in range(max(0,len(b)-len(a)))];return st([ua(c,b[i] if i<len(b) else []) for i,c in enumerate(a)])
    def ss(a,b):return sa(a,[un(p) for p in b])
    def sc(a,b):return st([bm(p,b) for p in a])
    def sm(a,b):
        if not a or not b:return []
        c=[[] for _ in range(len(a)+len(b)-1)]
        for i,u in enumerate(a):
            for j,v in enumerate(b):c[i+j]=ua(c[i+j],bm(u,v))
        return st(c)
    def sr(a,b):
        a=st(a);assert b;iv=bi(b[-1])
        while len(a)>=len(b):
            s=len(a)-len(b);c=bm(a[-1],iv)
            for j,p in enumerate(b):a[s+j]=us(a[s+j],bm(c,p))
            a=st(a)
        return a
    def sp(a,n,f):
        b=[[1]]
        while n:
            if n&1:b=sr(sm(a,b),f)
            n//=2
            if n:a=sr(sm(a,a),f)
        return b
    def convert(rows):
        ans=[]
        for i,j,c in rows:
            while len(ans)<=j:ans.append([])
            ans[j]=ua(ans[j],br([0]*i+[c]))
        return st(ans)
    ch=next(c for c in json.loads((ROOT/'data'/'integral_charts.json').read_text()) if c['r']==r)
    ep=next(e for e in json.loads((ROOT/'data'/'endpoint_curves.json').read_text())['endpoints'] if e['r']==r)
    ja=next(j for j in json.loads((ROOT/'data'/'J_algebras.json').read_text()) if j['r']==r)
    initial=convert(ch['F']);assert initial==z['initial_S_modulus']
    v=br([0,1]);beta=convert(ch['beta']);delta=convert(dumps(pshift(loads(ep['Delta']),(8,0))));J=[br(ja['v_modulus'])];J=st(J)
    if status[0]=='excluded_base' and status[1]!='q_open':
        value={'v':[v] if v else [],'beta':beta,'delta':delta,'J':J}[status[1]]
        assert not value
        return dict(meta,status='base_excluded',reason=status[1])
    q=uc(bi(bm(bm(v,v),v)),ep['P_r']);a0=[]
    for c in reversed([89654,311173,214299,163299,315361,33043,356725,245794]):a0=ua(bm(a0,q),[c])
    a1=bm(q,ua([299833],uc(q,232505)))
    if status[0]=='excluded_base':
        assert not a0 or not us(q,[1]) or not us(q,[15383])
        return dict(meta,status='base_excluded',reason='q_open')
    hn=convert(ch['H_numerator']);hd=convert(ch['H_denominator'])
    mn=convert(ch['branches'][branch]['numerator']);md=convert(ch['branches'][branch]['denominator'])
    psi=sa(sc(hd,a0),sc(hn,a1));op=[[1]]
    for p in [hn,hd,psi,mn,md]:op=sr(sm(op,p),initial)
    assert op==z['open_polynomial']
    sf=z['allowed_S_modulus'];removed=z['removed_S_factor'];assert sm(sf,removed)==initial
    if len(removed)>1:assert not sp(op,6,removed)
    if status[0]=='empty_allowed_fiber':assert sf==[[1]];return dict(meta,status='allowed_empty')
    assert sr(sm(op,z['open_inverse']),sf)==[[1]]
    assert sr(ss(sm(hd,z['H']),hn),sf)==[]
    assert z['q']==[q]
    assert sr(ss(sm(md,z['mu']),mn),sf)==[]
    assert sr(sm(z['raw_leading'],z['raw_leading_inverse']),sf)==[[1]]
    assert sr(sa(sm(z['C71'],z['U']),sm(z['C72'],z['V'])),sf)==[[1]]
    return dict(meta,status='unit_identity_verified',dimension=(len(vf)-1)*(len(sf)-1),C71_alone_is_unit=not z['V'])

def main():
    ap=argparse.ArgumentParser();ap.add_argument('pattern');ap.add_argument('--summary',default=None);a=ap.parse_args()
    files=sorted(glob.glob(a.pattern));assert files
    records=[]
    for path in files:
        x=check(path);x.pop('vf');records.append(x);print(Path(path).name,x,flush=True)
    if a.summary:Path(a.summary).write_text(json.dumps({'status':'PASS','independent_verifier':'Python polynomial reduction','certificates':records},indent=2)+'\n')
if __name__=='__main__':main()
