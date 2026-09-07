"""Reconstruct ALL97 original rooted chart rows in a native coefficient field.

No affine elimination, determinant chart, or discarded R equation. The32
compact R rows have the tensor's verified56-row coupled-R equivalence.
The final row retains the nonzero normalization. Import under Sage.
"""
import functools,hashlib,json,time
from pathlib import Path


def sha(path):
    return hashlib.sha256(Path(path).read_bytes()).hexdigest()


class OriginalChart:
    def __init__(self,tensor_path,chart,field_model=None):
        started=time.monotonic();self.timings={}
        from sage.all import GF,PolynomialRing,sage_eval
        from atlas_native_rref import NativeRref
        self.path=Path(tensor_path).resolve();self.source_sha256=sha(self.path)
        self.data=json.loads(self.path.read_text());self.chart=int(chart)
        self.timings['hash_and_json_seconds']=time.monotonic()-started
        assert 0<=self.chart<32
        assert self.data['variables']=={'u':32,'beta':32}
        assert (self.data.get('coupled_N_kernel_forces_R_output_in_J_verified') or
                self.data.get('checks',{}).get('coupled_R_image_verified')), \
            'Do not drop any of the original56 R rows without the tensor equivalence check'
        self.description=self.data.get('field_description') or dict(
            kind='finite_field',characteristic=5,degree=2,generator='a',modulus=[2,4,1])
        prime=GF(5); Z=PolynomialRing(prime,'z')
        if field_model is None:
            layers=[]
            def decode(value,level):
                fld,desc=layers[level]
                return fld(value) if level==0 else fld([decode(c,level-1) for c in value])
            def make(desc):
                if desc['kind']=='finite_field':
                    fld=GF(5**int(desc['degree']),name=desc['generator'],
                           modulus=Z(desc['modulus']),check_irreducible=False)
                else:
                    base=make(desc['base']);T=PolynomialRing(base,'fieldvariable')
                    fld=T.quotient(T([decode(c,len(layers)-1) for c in desc['modulus']]),
                                   names=desc['generator'])
                layers.append((fld,desc));return fld
            old=make(self.description);bridge=NativeRref(old,layers)
            self.degree=bridge.degree
            self.k=GF(5**self.degree,name='c',modulus=Z(list(bridge.modulus)),check_irreducible=False)
            def native(value):return self.k(bridge.to_native(old(value)).polynomial().list())
            images={desc['generator']:native(fld.gen()) for fld,desc in layers}
            if 'base_F25_generator' in self.description:
                images['a']=native(decode(self.description['base_F25_generator'],len(layers)-1))
            self.field_model=dict(degree_F5=self.degree,modulus=list(bridge.modulus),
                layer_generator_images={name:[int(c) for c in value.polynomial().list()]
                                        for name,value in images.items()},
                construction=bridge.field_model)
        else:
            self.field_model=field_model;self.degree=int(field_model['degree_F5'])
            # Unlike search, independent replay checks this defining field.
            self.k=GF(5**self.degree,name='c',modulus=Z(field_model['modulus']))
            images={name:self.k(cs) for name,cs in field_model['layer_generator_images'].items()}
        self.images=images
        def decode_native(value,desc):
            generator=images[desc['generator']]
            coefficients=([self.k(c) for c in value] if desc['kind']=='finite_field'
                          else [decode_native(c,desc['base']) for c in value])
            answer=self.k.zero()
            for coefficient in reversed(coefficients):answer=answer*generator+coefficient
            return answer
        def check_relations(desc):
            if desc['kind']=='finite_field':
                coefficients=[self.k(c) for c in desc['modulus']]
            else:
                check_relations(desc['base'])
                coefficients=[decode_native(c,desc['base']) for c in desc['modulus']]
            answer=self.k.zero()
            for coefficient in reversed(coefficients):answer=answer*images[desc['generator']]+coefficient
            assert answer==0
        check_relations(self.description)
        from atlas_coefficient_codec import canonical_coefficient_decoder
        direct=canonical_coefficient_decoder(self.k,self.description,images)
        def decode_coefficient(value):
            if not isinstance(value,str):return decode_native(value,self.description)
            if direct is not None:
                answer=direct(value)
                if answer is not None:return answer
            return self.k(sage_eval(value,locals=images))
        self.decode=decode_coefficient
        self.inverse_frobenius=5**(self.degree-1)
        self.root=functools.lru_cache(maxsize=max(32,min(16384,200000//self.degree)))(self._root)
        self.timings['field_setup_seconds']=time.monotonic()-started-self.timings['hash_and_json_seconds']
        before_rows=time.monotonic()
        j=self.chart
        self.names=['v%d'%i for i in range(32)]+['b%d'%h for h in range(j+1,32)]+['w']
        self.ring=PolynomialRing(self.k,names=self.names,order='degrevlex')
        P=self.ring;v=P.gens()[:32];b=[P.zero()]*j+[P.one()]+list(P.gens()[32:-1])
        def tensor(key,count):
            rows=[{} for _ in range(count)]
            for i in range(32):
                for h in range(j,32):
                    ex=[0]*P.ngens();ex[i]=1
                    if h>j:ex[31+h-j]=1
                    ex=tuple(ex)
                    for r in range(count):
                        value=self.data[key][i][r][h]
                        if not isinstance(value,str):value=json.dumps(value,separators=(',',':'))
                        c=self.root(value)
                        if c:rows[r][ex]=c
            return [P(row) for row in rows]
        n=tensor('N_tensor',64);s=tensor('R_tensor',32)
        def frob(f):return P({tuple(5*e for e in ex):c**5 for ex,c in f.dict().items()})
        self.original=(n+[s[h]-(1 if h==j else 0) for h in range(j+1)]+
                       [frob(s[h])-b[h] for h in range(j+1,32)]+
                       [P.gens()[-1]*sum((u*t for u,t in zip(v,s)),P.zero())-1])
        assert len(self.original)==97
        self.locals=dict(zip(self.names,P.gens()),c=self.k.gen())
        self.timings['row_construction_seconds']=time.monotonic()-before_rows
        # Keep the original rows, not all32 charts' long coefficient strings.
        # This is also important before parallel independent certificate replay.
        self.data=None;self.root.cache_clear()
        from atlas_resources import release_scratch
        release_scratch()
        self.timings['total_seconds']=time.monotonic()-started

    def _root(self,text):
        value=self.decode(json.loads(text) if text.startswith('[') else text)
        # PARI caches the generator's inverse-Frobenius image once. Binary
        # exponentiation to5^(d-1) repeated for every coefficient was dominant
        # in large fields. Small Givaro fields retain their cheap old power.
        answer=value.pth_power(-1) if self.degree>4 else value**self.inverse_frobenius
        assert answer**5==value
        return answer

    def parse(self,text):
        from sage.all import sage_eval
        return self.ring(sage_eval(text,locals=self.locals))

    def verify_unit(self,multipliers):
        assert len(multipliers)==len(self.original)==97
        answer=self.ring.zero()
        for h,f in zip(multipliers,self.original):answer+=h*f
        assert answer==1
        return True
