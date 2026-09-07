"""Independent Sage fixture for the direct internal compact NF adapter."""
import tempfile, pathlib, struct, subprocess
R=PolynomialRing(GF(5),15,names=['v%s'%i for i in range(15)],order='degrevlex')
x,y,z=R.gens()[12:]
I=R.ideal(list(R.gens()[:12])+[x^2-y,y^3+x+1,z^2+4*z+2])
G=list(I.groebner_basis())
assert I.dimension()==0
std=sorted(I.normal_basis())
G.sort(key=lambda g:g.lm())
def key(m):return sum(int(e)<<(4*i) for i,e in enumerate(m.exponents()[0]))
tmp=pathlib.Path(tempfile.mkdtemp(prefix='litt3-compact-nf-fixture.'))
p=tmp/'basis'
for suffix,values in [('.standard.u64',[key(m) for m in std]),('.lm.u64',[key(g.lm()) for g in G])]:
    pathlib.Path(str(p)+suffix).write_bytes(struct.pack('<'+'Q'*len(values),*values))
pathlib.Path(str(p)+'.u8').write_bytes(bytes([int((-g+g.lm()).monomial_coefficient(m)) for g in G for m in std]))
total=0
for var in [12,13,14]:
    out=tmp/('nf%s'%var)
    subprocess.run(['/tmp/litt3-compact-nf',str(p),str(var),str(out),'3','2'],check=True)
    for fp in sorted(tmp.glob('nf%s.*.u8'%var)):
        data=fp.read_bytes(); kd=fp.with_suffix('.keys.u64').read_bytes(); keys=struct.unpack('<'+'Q'*(len(kd)//8),kd)
        for j,k in enumerate(keys):
            m=prod(R.gen(i)^((k>>(4*i))&15) for i in range(15))
            expected=m.reduce(G)
            actual=sum(R(data[j*len(std)+c])*s for c,s in enumerate(std))
            assert actual==expected,(m,actual,expected)
            total+=1
assert total>3
print('PASS Sage actual GB: %s standards, %s nontrivial NFs across x,y,z; %s'%(len(std),total,tmp))
