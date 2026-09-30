"""Reproducible exact GMP acceleration; original arithmetic is left unchanged.

The generated translation units are work caches. Every replacement is an
asserted, unique source transformation. Field codes, quotient algebras, and
mathematical operations are unchanged. All large products use an explicit
no-carry Kronecker bound, not numerical transforms.
"""
import pathlib,subprocess,ctypes as ct,os,hashlib
from exact import ROOT
CACHE=ROOT/'work/fast';CACHE.mkdir(parents=True,exist_ok=True)

FASTMOD=r'''
static KP Fcached,Finverse;
static KP fast_remainder(const KP&f){
 if(f.size()<=size_t(ED)){KP r=f;trim(r);return r;}
 if(f.size()>size_t(2*ED-1))throw runtime_error("fast remainder input bound");
 if(Fcached!=EM){
  Fcached=EM;KP rev(EM.rbegin(),EM.rend());Finverse={1};
  while(Finverse.size()<size_t(ED)){
   size_t n=min(size_t(ED),2*Finverse.size());KP b(rev.begin(),rev.begin()+min(rev.size(),n));
   KP h=pmul(b,Finverse);h.resize(n,0);for(int&z:h)z=neg(z);h[0]=add(h[0],2);
   Finverse=pmul(Finverse,h);Finverse.resize(n,0);
  }
 }
 size_t qn=f.size()-ED;KP rev(f.rbegin(),f.rend());rev.resize(qn,0);
 KP iv(Finverse.begin(),Finverse.begin()+qn),qr=pmul(rev,iv);qr.resize(qn,0);
 KP q(qr.rbegin(),qr.rend()),prod=pmul(q,EM),r=f;
 for(size_t i=0;i<prod.size();i++)r[i]=sub(r[i],prod[i]);
 for(size_t i=ED;i<r.size();i++)if(r[i])throw runtime_error("fast quotient exact high-coefficient check failed");
 r.resize(ED);trim(r);return r;
}
'''

def replace_one(s,a,b):
 if s.count(a)!=1:raise RuntimeError('Unexpected arithmetic source; refusing an unverified transformation: '+a[:80])
 return s.replace(a,b)

def field_source():
 s=(ROOT/'src/field.cpp').read_text()
 s=replace_one(s,'using KP=vector<int>;','using KP=vector<int>;\n#include "'+str(ROOT/'src/gmp_polynomial.hpp')+'"')
 s=replace_one(s,'static KP pmul(const KP&a,const KP&b){\n if(a.empty()||b.empty())return {};',
   'static KP pmul(const KP&a,const KP&b){\n if(a.empty()||b.empty())return {};\n if(min(a.size(),b.size())>=96)return ks_pmul(a,b);')
 s=replace_one(s,'static int ED=1;static KP EM={0,1};','static int ED=1;static KP EM={0,1};\n'+FASTMOD)
 s=replace_one(s,'static void emul_to(int*out,const int*a,const int*b){\n if(ED==1){out[0]=mul(a[0],b[0]);return;}',
   '''static void emul_to(int*out,const int*a,const int*b){
 if(ED==1){out[0]=mul(a[0],b[0]);return;}
 if(ED>=128){KP aa(a,a+ED),bb(b,b+ED);trim(aa);trim(bb);KP r=fast_remainder(pmul(aa,bb));fill(out,out+ED,0);copy(r.begin(),r.end(),out);return;}''')
 s=replace_one(s,'''  for(int j=2*ED-2;j>=ED;j--)if(tmp[j])for(int k=0;k<ED;k++)tmp[j-ED+k]=sub(tmp[j-ED+k],mul(tmp[j],EM[k]));
  copy(tmp,tmp+ED,z.a.begin()+i*ED);''',
  '''  if(ED>=128){KP r=fast_remainder(KP(tmp,tmp+s));copy(r.begin(),r.end(),z.a.begin()+i*ED);}
  else {for(int j=2*ED-2;j>=ED;j--)if(tmp[j])for(int k=0;k<ED;k++)tmp[j-ED+k]=sub(tmp[j-ED+k],mul(tmp[j],EM[k]));
  copy(tmp,tmp+ED,z.a.begin()+i*ED);}''')
 s+='\nextern "C" int ks_test_product(const int*a,int n,const int*b,int m,int*out){try{KP c=ks_pmul(KP(a,a+n),KP(b,b+m));fill(out,out+n+m-1,0);copy(c.begin(),c.end(),out);return 0;}catch(...){return -1;}}\n'
 dest=CACHE/'field_fast.cpp'
 if not dest.exists() or dest.read_text()!=s:dest.write_text(s)
 return dest

def library(stem='finite_norm'):
 field=field_source();source=ROOT/'src'/f'{stem}.cpp'
 s=source.read_text();s=replace_one(s,'#include "field.cpp"','#include "'+str(field)+'"')
 # Avoid the unused final squaring in exponentiation. This is an exact
 # operation-count change, not a different power or truncated product.
 s=s.replace('eppower(th[0],3)','epmul(epmul(th[0],th[0]),th[0])')
 s=s.replace('eppower(th[1],3)','epmul(epmul(th[1],th[1]),th[1])')
 s=s.replace('eppower(th[2],3)','epmul(epmul(th[2],th[2]),th[2])')
 s=s.replace('eppower(Pbar,2)','epmul(Pbar,Pbar)')
 out=CACHE/f'{stem}_fast.cpp'
 if not out.exists() or out.read_text()!=s:out.write_text(s)
 so=CACHE/f'lib{stem}_fast.so'
 latest=max(out.stat().st_mtime,field.stat().st_mtime,(ROOT/'src/gmp_polynomial.hpp').stat().st_mtime)
 if not so.exists() or so.stat().st_mtime<latest:
  tmp=so.with_name(so.name+'.'+str(os.getpid())+'.tmp')
  subprocess.run(['g++','-O3','-std=c++17','-fPIC','-shared',str(out),'-lgmp','-o',str(tmp)],check=True);os.replace(tmp,so)
 l=ct.CDLL(str(so));l.ff_init();IP=ct.POINTER(ct.c_int)
 if stem=='finite_norm':l.finite_norm_tails.argtypes=[IP,ct.c_int,IP,ct.c_int,IP,IP,IP,IP,IP]
 return l
if __name__=='__main__':
 l=library();print('Exact GMP backend built; generated field SHA256',hashlib.sha256(field_source().read_bytes()).hexdigest())
