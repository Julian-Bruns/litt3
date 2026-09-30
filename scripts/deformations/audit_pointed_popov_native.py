from sage.all import *
from pathlib import Path
import ast, hashlib, json, struct, subprocess, itertools

ROOT=Path(__file__).resolve().parents[2]
OUT=ROOT.parent/'litt3-computation-data'/'pointed_popov_native_audit_20260916'
OUT.mkdir(parents=True,exist_ok=True)
SOURCE=ROOT/'scripts/deformations/pointed_popov_native.cpp'
OLD=ROOT/'scripts/deformations/probe_pointed_observability.py'
k=GF(125,'b'); R=PolynomialRing(k,'t'); t=R.gen()
nodes=[x for x in ast.parse(OLD.read_text()).body if isinstance(x,ast.FunctionDef)
       and x.name in ('normalized_pencil','insert_popov_row')]
exec(compile(ast.Module(body=nodes,type_ignores=[]),str(OLD),'exec'),globals())
def code(a):return sum(int(c)*5**i for i,c in enumerate(k(a).polynomial().list()))
elements=[k([i%5,(i//5)%5,i//25]) for i in range(125)]
assert list(map(code,elements))==list(range(125))
tables=(struct.pack('<II',0x31504f50,125)
 +bytes(code(a+b) for a in elements for b in elements)
 +bytes(code(a*b) for a in elements for b in elements)
 +bytes(code(-a) for a in elements)
 +bytes(0 if not a else code(1/a) for a in elements))
def polybytes(row):
    degree=max((p.degree() for p in row),default=-1)
    return bytes(code(p[d]) for d in range(int(degree)+1) for p in row)
def rowhash(row):
    value=1469598103934665603
    for a in polybytes(row):value=((value^a)*1099511628211)&((1<<64)-1)
    return str(value)
I=identity_matrix(k,2); Z=zero_matrix(k,2)
no_drop=[matrix(k,[[1,0],[0,1],[0,0],[0,0]]),
         matrix(k,[[0,0],[1,0],[0,1],[0,0]]),
         matrix(k,[[0,0],[0,0],[1,0],[0,1]])]
pencils=[('no_drop',normalized_pencil({'matrices':no_drop})),
 ('nonunit_t', (Z,Z,Z,I)),
 ('extension_only', (Z,Z,-matrix(k,[[0,2],[1,0]]),I)),
 ('zero_rows',(Z,Z,Z,Z)),
 ('nilpotent_cancellation',(matrix(k,[[0,1],[0,0]]),Z,matrix(k,[[1,0],[0,0]]),Z)),
 ('leading_coefficient_cancellation',(I,-I,matrix(k,[[1,k.gen()],[0,0]]),matrix(k,[[-1,-k.gen()],[0,0]])))]
set_random_seed(16092026)
for idx in range(36):
    n=1+idx%4
    mats=tuple(random_matrix(k,n,n) for _ in range(2))+tuple(random_matrix(k,2,n) for _ in range(2))
    if idx%3==0:mats=(mats[0],mats[1],zero_matrix(k,2,n),mats[3])
    if idx%4==0:mats=(mats[0],mats[1],mats[2],zero_matrix(k,2,n))
    pencils.append(('random_%02d'%idx,mats))
raw=tables+struct.pack('<I',len(pencils))
references=[]
for idx,(name,(A,B,C,D)) in enumerate(pencils):
    n=A.ncols()
    raw+=struct.pack('<III',idx,0,n)+b''.join(bytes(map(code,M.list())) for M in (A,B,C,D))
    basis=[None]*n; row=C.change_ring(R)+t*D.change_ring(R)
    T=A.change_ring(R)+t*B.change_ring(R); stages=[]; allrows=[]
    for power in range(n):
        hashes=list(map(rowhash,row.rows()))
        for v in row.rows():
            allrows.append(list(v));insert_popov_row(basis,v)
        present=[v for v in basis if v is not None]
        rank=len(present); ds=sum(max(p.degree() for p in v) for v in present)
        stages.append(dict(power=power,rank=rank,pivot_degree_sum=int(ds),row_hashes=hashes))
        full=rank==n and ds==0
        if full:break
        row=row*T
    W=matrix(R,allrows); gcd=R(0)
    for rr in itertools.combinations(range(W.nrows()),n):
        gcd=gcd.gcd(W.matrix_from_rows(rr).det())
    assert full==(gcd.is_unit())
    references.append(dict(name=name,stages=stages,whole_row_module=bool(full),minor_gcd=str(gcd.monic() if gcd else gcd)))
(OUT/'pencils.bin').write_bytes(raw)
subprocess.run(['c++','-O2','-std=c++17',str(SOURCE),'-o',str(OUT/'engine')],check=True)
subprocess.run([str(OUT/'engine'),str(OUT/'pencils.bin'),str(OUT/'native.json')],check=True,stdout=(OUT/'native.log').open('w'))
actual=json.loads((OUT/'native.json').read_text())
for ref,result in zip(references,actual['blocks']):
    assert ref['stages']==result['stages'],ref['name']
    assert ref['whole_row_module']==result['whole_row_module']
assert len(actual['blocks'])==len(references)
assert references[2]['minor_gcd']==str(t*t-2)
assert (t*t-2).is_irreducible() and all(a*a!=2 for a in k)

# A test-only harness calls the very same native insert() on arbitrary rows.
harness='#define main native_program_main\n#include "'+str(SOURCE)+'"\n#undef main\n'+r'''
int main(int argc,char**argv){
 std::ifstream in(argv[1],std::ios::binary); read32(in); Field f; f.q=read32(in);
 f.add=readbytes(in,f.q*f.q);f.mul=readbytes(in,f.q*f.q);
 f.neg=readbytes(in,f.q);f.inv=readbytes(in,f.q);
 unsigned count=read32(in); std::ofstream out(argv[2]);out<<"[";
 for(unsigned z=0;z<count;++z){
  unsigned n=read32(in),nr=read32(in);
  std::vector<std::unique_ptr<Row>> basis(n);std::uint64_t steps=0;
  for(unsigned j=0;j<nr;++j){Row r;r.n=n;r.c=readbytes(in,read32(in));insert(basis,r,f,steps);}
  if(z)out<<",";out<<"[";
  for(unsigned j=0;j<n;++j){if(j)out<<",";if(!basis[j]){out<<"null";continue;}
   out<<"[";for(std::size_t i=0;i<basis[j]->c.size();++i){if(i)out<<",";out<<unsigned(basis[j]->c[i]);}out<<"]";
  }out<<"]";
 }out<<"]";return 0;
}
'''
(OUT/'row_harness.cpp').write_text(harness)
modules=[[[R(0),R(0)]], [[t*t,t],[t,1],[0,t*t-2]], [[t+1,2*t],[t+1,2*t],[-t-1,-2*t]],
 [[t*t+1,t*t],[1,t],[t,0],[0,1]], [[k.gen()*t,0],[t*t,0],[0,0]]]
for idx in range(30):
    n=1+idx%4
    modules.append([[R([k.random_element() for _ in range(1+idx%5)]) for _ in range(n)] for _ in range(1+idx%7)])
raw=tables+struct.pack('<I',len(modules)); rowrefs=[]
for rows in modules:
    rows=[[R(p) for p in v] for v in rows];n=len(rows[0]);basis=[None]*n
    raw+=struct.pack('<II',n,len(rows))
    for v in rows:
        encoded=polybytes(v);raw+=struct.pack('<I',len(encoded))+encoded
        insert_popov_row(basis,v)
    rowrefs.append([None if v is None else list(polybytes(v)) for v in basis])
(OUT/'rows.bin').write_bytes(raw)
subprocess.run(['c++','-O2','-std=c++17',str(OUT/'row_harness.cpp'),'-o',str(OUT/'row_harness')],check=True)
subprocess.run([str(OUT/'row_harness'),str(OUT/'rows.bin'),str(OUT/'rows.json')],check=True)
assert json.loads((OUT/'rows.json').read_text())==rowrefs
receipt=dict(status='PASS',sage=version(),pencil_count=len(pencils),direct_module_count=len(modules),
 engine_sha256=hashlib.sha256(SOURCE.read_bytes()).hexdigest(),
 wrapper_sha256=hashlib.sha256((ROOT/'scripts/deformations/run_pointed_popov_native.py').read_bytes()).hexdigest(),
 sage_source_sha256=hashlib.sha256(OLD.read_bytes()).hexdigest(),
 audit_sha256=hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
 pencils=references,all_stages_hashes_ranks_degrees_match=True,direct_bases_match=True,
 no_cover_builder_or_height_computation=True)
(OUT/'audit.json').write_text(json.dumps(receipt,indent=2,default=int)+'\n')
print('PASS',len(pencils),'pencils;',len(modules),'direct modules')
