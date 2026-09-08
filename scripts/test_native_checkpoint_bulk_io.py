#!/usr/bin/env python3
"""Off-controller format-preserving checkpoint I/O candidate and regressions.

This generates a SEPARATE candidate binary. It does not patch or migrate the
live solver. Pivot arrays are contiguous; block stream operations preserve
the original bytes and original bytewise checksum. Mathematical checkpoint,
DAG, weight and old-prefix/fallback comparisons are mandatory.
"""
import argparse,hashlib,json,runpy,shutil,struct,subprocess,time
from pathlib import Path
from test_native_pencil_parallel import mathematical_checkpoint

ROOT=Path(__file__).resolve().parents[1]
DATA=ROOT.parent/'litt3-computation-data'


def candidate_source(code):
    patches=[
        ('template<class T> T cpread(ifstream&f){T v=get<T>(f);hashbytes((char*)&v,sizeof(v));return v;}',
         'template<class T> T cpread(ifstream&f){T v=get<T>(f);hashbytes((char*)&v,sizeof(v));return v;}\n'
         'static void cpwrite_bytes(ofstream&f,const void*p,size_t n){if(!n)return;f.write((const char*)p,n);if(!f)throw runtime_error("checkpoint block write failed");hashbytes((const char*)p,n);}\n'
         'static void cpread_bytes(ifstream&f,void*p,size_t n){if(!n)return;f.read((char*)p,n);if(!f)throw runtime_error("truncated checkpoint block");hashbytes((char*)p,n);}'),
        ('for(auto &v:p.col)v=cpread<uint32_t>(f);for(auto &v:p.val)v=cpread<uint8_t>(f);',
         'cpread_bytes(f,p.col.data(),sizeof(uint32_t)*n);cpread_bytes(f,p.val.data(),n);'),
        ('if(recurrence){s.source_pivots.resize(rows);for(uint32_t r=0;r<rows;r++){int32_t id=cpread<int32_t>(f);s.source_pivots[r]=id;',
         'if(recurrence){s.source_pivots.resize(rows);cpread_bytes(f,s.source_pivots.data(),sizeof(int32_t)*rows);for(uint32_t r=0;r<rows;r++){int32_t id=s.source_pivots[r];'),
        ('for(auto v:p.col)cpwrite(f,v);for(auto v:p.val)cpwrite(f,v);',
         'cpwrite_bytes(f,p.col.data(),sizeof(uint32_t)*p.col.size());cpwrite_bytes(f,p.val.data(),p.val.size());'),
        ('if(recurrence)for(auto id:state.source_pivots)cpwrite(f,id);',
         'if(recurrence)cpwrite_bytes(f,state.source_pivots.data(),sizeof(int32_t)*state.source_pivots.size());')]
    for old,new in patches:
        assert code.count(old)==1,old
        code=code.replace(old,new)
    return code


FIXTURE_MAIN=r'''
int main(int argc,char**argv){
 if(argc!=3||string(argv[1])!="--fixture")return engine_main(argc,argv);
 string folder=argv[2];uint32_t rows=1024,cols=20000,rank=512,width=16384;
 ofstream matrix_file(folder+"/matrix.bin",ios::binary);put(matrix_file,rows);put(matrix_file,cols);matrix_file.close();
 ofstream dag_file(folder+"/dag.bin",ios::binary);dag_file.close();
 ofstream f(folder+"/state.cp",ios::binary);digest=1469598103934665603ULL;
 cpwrite(f,uint64_t(0x4d414341554c3031ULL));cpwrite(f,rows);cpwrite(f,cols);cpwrite(f,cols-1);
 cpwrite(f,rank);cpwrite(f,uint64_t(8));cpwrite(f,uint64_t(0));cpwrite(f,uint64_t(0));
 cpwrite(f,uint64_t(rank)*width);cpwrite(f,double(0));cpwrite(f,rank);
 vector<uint32_t> columns(width);vector<uint8_t> values(width);
 for(uint32_t i=0;i<rank;i++){
  cpwrite(f,uint64_t(0));cpwrite(f,width);columns[0]=i;values[0]=1;
  for(uint32_t j=1;j<width;j++){columns[j]=rank+j-1;values[j]=1+(i+7*j)%24;}
  f.write((char*)columns.data(),4*width);hashbytes((char*)columns.data(),4*width);
  f.write((char*)values.data(),width);hashbytes((char*)values.data(),width);
 }
 put(f,digest);f.close();return f?0:1;
}
'''


def verify(output,io_fixture=True):
    output=Path(output);output.mkdir(parents=True,exist_ok=False)
    started=time.monotonic()
    original=runpy.run_path(str(ROOT/'scripts/mixed_atlas_certificate.sage'))['CPP_GENERAL']
    candidate=candidate_source(original)
    binaries={}
    for name,code in [('old',original),('bulk',candidate)]:
        assert code.count('int main(')==1
        cpp=output/(name+'.cpp');cpp.write_text(code.replace('int main(','int engine_main(',1)+FIXTURE_MAIN)
        binary=output/name
        subprocess.run(['c++','-O3','-std=c++17','-pthread',str(cpp),'-o',str(binary)],check=True,timeout=20)
        binaries[name]=binary
    def invoke(name,binary,matrix,boundary,pred='',threads=1,maxrows=2**32-1):
        folder=output/name;folder.mkdir(exist_ok=True)
        command=[str(binary),str(matrix),str(folder/'dag.bin'),str(folder/'weights.bin'),
            '30',str(768*1024**2),str(folder/'state.cp'),str(boundary),'10000',str(maxrows),
            '-1','',name,'{}',str(pred),str(threads),'0']
        result=subprocess.run(command,check=True,capture_output=True,text=True,timeout=35)
        return folder,json.loads(result.stdout),result.stderr
    def equal(a,b):
        assert mathematical_checkpoint(a/'state.cp')==mathematical_checkpoint(b/'state.cp')
        for filename in ['dag.bin','weights.bin','weights.bin.relation','state.cp.pure_b.bin']:
            aa=a/filename;bb=b/filename;assert aa.exists()==bb.exists(),filename
            if aa.exists():assert aa.read_bytes()==bb.read_bytes(),filename
    cases=[('actual28',DATA/'atlas-predecessor-tests/chart-28/matrix.bin',320,
            DATA/'atlas-predecessor-tests/chart-28/predecessor.bin'),
           ('zero_descendants',DATA/'atlas-predecessor-tests/zero-descendant/matrix.bin',2,
            DATA/'atlas-predecessor-tests/zero-descendant/predecessor.bin')]
    results=[]
    for label,matrix,boundary,pred in cases:
        baseline,_,_=invoke(label+'-old',binaries['old'],matrix,boundary,pred)
        for threads in [1,10]:
            new,r,_=invoke(label+'-bulk'+str(threads),binaries['bulk'],matrix,boundary,pred,threads)
            equal(baseline,new)
            results.append(dict(case=label,threads=threads,mathematical_checkpoint_DAG_weights_equal=True,status=r['status']))
        resumed,_,_=invoke(label+'-migration',binaries['old'],matrix,boundary,pred,maxrows=2)
        resumed,_,_=invoke(label+'-migration',binaries['bulk'],matrix,boundary,pred,threads=10,maxrows=37)
        prefix,_,_=invoke(label+'-prefix',binaries['old'],matrix,boundary,pred,maxrows=39)
        equal(resumed,prefix)
        # Corrupt ONLY our test copy. The candidate must reject the checksum
        # and recover the exact previous prefix before continuing.
        shutil.copyfile(resumed/'state.cp',Path(str(resumed/'state.cp')+'.prev'))
        raw=bytearray((resumed/'state.cp').read_bytes());raw[-1]^=1;(resumed/'state.cp').write_bytes(raw)
        resumed,r,stderr=invoke(label+'-migration',binaries['bulk'],matrix,boundary,pred,threads=10)
        assert 'Primary checkpoint rejected:' in stderr;equal(baseline,resumed)
        results.append(dict(case=label,exact_old_prefix_resume=True,corrupt_primary_previous_prefix_fallback=True))
        print(label,'PASS',flush=True)
    io_results=[]
    if io_fixture:
        seed=output/'io-seed';seed.mkdir()
        subprocess.run([str(binaries['old']),'--fixture',str(seed)],check=True,timeout=20)
        for name in ['old','bulk']:
            for repeat in range(3):
                folder=output/('io-'+name+'-'+str(repeat));folder.mkdir()
                for file in ['state.cp','dag.bin']:shutil.copyfile(seed/file,folder/file)
                before=time.monotonic()
                folder,result,_=invoke(folder.name,binaries[name],seed/'matrix.bin',19999,maxrows=0)
                wall=time.monotonic()-before
                assert mathematical_checkpoint(folder/'state.cp')==mathematical_checkpoint(seed/'state.cp')
                io_results.append(dict(engine=name,repeat=repeat,wall_seconds=wall,
                    native_seconds=result['native_seconds'],checkpoint_seconds=result['work_since_invocation_start']['checkpoint_seconds'],
                    bytes=(folder/'state.cp').stat().st_size))
    report=dict(status='PASS',old_engine_sha256=hashlib.sha256(original.encode()).hexdigest(),
        candidate_engine_sha256=hashlib.sha256(candidate.encode()).hexdigest(),
        tests=results,io_fixture=io_results,seconds=time.monotonic()-started,
        scope='Off-controller exact same-format checkpoint candidate only; no deployment or new atlas exclusion')
    (output/'verification.json').write_text(json.dumps(report,indent=2)+'\n')
    print(json.dumps(report),flush=True);return report


if __name__=='__main__':
    ap=argparse.ArgumentParser();ap.add_argument('--output',type=Path,required=True)
    ap.add_argument('--no-io-fixture',action='store_true');args=ap.parse_args()
    verify(args.output,not args.no_io_fixture)
