"""Port the audited scalar coefficient engine to the unramified degree-eight ring.

The new generator h has h^2=t; its polynomial is f(h^2). Only coefficient
arithmetic and input embeddings change. Original geometry sources are copied.
"""
import sys
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parents[3]))
import argparse
import json
from pathlib import Path
import shutil
import tempfile

from scripts.deformations.rank25 import rank25_pro_data_model as field


def replace(text, old, new, count=None):
    found=text.count(old)
    assert found and (count is None or found==count),(old,found,count)
    return text.replace(old,new)


def main():
    p=argparse.ArgumentParser(description=__doc__)
    p.add_argument('destination',type=Path)
    args=p.parse_args();dest=args.destination
    source=Path('/Users/julian/Documents/litt3-computation-data/rank25-two-family-returns-20260912-rpDDk0/geometry')
    assert not dest.exists();dest.mkdir()
    shutil.copytree(source/'reconstruction',dest/'reconstruction',ignore=shutil.ignore_patterns('__pycache__'))
    shutil.copytree(source/'supplied',dest/'supplied')
    rec=dest/'reconstruction'
    text=(rec/'witt.py').read_text()
    text=replace(text,'Q=np.array([3,4,1,4,1],dtype=np.int64)',
        'DEG=8\nQ=np.array([3,0,4,0,1,0,4,0,1],dtype=np.int64)')
    start=text.index('def ca(x):');end=text.index('def cm(a,b):')
    text=text[:start]+'''def ca(x):
 if isinstance(x,(int,np.integer)):
  a=np.zeros(DEG,dtype=np.int64);a[0]=int(x)%MOD;return a
 x=np.array(x,dtype=np.int64).ravel();a=np.zeros(DEG,dtype=np.int64)
 if len(x)<=4:a[0:2*len(x):2]=x
 else:
  assert len(x)==DEG,x.shape
  a[:]=x
 return a%MOD
ONE=ca(1);T=ca([0,1]);ZERO=ca(0)
GEN=np.zeros(DEG,dtype=np.int64);GEN[1]=1
def embed_field_tensor(x):
 a=np.asarray(x,dtype=np.int64)
 if a.shape[-1]==DEG:return a
 assert a.shape[-1]==4,a.shape
 out=np.zeros(a.shape[:-1]+(DEG,),dtype=np.int64);out[...,::2]=a
 return out
''' + text[end:]
    for a,b in [('range(6,3,-1)','range(2*DEG-2,DEG-1,-1)'),
                ('range(4)','range(DEG)'),('i-4+j','i-DEG+j'),('c[:4]','c[:DEG]'),
                ('cp(a,623)','cp(a,5**DEG-2)'),('reshape(4,1)','reshape(DEG,1)'),
                ('np.zeros((4,','np.zeros((DEG,'),('np.zeros((7,','np.zeros((2*DEG-1,'),
                ('np.zeros((nc,4)','np.zeros((nc,DEG)')]:
        text=replace(text,a,b)
    text=replace(text,'SIGT=cp(T,5)','SIGGEN=cp(GEN,5)')
    text=replace(text,'cp(SIGT,','cp(SIGGEN,')
    text=replace(text,'range(5)),start=ca(0))','range(DEG+1)),start=ca(0))')
    text=replace(text,'range(1,5)),start=ca(0))','range(1,DEG+1)),start=ca(0))')
    text=replace(text,'SIGT=(SIGT-cdiv(qq,dq))%MOD','SIGGEN=(SIGGEN-cdiv(qq,dq))%MOD')
    text=replace(text,'SIGMAT=np.array([cp(SIGGEN,i) for i in range(DEG)]).T',
        'SIGMAT=np.array([cp(SIGGEN,i) for i in range(DEG)]).T\nSIGT=SIGMAT@T%MOD\nassert np.array_equal(SIGT,ca([122,1363,2775,2385])%MOD)')
    text=replace(text,'for j in range(DEG):c[i+j]+=exact_conv(a[i],b[j])',
        'for j in range(DEG):\n   if np.any(a[i]) and np.any(b[j]):c[i+j]+=exact_conv(a[i],b[j])')
    # Avoid silently treating a four-component tensor as eight coefficients.
    text=replace(text,'A=np.asarray(A,dtype=np.int64)%5;b=np.asarray(b,dtype=np.int64)%5',
        'A=embed_field_tensor(A)%5;b=embed_field_tensor(b)%5')
    (rec/'witt.py').write_text(text)
    text=(rec/'base_setup.py').read_text().replace('reshape(4,1)','reshape(DEG,1)')
    text=replace(text,'cp(c,125)%5','cp(c,5**(DEG-1))%5')
    text=replace(text,'np.array([[2,4,1,3],[3,3,0,1],[4,0,0,3]],dtype=np.int64)',
        'embed_field_tensor([[2,4,1,3],[3,3,0,1],[4,0,0,3]])')
    (rec/'base_setup.py').write_text(text)
    text=(rec/'as25.py').read_text()
    text=replace(text,"HH=[[ca(x) for x in row] for row in DATA['additive_matrix']]",
        "for key in ['additive_matrix','primary_repair','kernel_basis','hodge_matrix','obstruction_dual_rows']:\n DATA[key]=embed_field_tensor(DATA[key]).tolist()\nDATA['affine_Q_coefficients']=[embed_field_tensor(q).tolist() for q in DATA['affine_Q_coefficients']]\nHH=[[ca(x) for x in row] for row in DATA['additive_matrix']]")
    for a,b in [('range(4)','range(DEG)'),('(5,9,7,nz)','(5,9,2*DEG-1,nz)'),
                (':4,',':DEG,'),('*7+3)','*(2*DEG-1)+DEG-1)'),
                ('9*9*7*nz','9*9*(2*DEG-1)*nz'),('(9,9,7,nz)','(9,9,2*DEG-1,nz)'),
                ('range(6,3,-1)','range(2*DEG-2,DEG-1,-1)'),('i-4+j','i-DEG+j'),
                ('(25,4,take)','(25,DEG,take)')]:text=replace(text,a,b)
    (rec/'as25.py').write_text(text)
    text=(rec/'compute_next.py').read_text()
    text=replace(text,"PARAMETERS=np.array(json.loads(Path(args.third_parameters).read_text())['x'],dtype=np.int64)%5",
        "PARAMETERS=embed_field_tensor(json.loads(Path(args.third_parameters).read_text())['x'])%5")
    text=replace(text,'PARAMETERS.shape==(9,4)','PARAMETERS.shape==(9,DEG)')
    text=replace(text,'cp(c,125)%5','cp(c,5**(DEG-1))%5')
    text=replace(text,'SIGT.tolist()==[122,1363,2775,2385]',
        'np.array_equal(SIGT,ca([122,1363,2775,2385]))')
    (rec/'compute_next.py').write_text(text)
    # Quadratic roots in k0[h], h^2=t; t is nonsquare (its norm is3).
    assert field.power((0,1,0,0),312)==(4,0,0,0)
    factors=[[10,236,1],[10,544,1]]
    def digits(n):return tuple((n//5**i)%5 for i in range(4))
    def join(a,b):return [v for pair in zip(a,b) for v in pair]
    def emul(x,y):
        a,b=tuple(x[::2]),tuple(x[1::2]);c,d=tuple(y[::2]),tuple(y[1::2])
        return join(field.add(field.mul(a,c),field.mul((0,1,0,0),field.mul(b,d))),
                    field.add(field.mul(a,d),field.mul(b,c)))
    def epow(x,n):
        if n<0:return epow(epow(x,5**8-2),-n)
        r=join(field.ONE,field.ZERO)
        while n:
            if n&1:r=emul(r,x)
            x=emul(x,x);n//=2
        return r
    def eadd(x,y):return [(a+b)%5 for a,b in zip(x,y)]
    def emb(x):return join(x,field.ZERO)
    roots=[]
    for c0,c1,_ in factors:
        b,c=digits(c1),digits(c0)
        delta=field.add(field.mul(b,b),field.neg(field.mul((4,0,0,0),c)))
        quot=field.mul(delta,field.power((0,1,0,0),623))
        sq=next(digits(i) for i in range(625) if field.mul(digits(i),digits(i))==quot)
        lam=join(field.mul((2,0,0,0),b),field.mul((3,0,0,0),sq))
        assert eadd(eadd(emul(lam,lam),emul(emb(b),lam)),emb(c))==[0]*8
        q=epow(lam,5)
        x=[eadd(emb((2,1,3,0)),epow(q,-2)),emul(emb((4,3,3,1)),q),
           emul(emb((2,2,3,4)),q),emb((3,0,0,3)),emb((0,3,1,4)),
           emul(emb((3,1,1,2)),q),q,[0]*8,[0]*8]
        roots.append({'factor': [c0,c1,1],'lambda':lam,'x':x})
    for i,point in enumerate(roots):
        run=dest/f'quadratic_{i}';run.mkdir();(run/'parameters.json').write_text(json.dumps(point,indent=2)+'\n')
    baseline=dest/'basefield_regression';baseline.mkdir()
    oldroot=Path('/Users/julian/Documents/litt3-computation-data/rank25-one-parameter-returned-20260912-hsze3x/root_plus/parameters.json')
    shutil.copy2(oldroot,baseline/'parameters.json')
    receipt={'coefficient_polynomial':[3,0,4,0,1,0,4,0,1],
             'embedding':'t=h^2; eight coefficients in powers of h',
             'quadratic_points':roots,'source':str(source),'destination':str(dest),
             'status':'arithmetic preparation only; full geometry must replay'}
    (dest/'preparation.json').write_text(json.dumps(receipt,indent=2)+'\n')
    print(json.dumps(receipt,indent=2))


if __name__=='__main__':main()
