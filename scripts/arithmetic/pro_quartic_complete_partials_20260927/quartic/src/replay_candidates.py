"""Independent polynomial-arithmetic replay of all 144 linear survivors.

No log tables are used. Each record must have rank four, satisfy all seven
linear equations, and fail the scalar quadric by its recorded nonzero value.
This checks the essential survivors, not the millions of excluded rows.
"""
from pathlib import Path
import gzip,json,sys,time
from exact_fields import Field,F5,embed

root=Path(__file__).resolve().parents[1]
S=Field(F5,[4,4,2,3,3,2,2,1],'Kplus_reference')
KR=Field(S,[S(2),S(4),S(1)],'K_reference')

def c25(n):return KR.row([S(n%5),S(n//5)])
FR=Field(KR,[-c25(20),KR.zero,KR.zero,KR.zero,KR.one],'F_reference')
th=FR.gen
z=KR.row([S.row([2,2,3,2,1,0,2]),S.row([1,2,4,1,3,0,1])])
assert z**29==KR.one
alpha=embed(c25(7),FR)+embed(c25(21),FR)*th**2+4*th**3

def ev(codes,x):
    v=FR.zero
    for c in reversed(codes):v=v*x+embed(c25(c),FR)
    return v
assert ev([5,2,6,7,1],alpha)==FR.zero
assert ev([5,17,12,5],alpha)==th
assert ev([22,7,9,23],alpha)==sum((embed(c25(c),FR)*th**j for j,c in enumerate([20,1,7,19])),FR.zero)
assert ev([1,3,8,15],alpha)==sum((embed(c25(c),FR)*th**j for j,c in enumerate([8,1,15,0])),FR.zero)

zp=[KR.one]
for j in range(1,29):zp.append(zp[-1]*z)
ie=c25(22).inverse();beta=c25(5)
label_cache={}

def label(i,j,name):
    key=i,j,name
    if key not in label_cache:
        cs,m=([20,1,7,19],5) if name=='c' else ([8,1,15,0],8)
        label_cache[key]=FR.row([c25(c)*pow(2,i*k,5)*zp[(m*j)%29]*ie for k,c in enumerate(cs)])
    return label_cache[key]

def endpoint(Q,name):return sum((label(i,j,name) for i,j in Q),FR.zero)
def coords(v):return [x for a in v.c for x in a.c]
def scalar(n):
    ds=[]
    for _ in range(7):ds.append(n%5);n//=5
    assert not n
    return S.row(ds)
def pack(a):return sum(c*5**j for j,c in enumerate(a.c))

def rank(mat):
    # Fraction-free Gaussian elimination. No inversions or log tables.
    a=[row[:] for row in mat];r=0
    for j in range(4):
        p=next((i for i in range(r,len(a)) if a[i][j]),None)
        if p is None:continue
        a[p],a[r]=a[r],a[p];pivot=a[r][j]
        for i in range(r+1,len(a)):
            factor=a[i][j]
            if factor:
                for k in range(j+1,4):a[i][k]=pivot*a[i][k]-factor*a[r][k]
                a[i][j]=S.zero
        r+=1
    return r

start=time.monotonic();records=[]
p=root/'evidence/twist2_full.jsonl'
if p.exists(): records += [json.loads(x) for x in p.read_text().splitlines()]
else:
    with gzip.open(root/'evidence/twist2_full.jsonl.gz','rt') as f:records += [json.loads(x) for x in f]
for p in sorted((root/'evidence').glob('inverse_d*_b*_t*.jsonl.gz')):
    with gzip.open(p,'rt') as f:records += [json.loads(x) for x in f]
count=0
for rec in records:
    assert rec['kind']=='linear_candidate' and rec['rank']==4
    Q,H=rec['Q'],rec['H']
    A=endpoint(Q,'e');B=endpoint(Q,'c');C=endpoint(H,'c');D=endpoint(H,'e')
    be=embed(beta,FR)
    cols=[-A-D,-be*A-(1-be)*D,B+C,(1-be)*B+be*C]
    const=A*D-B*C
    mat=list(map(list,zip(*[coords(v)[1:] for v in cols])))
    assert rank(mat)==4
    p=list(map(scalar,rec['particular']))
    v=const+sum((col*embed(s,FR) for col,s in zip(cols,p)),FR.zero)
    assert not any(coords(v)[1:])
    nx=p[0]**2+p[0]*p[1]+2*p[1]**2
    ny=p[2]**2+p[2]*p[3]+2*p[3]**2
    residue=coords(v)[0]+nx-ny
    assert residue and pack(residue)==rec['quadric_at_particular']
    count+=1
assert count==144, count
print(json.dumps({'status':'PASS','linear_candidates_replayed':count,
                  'rank_four':count,'seven_linear_residuals_zero':count,
                  'scalar_quadric_residual_nonzero_and_matches':count,
                  'arithmetic':'independent polynomial arithmetic, no logarithm tables',
                  'seconds':round(time.monotonic()-start,3)},indent=2))
