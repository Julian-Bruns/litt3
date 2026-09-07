"""Exact all-degree FLINT RREF bridge; import under Sage.

Finite coefficient fields stay coefficient fields, never extra unknowns.
Serialized cubic towers use their Kummer power basis when its parameter
generates the base field.  Only a base-degree square matrix is needed, not
an absolute-degree square matrix. Other small towers use a verified full
power basis; native finite fields require no change of modulus.
"""
import fcntl
import functools
import hashlib
import json
from pathlib import Path
import struct
import subprocess
import tempfile
import time


def compile_engine(source=None):
    from sage.env import SAGE_LOCAL
    source=Path(__file__).with_suffix('.cpp') if source is None else Path(source)
    digest=hashlib.sha256(source.read_bytes()).hexdigest()
    folder=Path(__file__).resolve().parents[2]/'litt3-computation-data/atlas-native-rref'/digest[:16]
    folder.mkdir(parents=True,exist_ok=True)
    target=folder/'rref'
    with (folder/'compile.lock').open('a') as lock:
        fcntl.flock(lock,fcntl.LOCK_EX)
        if not target.exists():
            prefix=Path(SAGE_LOCAL)
            subprocess.run(['c++','-O3','-std=c++17',str(source),'-o',str(target),
                '-I'+str(prefix/'include'),'-L'+str(prefix/'lib'),
                '-Wl,-rpath,'+str(prefix/'lib'),'-lflint'],check=True,capture_output=True,text=True)
    return target


class NativeRref:
    def __init__(self,field,layers=None,max_flatten_degree=128):
        from sage.all import GF,PolynomialRing,matrix,vector
        self.field=field; self.prime=GF(5); self.records=[]
        self.layers=layers
        self.degree=int(field.degree()) if layers is None else int(__import__('math').prod(int(d['degree']) for _,d in layers))
        self.native_field=field
        self.field_model='native'
        kummer=(layers is not None and len(layers)==2 and
                layers[0][1]['kind']=='finite_field' and
                layers[1][1]['kind']=='polynomial_quotient_field' and
                int(layers[1][1]['degree'])==3)
        if kummer and self.degree>max_flatten_degree:
            base=layers[0][0]; n=int(layers[0][1]['degree'])
            modulus=field.modulus()
            if modulus[1] or modulus[2] or modulus[3]!=1:
                raise NotImplementedError('Large quotient is not a cubic Kummer field')
            lam=-modulus[0]
            if n>2048:
                raise NotImplementedError('Kummer base conversion exceeds its explicit2048-degree preflight bound')
            def base_coordinates(c):
                cs=base(c).polynomial().list()
                return vector(self.prime,cs+[0]*(n-len(cs)))
            powers=[base.one()]
            for _ in range(n): powers.append(powers[-1]*lam)
            basis=matrix(self.prime,[base_coordinates(c) for c in powers[:-1]]).transpose()
            if basis.rank()!=n:
                raise NotImplementedError('Kummer parameter does not generate its full base field')
            inverse=basis.inverse()
            assert inverse*basis==matrix.identity(self.prime,n)
            relation=inverse*base_coordinates(powers[-1])
            ring=PolynomialRing(self.prime,'z')
            minimal=ring([-c for c in relation]+[1])
            assert minimal(lam)==0
            native_modulus=ring({3*i:c for i,c in enumerate(minimal) if c})
            self.native_field=GF(5**self.degree,name='native_z',
                modulus=native_modulus,check_irreducible=False)
            def to_native(c):
                cs=field(c).lift().list();cs += [base.zero()]*(3-len(cs))
                values=[self.prime.zero()]*self.degree
                for j,cj in enumerate(cs):
                    if cj:
                        column=inverse*base_coordinates(cj)
                        values[j::3]=column
                return self.native_field(values)
            def from_native(c):
                values=self.native_field(c).polynomial().list()
                values += [0]*(self.degree-len(values))
                return field([base(list(basis*vector(self.prime,values[j::3]))) for j in range(3)])
            self.to_native=to_native;self.from_native=from_native
            self.field_model='verified_Kummer_base_power_basis'
            # The invertible lambda basis and the defining cubic prove the
            # whole isomorphism. Explicit generator checks also guard packing.
            assert to_native(field.gen())==self.native_field.gen()
            assert to_native(field(lam))==self.native_field.gen()**3
            assert all(from_native(to_native(c))==c for c in
                       [field.one(),field(base.gen()),field.gen(),field(base.gen())*field.gen()**2])
        elif layers is not None and len(layers)>1:
            if self.degree>max_flatten_degree:
                raise NotImplementedError('Tower flattening is bounded; use the intrinsic deck-descended field')
            def coordinates(value,level):
                fld,desc=layers[level]; value=fld(value)
                cp=value.polynomial() if desc['kind']=='finite_field' else value.lift()
                values=cp.list()+[0]*(int(desc['degree'])-len(cp.list()))
                if level==0: return [self.prime(c) for c in values]
                return [c for v in values for c in coordinates(v,level-1)]
            self.old_coordinates=lambda c:vector(self.prime,coordinates(c,len(layers)-1))
            generators=[field(fld.gen()) for fld,_ in reversed(layers)]
            candidates=[generators[0]]+[generators[0]+c*sum(generators[1:],field.zero()) for c in range(1,5)]
            for theta in candidates:
                powers=[field.one()]
                for _ in range(self.degree): powers.append(powers[-1]*theta)
                basis=matrix(self.prime,[self.old_coordinates(c) for c in powers[:-1]]).transpose()
                if basis.rank()==self.degree: break
            else: raise NotImplementedError('No primitive separator in the bounded tower candidates')
            self.inverse=basis.inverse(); self.basis=basis; self.powers=powers[:-1]
            relation=self.inverse*self.old_coordinates(powers[-1])
            ring=PolynomialRing(self.prime,'z'); modulus=ring([-c for c in relation]+[1])
            assert sum((c*theta**i for i,c in enumerate(modulus.list())),field.zero())==0
            self.native_field=GF(5**self.degree,name='native_z',modulus=modulus,check_irreducible=False)
            self.to_native=lambda c:self.native_field(list(self.inverse*self.old_coordinates(c)))
            def from_coordinates(values,level):
                fld,desc=layers[level]
                if level==0: return fld(list(values))
                width=len(values)//int(desc['degree'])
                return fld([from_coordinates(values[j:j+width],level-1)
                            for j in range(0,len(values),width)])
            def from_native(c):
                values=c.polynomial().list(); values += [0]*(self.degree-len(values))
                return from_coordinates(list(self.basis*vector(self.prime,values)),len(layers)-1)
            self.from_native=from_native
            self.field_model='verified_full_power_basis'
            # A full power basis and its defining relation prove a field
            # isomorphism; test every original layer generator explicitly.
            assert all(self.from_native(self.to_native(c))==c for c in generators)
        else:
            self.to_native=lambda c:c; self.from_native=lambda c:c
        self.modulus=bytes(int(c) for c in self.native_field.modulus().list())
        assert len(self.modulus)==self.degree+1 and self.modulus[-1]==1
        self.engine=compile_engine()
        cache=max(16,min(8192,200000//self.degree))
        self.encode=functools.lru_cache(maxsize=cache)(self._encode)
        self.decode=functools.lru_cache(maxsize=cache)(self._decode)

    def _encode(self,value):
        native=self.to_native(value)
        encoded=bytes(int(c) for c in native.polynomial().list())
        assert self._decode(encoded)==value
        return encoded

    def _decode(self,value):
        native=self.native_field(list(value))
        return self.from_native(native)

    def _write_matrix(self,stream,M):
        for row in M.rows():
            terms=[(j,self.encode(c)) for j,c in enumerate(row) if c]
            stream.write(struct.pack('<I',len(terms)))
            for j,value in terms:
                stream.write(struct.pack('<II',j,len(value))); stream.write(value)

    def multiply(self,A,B,audit_sage=False,base_generator=None):
        """Exact native A*B; an F25 left matrix uses two PRIME-field sums.

        Pass base_generator for A over the fixed F25 with modulus z²+4z+2.
        This avoids one expensive extension-field multiplication per inner
        coefficient, keeping only one per output matrix entry.
        """
        from sage.all import matrix
        started=time.monotonic(); rows,inner=map(int,A.dimensions()); cols=int(B.ncols())
        assert inner==B.nrows() and B.base_ring()==self.field
        if not rows or not inner or not cols:
            return matrix(self.field,rows,cols)
        if base_generator is not None:
            assert list(A.base_ring().modulus())==[2,4,1]
            assert base_generator**2+4*base_generator+2==0
        else: assert A.base_ring()==self.field
        with tempfile.TemporaryDirectory(prefix='atlas-native-product-') as td:
            source=Path(td)/'input.bin'; target=Path(td)/'output.bin'
            with source.open('wb') as out:
                magic=0x41544c41534d5531 if base_generator is None else 0x41544c4153424131
                out.write(struct.pack('<QIIII',magic,self.degree,rows,inner,cols)); out.write(self.modulus)
                if base_generator is None: self._write_matrix(out,A)
                else:
                    value=self.encode(base_generator); out.write(struct.pack('<I',len(value))); out.write(value)
                    for row in A.rows():
                        for c in row:
                            values=c.polynomial().list()+[0,0]
                            out.write(bytes((int(values[0]),int(values[1]))))
                self._write_matrix(out,B)
            encoded=time.monotonic()
            proc=subprocess.run([str(self.engine),str(source),str(target)],check=True,capture_output=True,text=True)
            record=json.loads(proc.stdout)
            with target.open('rb') as stream:
                magic,degree,m,n=struct.unpack('<QIII',stream.read(20))
                assert (magic,degree,m,n)==(0x41544c41534d4f31,self.degree,rows,cols)
                values=[]
                for _ in range(rows*cols):
                    length=struct.unpack('<I',stream.read(4))[0]
                    assert length<=degree
                    data=stream.read(length); assert len(data)==length and all(c<5 for c in data)
                    values.append(self.decode(data))
                assert not stream.read(1)
            result=matrix(self.field,rows,cols,values,implementation='generic')
            if audit_sage:
                if base_generator is not None:
                    embed=lambda c:sum((self.field(a)*base_generator**i for i,a in enumerate(c.polynomial().list())),self.field.zero())
                    A=matrix(self.field,A.nrows(),A.ncols(),[embed(c) for c in A.list()],implementation='generic')
                else: A=matrix(self.field,A.nrows(),A.ncols(),A.list(),implementation='generic')
                BB=matrix(self.field,B.nrows(),B.ncols(),B.list(),implementation='generic')
                assert result==A*BB
            record.update(encode_seconds=encoded-started,bridge_total_seconds=time.monotonic()-started,
                          sage_product_audited=bool(audit_sage))
            self.records.append(record); return result

    def rref(self,M,audit_sage=False):
        from sage.all import matrix,identity_matrix
        started=time.monotonic(); rows,cols=map(int,M.dimensions())
        if not rows or not cols:
            E=M.augment(identity_matrix(self.field,rows)).echelon_form()
            rank=sum(p<cols for p in E.pivots())
            return E[:rank,:cols],E[:rank,cols:]
        with tempfile.TemporaryDirectory(prefix='atlas-native-rref-') as td:
            source=Path(td)/'input.bin'; target=Path(td)/'output.bin'
            with source.open('wb') as out:
                out.write(struct.pack('<QIII',0x41544c4153465131,self.degree,rows,cols)); out.write(self.modulus)
                for row in M.rows():
                    terms=[(j,self.encode(c)) for j,c in enumerate(row) if c]
                    out.write(struct.pack('<I',len(terms)))
                    for j,value in terms: out.write(struct.pack('<II',j,len(value))); out.write(value)
            encoded=time.monotonic()
            proc=subprocess.run([str(self.engine),str(source),str(target)],check=True,capture_output=True,text=True)
            record=json.loads(proc.stdout)
            with target.open('rb') as stream:
                magic,degree,m,n,rank=struct.unpack('<QIIII',stream.read(24))
                assert (magic,degree,m,n)==(0x41544c4153525231,self.degree,rows,cols) and rank<=min(rows,cols)
                values=[]
                for _ in range(rank*(rows+cols)):
                    length=struct.unpack('<I',stream.read(4))[0]
                    assert length<=degree
                    data=stream.read(length); assert len(data)==length and all(c<5 for c in data)
                    values.append(self.decode(data))
                assert not stream.read(1)
            E=matrix(self.field,rank,cols+rows,values,implementation='generic')
            A,C=E[:,:cols],E[:,cols:]
            if audit_sage:
                # Sage's optimized Givaro dense matrix arithmetic can use
                # the wrong basis for NON-Conway small-field moduli. Audit
                # through scalar field operations in generic matrices.
                original=matrix(self.field,rows,cols,M.list(),implementation='generic')
                expected=original.augment(identity_matrix(self.field,rows)).echelon_form()
                assert E==expected[:rank,:] and C*original==A
            record.update(encode_seconds=encoded-started,bridge_total_seconds=time.monotonic()-started,
                          sage_echelon_and_identity_audited=bool(audit_sage))
            self.records.append(record)
            return A,C
