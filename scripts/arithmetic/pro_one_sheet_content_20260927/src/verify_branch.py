"""Verify all retained certificates for one COMPLETE geometric scale branch.
Checks factor coverage, exact global polynomial/Bezout identities, and independent
Python finite-algebra units/opens/saturation. Does not regenerate tails from Ehat;
use replay_branch.py for that full, more expensive, regeneration.
"""
from pathlib import Path
import argparse,gzip,hashlib,json,shutil,subprocess,sys
from integral_chart import um
from verify_finite_fibers import check,read_certificate
ROOT=Path(__file__).resolve().parents[1]
def loadp(line):
 a=list(map(int,line.split()));assert a and a[0]==len(a)-1;return a[1:]
def main():
 ap=argparse.ArgumentParser();ap.add_argument('name');ap.add_argument('--no-compile',action='store_true');a=ap.parse_args()
 d=ROOT/'data'/'branches'/a.name;desc=json.loads((d/'descriptor.json').read_text());fs=desc['files'];w=ROOT/'build'/'verify_branches'/a.name;w.mkdir(parents=True,exist_ok=True)
 def materialize(k):
  m=fs[k];src=ROOT/m['file'];dst=w/src.name.removesuffix('.gz');h=hashlib.sha256()
  with (gzip.open(src,'rb') if src.suffix=='.gz' else src.open('rb')) as i,dst.open('wb') as o:
   while b:=i.read(1<<20):h.update(b);o.write(b)
  assert h.hexdigest()==m['uncompressed_sha256'];assert dst.stat().st_size==m['uncompressed_bytes'];return dst
 paths={k:materialize(k) for k in fs if k!='fibers'}
 support=loadp(paths['support'].read_text().strip());rows=paths['factors'].read_text().splitlines();nf=int(rows[0]);factors=[loadp(l) for l in rows[1:]];assert len(factors)==nf==len(fs['fibers'])
 prod=[1]
 for f in factors:prod=um(prod,f)
 assert prod==support, 'Factor coverage incomplete'
 records=[]
 for i,m in enumerate(fs['fibers']):
  p=ROOT/m['file'];assert hashlib.sha256(p.read_bytes()).hexdigest()==m['uncompressed_sha256'];meta,_,_=read_certificate(p)
  assert (meta['r'],meta['branch'],meta['factor'],meta['vf'])==(desc['r'],desc['branch'],i,factors[i])
  rec=check(p);records.append(rec);print('fiber',i,rec,flush=True)
 binary=ROOT/'build'/'verify_global'
 if not a.no_compile:subprocess.run(['g++','-O3','-std=c++17',str(ROOT/'src/verify_global.cpp'),'-lgmp','-o',str(binary)],check=True)
 cmd=[str(binary),str(ROOT/f'data/function_input_{desc["r"]}.txt')]+[str(paths[k]) for k in ['C71','C72','certificate71','certificate72','support','chain71','chain72','unit']]
 result=subprocess.run(cmd,check=True,text=True,stdout=subprocess.PIPE);print(result.stdout,end='')
 report={'status':'PASS','r':desc['r'],'branch':desc['branch'],'scope':'complete geometric branch on all original opens; B1=0 and J=0 use their separately certified exclusions', 'support_degree':len(support)-1,'factor_degrees':[len(f)-1 for f in factors], 'factor_product_identity':'PASS','finite_records':records,'retained_algebra_dimension':sum(r.get('dimension',0) for r in records),'global_certificate_output':result.stdout,'tail_provenance':'Regeneration from compact residual is provided by replay_branch.py; this command independently checks the displayed global identities and finite-algebra certificates.'}
 out=ROOT/'evidence'/'branches'/a.name/'verification.json';out.write_text(json.dumps(report,indent=2)+'\n');print('WHOLE_BRANCH_EXCLUSION=PASS',a.name,'dimension',report['retained_algebra_dimension'])
if __name__=='__main__':main()
