"""An exact full-R witness from few columns, checked on EVERY direction.

No normal-rank hypothesis is assumed. If a lower-rank candidate fails on
another direction, that direction is added to its determining columns.
At most32 iterations recover the full finite system. A returned witness
has been checked against all64 N rows, all56 raw R rows and the compact
projection identity, without forming a huge expanded coefficient matrix.
"""
import hashlib
import json
import multiprocessing
from concurrent.futures import ThreadPoolExecutor
from pathlib import Path
import struct
import time
from atlas_native_directions import NativeDirections
from atlas_native_rref import NativeRref
from atlas_resources import fork_workers,release_scratch,resident_rss

_CHECK=None
def _check_block(index):
    try:return _CHECK(index)
    except BaseException as error:
        # Sage SignalError is NOT an Exception. Letting it escape kills a
        # Pool worker and loses the result forever; surface a hard failure.
        raise RuntimeError('Original R block %s failed: %s: %s'%
                           (index,type(error).__name__,error)) from None
def sha(path):return hashlib.sha256(Path(path).read_bytes()).hexdigest()
def atomic(path,value):
    temporary=Path(str(path)+'.tmp')
    temporary.write_text(json.dumps(value,indent=2,default=int)+'\n');temporary.replace(path)


class FactoredRWitness(NativeDirections):
    def __init__(self,data,Bc,Iproj):
        from sage.all import matrix
        self.matrix=matrix;self.original_field=data['k']
        def layers(k,d):
            if d['kind']=='finite_field':return [(k,d)]
            return layers(k.base_ring(),d['base'])+[(k,d)]
        self.bridge=NativeRref(data['k'],layers(data['k'],data['field_description']))
        self.field=self.bridge.native_field;self.native=NativeRref(self.field)
        self.Bc=self.flatten(Bc);self.Iproj=self.flatten(Iproj)
        assert self.native.multiply(self.Iproj,self.Bc)==matrix.identity(self.field,32)

    def verify(self,paths,output,workers=10,memory_gib=8):
        from sage.all import load,save,block_matrix
        started=time.monotonic();paths=list(map(Path,paths));assert len(paths)==32
        folder=Path(output);folder.mkdir(parents=True,exist_ok=True)
        hashes=[sha(p) for p in paths]
        # This binds both the actual coefficients and the original coordinate
        # projection; the final identities themselves are checked independently.
        digest=hashlib.sha256(''.join(hashes).encode());digest.update(self.bridge.modulus)
        for matrix in (self.Bc,self.Iproj):
            for value in matrix.list():
                encoded=self.native.encode(value)
                digest.update(struct.pack('<I',len(encoded)));digest.update(encoded)
        identity=digest.hexdigest()
        pointer=folder/'candidate.json';prior=json.loads(pointer.read_text()) if pointer.exists() else {}
        if prior:assert prior['identity']==identity
        def block(i):
            assert sha(paths[i])==hashes[i]
            binding=paths[i].parent/'complete_native'/('binding-%02d.json'%i)
            if binding.exists():
                b=json.loads(binding.read_text());binary=Path(b['binary'])
                assert b['direction']==i and b['original_sha256']==hashes[i]
                assert b['original_path']==str(paths[i].resolve())
                assert bytes(b['native_modulus'])==self.bridge.modulus and sha(binary)==b['binary_sha256']
                with binary.open('rb') as stream:
                    assert struct.unpack('<QI',stream.read(12))==(0x41544c4449524f31,self.bridge.degree)
                    matrices=[]
                    for rows,cols in [(64,32),(32,32),(56,32)]:
                        assert struct.unpack('<II',stream.read(8))==(rows,cols)
                        values=[]
                        for _ in range(rows*cols):
                            length=struct.unpack('<I',stream.read(4))[0]
                            assert length<=self.bridge.degree
                            value=stream.read(length);assert len(value)==length and all(c<5 for c in value)
                            values.append(self.native.decode(value))
                        matrices.append(self.matrix(self.field,rows,cols,values,implementation='generic'))
                    assert not stream.read(1)
                n,c,r=matrices
            else:
                matrices=load(str(paths[i]));assert len(matrices)==3
                n,c,r=map(self.flatten,matrices)
            assert [tuple(M.dimensions()) for M in (n,c,r)]==[(64,32),(32,32),(56,32)]
            assert self.native.multiply(self.Iproj,r)==c
            return n,r-self.native.multiply(self.Bc,c)
        selected=prior.get('selected',[0,1,2]);candidate=None;rank=None
        if prior:
            candidate_path=Path(prior['path']);assert sha(candidate_path)==prior['sha256']
            candidate=self.flatten(load(str(candidate_path)));rank=prior['rank']
        for iteration in range(32):
            if candidate is None:
                blocks=[block(i) for i in selected]
                nn=block_matrix(self.field,1,len(blocks),[n for n,_ in blocks])
                dd=block_matrix(self.field,1,len(blocks),[d for _,d in blocks])
                a,c=self.native.rref(nn);rank=int(a.nrows())
                pivots=[next(j for j,value in enumerate(row) if value) for row in a.rows()]
                weights=dd.matrix_from_columns(pivots)
                assert self.native.multiply(weights,a)==dd,'Raw R defect not in selected N-row span'
                candidate=self.native.multiply(weights,c)
                assert self.native.multiply(candidate,nn)==dd
                witness_old=self.restore(candidate)
                temporary=folder/'candidate.tmp.sobj';save(witness_old,str(temporary))
                digest=sha(temporary);candidate_path=folder/('candidate-'+digest+'.sobj')
                if candidate_path.exists():
                    assert sha(candidate_path)==digest;temporary.unlink()
                else:temporary.replace(candidate_path)
                atomic(pointer,dict(identity=identity,selected=selected,rank=rank,
                    sha256=digest,path=str(candidate_path.resolve())))
                blocks=nn=dd=a=c=weights=witness_old=None;release_scratch()
                print(json.dumps(dict(stage='full_R_small_determining_system',directions=selected,
                    N_rank=rank,seconds=time.monotonic()-started)),flush=True)
            candidate_digest=sha(candidate_path)
            native_checks=None
            if all((p.parent/'complete_native'/('binding-%02d.json'%i)).exists()
                   for i,p in enumerate(paths)):
                from atlas_native_R_checks import NativeRChecks
                native_checks=NativeRChecks(candidate,self.Bc,self.Iproj,folder)
            def check(i):
                target=folder/('check-%02d-%s.json'%(i,candidate_digest))
                if target.exists():
                    record=json.loads(target.read_text())
                    assert record['direction_sha256']==hashes[i] and record['candidate_sha256']==candidate_digest
                    assert record['identity']==identity
                    return i,record['valid']
                one=time.monotonic();native_record=None
                if native_checks is not None:
                    native_record=native_checks.check_bound(paths[i],i,hashes[i])
                    valid=native_record['valid']
                else:
                    n,d=block(i);valid=self.native.multiply(candidate,n)==d
                atomic(target,dict(identity=identity,direction=int(i),direction_sha256=hashes[i],
                    candidate_sha256=candidate_digest,valid=bool(valid),
                    compact_projection_identity_verified=True,raw_R_rows=56,
                    native_check=native_record,seconds=time.monotonic()-one))
                return i,valid
            global _CHECK
            _CHECK=check
            if native_checks is not None:
                # No forked Sage field or arithmetic scratch per job. The
                # one-shot C++ process reads immutable native coefficients.
                # The tested d1320 context/matrices peak around200MiB on a
                # sparse fixture; reserve twice the dense coefficient size.
                estimate=max(128*1024**2,32*16640*self.bridge.degree)
                room=max(0,int(memory_gib*1024**3)-resident_rss())
                count=max(1,min(int(workers),32,room//estimate))
            else:count,estimate=fork_workers(workers,32,resident_rss(),memory_gib*1024**3)
            print(json.dumps(dict(stage='full_R_all_original_blocks',workers=count,
                estimated_worker_rss_bytes=estimate,completed_checks=sum(
                    (folder/('check-%02d-%s.json'%(i,candidate_digest))).exists() for i in range(32)))),flush=True)
            failed=[]
            if count==1:answers=map(check,range(32))
            elif native_checks is not None:
                pool=ThreadPoolExecutor(max_workers=int(count))
                answers=pool.map(check,range(32))
            else:
                # Pool replacement forks originate in a management thread and
                # cannot inherit PARI's main-thread-local arithmetic state.
                pool=multiprocessing.get_context('fork').Pool(int(count))
                answers=pool.imap_unordered(_check_block,range(32),chunksize=1)
            try:
                for i,valid in answers:
                    if not valid:failed.append(i)
            except BaseException:
                if count!=1 and native_checks is None:pool.terminate()
                raise
            finally:
                if count!=1:
                    if native_checks is not None:pool.shutdown(wait=True,cancel_futures=True)
                    else:pool.close();pool.join()
            if not failed:
                result=self.restore(candidate)
                atomic(folder/'verified.json',dict(identity=identity,candidate_sha256=candidate_digest,
                    all_32_original_block_identities_verified=True,raw_R_rows=56,
                    compact_projection_identities_verified=True,determining_directions=selected,
                    determining_rank=rank,seconds=time.monotonic()-started,workers=count))
                print(json.dumps(dict(stage='full_R_factored_witness_verified',N_rank=rank,
                    determining_directions=selected,all_original_blocks=32,
                    seconds=time.monotonic()-started)),flush=True)
                return result
            assert rank<64,'Unique full-rank witness failed another original block'
            new=sorted(set(selected)|set(failed))
            assert len(new)>len(selected)
            selected=new;candidate=None
        raise RuntimeError('Finite full-R row-space refinement did not terminate')
