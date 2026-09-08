"""Backup-only single-RHS solve/dual bridge, checked against original matrices."""
import json
import hashlib
from pathlib import Path
import shutil
import struct
import subprocess
import tempfile
import time
from atlas_native_rref import NativeRref,compile_engine


class NativeLinear:
    def __init__(self,field,cache_directory=None):
        self.field=field;self.codec=NativeRref(field)
        self.engine=compile_engine(Path(__file__).with_suffix('.cpp'))
        self.records=[]
        self.cache_directory=Path(cache_directory) if cache_directory else None
        if self.cache_directory:self.cache_directory.mkdir(parents=True,exist_ok=True)

    def self_test(self):
        from sage.all import matrix,vector
        c=self.field.gen()
        good=self.solve_or_dual(matrix(self.field,[[1,c],[0,1]],implementation='generic'),vector(self.field,[c,1]))
        assert not good['dual'] and good['vector']==vector(self.field,[c,1-c*c])
        bad=self.solve_or_dual(matrix(self.field,[[1,c],[2,2*c]],implementation='generic'),vector(self.field,[0,1]))
        assert bad['dual'] and bad['vector']==vector(self.field,[-c,1])
        return True

    def module_self_test(self):
        from sage.all import matrix
        c=self.field.gen()
        source=matrix(self.field,[[1,c,1],[2,2*c,2]],implementation='generic')
        kernel=self.right_kernel(source)
        assert kernel.ncols()==2 and kernel[1:,:]==matrix.identity(self.field,2)
        targets=matrix(self.field,[[c,c*c,c],[c+1,c*c+c,c+1]],implementation='generic')
        weights=self.row_identities(source,targets)
        assert weights*source==targets
        return True

    def right_kernel(self,M):
        return self._module_operation(M,None)

    def row_identities(self,M,targets):
        return self._module_operation(M,targets)

    def _module_operation(self,M,targets):
        from sage.all import matrix
        started=time.monotonic();rows,cols=map(int,M.dimensions())
        assert M.base_ring()==self.field
        kernel=targets is None
        count=0 if kernel else int(targets.nrows())
        if not kernel:assert targets.base_ring()==self.field and targets.ncols()==cols and count<=128
        with tempfile.TemporaryDirectory(prefix='backup-module-') as td:
            source=Path(td)/'input.bin';output=Path(td)/'output.bin'
            with source.open('wb') as out:
                magic=0x424b504c494e5333 if kernel else 0x424b504c494e5334
                out.write(struct.pack('<QIII',magic,self.codec.degree,rows,cols))
                if not kernel:out.write(struct.pack('<I',count))
                out.write(self.codec.modulus);self.codec._write_matrix(out,M)
                if not kernel:self.codec._write_matrix(out,targets)
            encoded=time.monotonic()
            cache_key=hashlib.sha256(source.read_bytes()+Path(__file__).with_suffix('.cpp').read_bytes()).hexdigest()
            cache_binary=self.cache_directory/(cache_key+'.bin') if self.cache_directory else None
            cache_record=self.cache_directory/(cache_key+'.json') if self.cache_directory else None
            reused=bool(cache_binary and cache_binary.exists() and cache_record.exists())
            if reused:
                record=json.loads(cache_record.read_text())
                assert hashlib.sha256(cache_binary.read_bytes()).hexdigest()==record['cached_binary_sha256']
                shutil.copyfile(cache_binary,output)
            else:
                proc=subprocess.run([str(self.engine),str(source),str(output)],check=True,capture_output=True,text=True)
                record=json.loads(proc.stdout)
                if cache_binary:
                    temporary=Path(str(cache_binary)+'.tmp');shutil.copyfile(output,temporary);temporary.replace(cache_binary)
                    record['cached_binary_sha256']=hashlib.sha256(cache_binary.read_bytes()).hexdigest()
                    record['cache_authority']='Native exact identity only until the mandatory scalar original-matrix replay below.'
                    temporary=Path(str(cache_record)+'.tmp');temporary.write_text(json.dumps(record)+'\n');temporary.replace(cache_record)
            with output.open('rb') as stream:
                magic,degree,kind,out_rows,out_cols,rank=struct.unpack('<QIIIII',stream.read(28))
                assert magic==0x424b504c494e5335 and degree==self.codec.degree and kind==(2 if kernel else 3)
                assert (out_rows,out_cols)==((cols,cols-rank) if kernel else (count,rows))
                values=[]
                for _ in range(out_rows*out_cols):
                    size=struct.unpack('<I',stream.read(4))[0];assert size<=degree
                    data=stream.read(size);assert len(data)==size and all(c<5 for c in data)
                    values.append(self.codec.decode(data))
                assert not stream.read(1)
            answer=matrix(self.field,out_rows,out_cols,values,implementation='generic')
            # Scalar Sage replay of every entry, not a native rank assertion.
            if kernel:
                assert M*answer==0 and answer.rank()==out_cols
            else:assert answer*M==targets
            record.update(encode_seconds=encoded-started,bridge_seconds=time.monotonic()-started,
                          independent_original_matrix_identity_verified=True,
                          reused_exact_input_cache=reused,input_and_backend_sha256=cache_key)
            self.records.append(record)
            return answer

    def solve_or_dual(self,M,target):
        from sage.all import matrix,vector
        started=time.monotonic();rows,cols=map(int,M.dimensions())
        assert M.base_ring()==self.field and len(target)==cols
        with tempfile.TemporaryDirectory(prefix='backup-linear-') as td:
            source=Path(td)/'input.bin';output=Path(td)/'output.bin'
            with source.open('wb') as out:
                out.write(struct.pack('<QIII',0x424b504c494e5331,self.codec.degree,rows,cols))
                out.write(self.codec.modulus);self.codec._write_matrix(out,M)
                self.codec._write_matrix(out,matrix(self.field,1,cols,list(target),implementation='generic'))
            encoded=time.monotonic()
            proc=subprocess.run([str(self.engine),str(source),str(output)],check=True,capture_output=True,text=True)
            record=json.loads(proc.stdout)
            with output.open('rb') as stream:
                magic,degree,kind,length,rank=struct.unpack('<QIIII',stream.read(24))
                assert magic==0x424b504c494e5332 and degree==self.codec.degree
                assert kind in [0,1] and length==(cols if kind else rows)
                values=[]
                for _ in range(length):
                    size=struct.unpack('<I',stream.read(4))[0];assert size<=degree
                    data=stream.read(size);assert len(data)==size and all(c<5 for c in data)
                    values.append(self.codec.decode(data))
                assert not stream.read(1)
            result=vector(self.field,values)
            # These use independent scalar Sage field arithmetic, not RREF.
            if kind:assert M*result==0 and vector(self.field,target)*result==1
            else:assert result*M==vector(self.field,target)
            record.update(encode_seconds=encoded-started,bridge_seconds=time.monotonic()-started,
                          independent_original_vector_identity_verified=True)
            self.records.append(record)
            return {'dual':bool(kind),'vector':result,'rank':rank}
