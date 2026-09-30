#!/usr/bin/env python3
"""Stream the final self-contained archive, omitting regenerable intermediates."""
import argparse,hashlib,re,zipfile
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]
ESSENTIAL_BINS={'bezout_72_73_s.bin','bezout_72_73_t.bin','gcd_72_73.bin','gcd_radical_candidate.bin'}
QUOTIENT_BINS={'U71.bin','U72.bin','U73.bin','gcd.bin','modulus.bin'}
OMIT_DIRS={'build','verified_fibres','regenerated','reconstructed_fibres','sage_generated','__pycache__','clean_extract'}
def keep(rel):
 ps=rel.parts
 if any(p in OMIT_DIRS for p in ps):return False
 if rel.suffix in ('.pid','.pyc','.tmp'):return False
 if rel.name=='MANIFEST.sha256':return False
 if ps[0]=='next':
  if rel.name in ('package_checkpoint.py','checkpoint_claims.json','fibres_summary.json'):return False
  if len(ps)>1 and re.fullmatch(r'r\d+',ps[1]):
   if len(ps)>2 and ps[2].startswith('quotient_'):
    return ps[2]=='quotient_0' and (rel.suffix=='.json' or rel.name in QUOTIENT_BINS)
   if rel.suffix=='.bin':return rel.name in ESSENTIAL_BINS
   if rel.name=='generated.sha256' or rel.suffix=='.json':return True
   return False
  if len(ps)>1 and ps[1]=='evidence':
   if rel.name.startswith('probe_'):return False
   if re.fullmatch(r'(fibre_equations|fibre_resultants|res_strip|fibre_gcd|quotient_fibre)_r\d+\.log',rel.name):return False
 return True

def validate(z):
 bad=z.testzip()
 if bad:raise RuntimeError('ZIP CRC failure: '+bad)
 lines=z.read('linear140/MANIFEST.sha256').decode().splitlines()
 actual=set(z.namelist());expected={'linear140/MANIFEST.sha256'}
 for line in lines:
  h,name=line.split(None,1);name=name.strip();path='linear140/'+name;expected.add(path)
  dig=hashlib.sha256()
  with z.open(path) as f:
   for b in iter(lambda:f.read(1<<20),b''):dig.update(b)
  if dig.hexdigest()!=h:raise RuntimeError('SHA256 failure: '+name)
 if actual!=expected:raise RuntimeError('Unexpected/missing ZIP entries')
 return len(lines)
def main():
 ap=argparse.ArgumentParser();ap.add_argument('--output',type=Path,default=ROOT.parent/'linear140_fibre_continuation.zip');a=ap.parse_args();a.output.parent.mkdir(parents=True,exist_ok=True)
 manifest=[]
 with zipfile.ZipFile(a.output,'w',compression=zipfile.ZIP_DEFLATED,compresslevel=6,allowZip64=True) as z:
  for p in sorted(ROOT.rglob('*')):
   if not p.is_file():continue
   rel=p.relative_to(ROOT)
   if not keep(rel):continue
   name=str(rel);dig=hashlib.sha256()
   with p.open('rb') as src,z.open('linear140/'+name,'w',force_zip64=True) as dst:
    for b in iter(lambda:src.read(1<<20),b''):dig.update(b);dst.write(b)
   manifest.append(dig.hexdigest()+'  '+name+'\n')
  z.writestr('linear140/MANIFEST.sha256',''.join(manifest))
 with zipfile.ZipFile(a.output) as z:count=validate(z)
 print(str(a.output));print('Files:',count,'ZIP bytes:',a.output.stat().st_size,'CRC and SHA256 manifest PASS')
if __name__=='__main__':main()
