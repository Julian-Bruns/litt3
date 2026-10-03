#!/usr/bin/env python3
"""Fetch pinned official Kissat binary and independent DRAT checker source.

Preparation only; --build-checker is a separate one-core compilation step.
Original downloads and provenance are retained outside the workspace.
"""
import argparse,hashlib,io,json,os,subprocess,urllib.request,zipfile
from pathlib import Path

def fetch(url):
    return urllib.request.urlopen(urllib.request.Request(url,headers={'User-Agent':'litt3-exact-research'})).read()

def main():
    ap=argparse.ArgumentParser();ap.add_argument('--output-dir',required=True,type=Path)
    ap.add_argument('--build-checker',action='store_true');args=ap.parse_args();out=args.output_dir;out.mkdir(parents=True,exist_ok=True)
    metadata=out/'provenance.json'
    if metadata.exists():meta=json.loads(metadata.read_text())
    else:
        url='https://github.com/arminbiere/kissat/releases/download/rel-4.0.4/kissat-4.0.4-apple-arm64.zip'
        raw=fetch(url);(out/'kissat-4.0.4-apple-arm64.zip').write_bytes(raw)
        with zipfile.ZipFile(io.BytesIO(raw)) as z:
            members=[p for p in z.namelist() if Path(p).name in ('kissat','kissat-4.0.4-apple-arm64')];assert len(members)==1
            binary=z.read(members[0]);(out/'kissat').write_bytes(binary);(out/'kissat').chmod(0o755)
        commit=json.loads(fetch('https://api.github.com/repos/marijnheule/drat-trim/commits/master'))['sha']
        sourceurl=f'https://raw.githubusercontent.com/marijnheule/drat-trim/{commit}/drat-trim.c'
        source=fetch(sourceurl);(out/'drat-trim.c').write_bytes(source)
        meta=dict(kissat_release='rel-4.0.4',kissat_archive_url=url,
            kissat_archive_sha256=hashlib.sha256(raw).hexdigest(),kissat_binary_sha256=hashlib.sha256(binary).hexdigest(),
            drat_trim_commit=commit,drat_trim_source_url=sourceurl,
            drat_trim_source_sha256=hashlib.sha256(source).hexdigest(),status='prepared; checker not compiled')
        metadata.write_text(json.dumps(meta,indent=2)+'\n')
    if args.build_checker:
        cc=os.environ.get('CC','/opt/homebrew/opt/llvm/bin/clang')
        command=[cc,'-O2',str(out/'drat-trim.c'),'-o',str(out/'drat-trim')]
        subprocess.run(command,check=True)
        meta.update(status='prepared; checker compiled',checker_compile_command=command,
            compiler_version=subprocess.check_output([cc,'--version'],text=True).splitlines()[0],
            kissat_version=subprocess.check_output([str(out/'kissat'),'--version'],text=True).strip(),
            drat_trim_binary_sha256=hashlib.sha256((out/'drat-trim').read_bytes()).hexdigest())
        metadata.write_text(json.dumps(meta,indent=2)+'\n')
    print(json.dumps(meta))

if __name__=='__main__':main()
