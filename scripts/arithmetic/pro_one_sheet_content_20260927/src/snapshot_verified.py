"""Freeze verified evidence, hash it, and stream one self-contained ZIP.
In-progress branches and regenerable build files are not included. Active text
logs are copied consistently before hashing. The previous ZIP remains valid
until the replacement is atomically installed.
"""
from pathlib import Path
import argparse,hashlib,json,os,shutil,time,zipfile
ROOT=Path(__file__).resolve().parents[1]
def sha(p):
 h=hashlib.sha256()
 with p.open('rb') as f:
  while b:=f.read(1<<20):h.update(b)
 return h.hexdigest()
def main():
 ap=argparse.ArgumentParser();ap.add_argument('output');ap.add_argument('--tree',required=True);a=ap.parse_args();out=Path(a.output).resolve();tree=Path(a.tree).resolve()
 if tree.exists():shutil.rmtree(tree)
 tree.mkdir(parents=True)
 verified=set()
 for p in (ROOT/'evidence/branches').glob('*/verification.json'):
  if json.loads(p.read_text()).get('status')=='PASS':verified.add(p.parent.name)
 catalogue=json.loads((ROOT/'evidence/complete_case_catalogue.json').read_text());assert verified=={r['name'] for r in catalogue['completed']}
 for base,dirs,names in os.walk(ROOT):
  relbase=Path(base).relative_to(ROOT);dirs[:]=[d for d in dirs if d not in ['build','__pycache__']]
  if len(relbase.parts)>=2 and relbase.parts[0] in ['data','evidence'] and relbase.parts[1]=='branches':
   if len(relbase.parts)==2:dirs[:]=[d for d in dirs if d in verified]
  for name in names:
   p=Path(base)/name;rel=p.relative_to(ROOT)
   if name=='SHA256SUMS' or name.startswith('R_q') or p.suffix in ['.zip','.pyc']:continue
   dest=tree/rel;dest.parent.mkdir(parents=True,exist_ok=True)
   for attempt in range(10):
    before=p.stat();shutil.copyfile(p,dest);after=p.stat()
    if (before.st_size,before.st_mtime_ns)==(after.st_size,after.st_mtime_ns):
     if p.suffix=='.json':json.loads(dest.read_text())
     break
    time.sleep(.01)
   else:raise RuntimeError('Source did not stabilize: '+str(rel))
 meta={'status':'PASS','included_complete_branches':sorted(verified),'excluded':'Unverified branch directories, build outputs, binary caches, expanded residuals, and other regenerable large intermediates.'}
 (tree/'evidence/snapshot_scope.json').write_text(json.dumps(meta,indent=2)+'\n')
 files=sorted(p for p in tree.rglob('*') if p.is_file());(tree/'SHA256SUMS').write_text(''.join(sha(p)+'  '+p.relative_to(tree).as_posix()+'\n' for p in files))
 tmp=Path(str(out)+'.partial')
 with zipfile.ZipFile(tmp,'w',compression=zipfile.ZIP_DEFLATED,compresslevel=9,allowZip64=True) as z:
  for p in files+[tree/'SHA256SUMS']:z.write(p,'one_sheet_content/'+p.relative_to(tree).as_posix(),compress_type=zipfile.ZIP_STORED if p.suffix=='.gz' else zipfile.ZIP_DEFLATED)
 os.replace(tmp,out);print(json.dumps({'output':str(out),'files':len(files)+1,'bytes':out.stat().st_size,'sha256':sha(out),'complete_branches':sorted(verified)},indent=2),flush=True)
if __name__=='__main__':main()
