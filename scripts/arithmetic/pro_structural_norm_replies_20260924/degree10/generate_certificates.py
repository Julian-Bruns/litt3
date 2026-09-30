#!/usr/bin/env python3
"""Generate deterministic, portable JSON certificates from the displayed inputs."""
import argparse, json, pathlib, sys
if not __debug__:
 raise SystemExit('Run without -O or -OO: verification assertions must remain enabled.')
ROOT=pathlib.Path(__file__).resolve().parent
sys.path.insert(0,str(ROOT/'source'))
from certification import build_certificates

def main():
 parser=argparse.ArgumentParser();parser.add_argument('--output',type=pathlib.Path,default=ROOT/'certificates');args=parser.parse_args()
 args.output.mkdir(parents=True,exist_ok=True)
 for name,data in build_certificates(log=lambda s: print(s,flush=True)).items():
  (args.output/name).write_text(json.dumps(data,ensure_ascii=False,separators=(',',':'))+'\n',encoding='utf-8')
 print('WROTE '+str(args.output))
if __name__=='__main__':main()
