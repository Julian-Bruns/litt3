"""Install completed exact whole-branch evidence, using deterministic gzip.
Only collects already produced files. It does not prove a branch by collection.
Run verify_branch.py after collecting. Inputs are explicit, with no cache inference.
"""
from pathlib import Path
import argparse, gzip, hashlib, json, shutil
ROOT=Path(__file__).resolve().parents[1]
def sha(p):
 h=hashlib.sha256()
 with p.open('rb') as f:
  while b:=f.read(1<<20):h.update(b)
 return h.hexdigest()
def put(src,dst,compressed=True):
 src=Path(src);dst.parent.mkdir(parents=True,exist_ok=True)
 if compressed:
  with src.open('rb') as fi, dst.open('wb') as fo:
   with gzip.GzipFile(filename='',mode='wb',fileobj=fo,mtime=0,compresslevel=9) as gz:shutil.copyfileobj(fi,gz,1<<20)
 else:shutil.copyfile(src,dst)
 return {'file':dst.relative_to(ROOT).as_posix(),'uncompressed_sha256':sha(src),'uncompressed_bytes':src.stat().st_size}
def main():
 p=argparse.ArgumentParser();p.add_argument('r',type=int);p.add_argument('branch',type=int);p.add_argument('--tail-prefix',required=True);p.add_argument('--cert-prefix',required=True);p.add_argument('--chain-prefix',required=True);p.add_argument('--unit',required=True);p.add_argument('--factors',required=True);p.add_argument('--fiber-prefix',required=True);a=p.parse_args()
 assert a.r in (145049,211895,211959) and 0<=a.branch<4
 name=f'{a.r}_'+['small','large0','large1','large2'][a.branch]
 d=ROOT/'data'/'branches'/name;e=ROOT/'evidence'/'branches'/name
 items={}
 for n in (71,72):
  items[f'C{n}']=put(f'{a.tail_prefix}_C{n}.txt',d/f'C{n}.txt.gz')
  items[f'certificate{n}']=put(f'{a.cert_prefix}_C{n}_certificate.txt',e/f'scalar{n}_certificate.txt.gz')
  items[f'chain{n}']=put(f'{a.chain_prefix}_strip{n-71}_chain.txt',e/f'strip{n}_chain.txt.gz')
 items['support']=put(f'{a.tail_prefix}_support.txt',d/'support.txt',False)
 items['factors']=put(a.factors,d/'factors.txt',False)
 items['unit']=put(a.unit,e/'unit_bezout.txt.gz')
 nf=int(Path(a.factors).read_text().splitlines()[0]);items['fibers']=[]
 for i in range(nf):items['fibers'].append(put(f'{a.fiber_prefix}_f{i}_b{a.branch}.txt',e/'fibers'/f'f{i}.txt',False))
 desc={'r':a.r,'branch':a.branch,'branch_name':['small','large0','large1','large2'][a.branch], 'status':'collected_exact_evidence; verification recorded separately','files':items,
 'provenance':'C71,C72 generated from the entire compact residual over K(v)[S]/F; no finite-field point search. See replay_branch.py for fresh regeneration.'}
 (d/'descriptor.json').write_text(json.dumps(desc,indent=2)+'\n');print(name, 'collected',nf,'fiber records')
if __name__=='__main__':main()
