"""Exact cubic descent of ALL97 rooted equations, with original-row lifts.

This consumes an EVERY-coefficient grading check, not a normal-rank claim.
The actual original56-R equivalence and all graph/normalization rows stay.
"""
import functools,json,time
from pathlib import Path
from atlas_native_tensor_input import NativeTensorInput,sha


class CubicDescendedChart:
    def __init__(self,tensor,chart,grading_path):
        from sage.all import GF,PolynomialRing
        from atlas_field_maps import from_power_coordinates
        start=time.monotonic();self.path=Path(tensor).resolve();self.source_sha256=sha(self.path)
        self.chart=int(chart);assert 0<=self.chart<32
        grade=json.loads(Path(grading_path).read_text())
        assert grade['source_sha256']==self.source_sha256
        assert grade['all_original_N_and_R_character_identities_verified']
        self.input=NativeTensorInput(self.path,self.source_sha256);assert self.input.rooted
        header=self.input.header;self.original_field_model=header['field_model']
        assert header.get('coupled_N_kernel_forces_R_output_in_J_verified') or header.get('checks',{}).get('coupled_R_image_verified')
        self.description=header['field_description'];degree=int(self.original_field_model['degree_F5'])
        assert degree==grade['degree_F5'] and degree%3==0
        modulus=self.original_field_model['modulus']
        assert all(not c or i%3==0 for i,c in enumerate(modulus))
        self.degree=degree//3;P0=PolynomialRing(GF(5),'x')
        self.k=GF(5**self.degree,'c',modulus=P0(modulus[::3]))
        self.lam=self.k.gen();assert self.lam
        self.field_model=dict(degree_F5=self.degree,modulus=modulus[::3],
            layer_generator_images={'c':[0,1]},construction='checked_diagonal_cubic_descent')
        self.weights=list(map(int,grade['weights_v_and_beta']));nw=list(map(int,grade['weights_N']))
        assert len(self.weights)==32 and len(nw)==64
        j=self.chart;wj=self.weights[j];self.a=[w-wj for w in self.weights]
        self.names=['v%d'%i for i in range(32)]+['b%d'%h for h in range(j+1,32)]+['w']
        self.ring=PolynomialRing(self.k,names=self.names,order='degrevlex');P=self.ring
        v=P.gens()[:32];b=[P.zero()]*j+[P.one()]+list(P.gens()[32:-1])
        def coefficient(key,i,r,h):
            cs=self.input.coefficient(key,i,r,h)
            support={e%3 for e,c in enumerate(cs) if c};assert len(support)<=1
            if not support:return self.k.zero()
            g=next(iter(support));row_weight=nw[r] if key=='N_tensor' else 2*self.weights[r]
            e=self.weights[i]+self.weights[h]-row_weight
            assert (g+e)%3==0
            return from_power_coordinates(self.k,cs[g::3])*self.lam**((g+e)//3)
        def tensor(key,count):
            rows=[{} for _ in range(count)]
            for i in range(32):
                for h in range(j,32):
                    ex=[0]*P.ngens();ex[i]=1
                    if h>j:ex[31+h-j]=1
                    ex=tuple(ex)
                    for r in range(count):
                        c=coefficient(key,i,r,h)
                        if c:rows[r][ex]=c
            return [P(row) for row in rows],rows
        n,n_terms=tensor('N_tensor',64);s,s_terms=tensor('R_tensor',32)
        self.original_low_terms=[dict(row) for row in n_terms+s_terms[:j+1]]
        self.original_low_terms[-1][(0,)*P.ngens()]=self.k(-1)
        def frob(f):return P({tuple(5*e for e in ex):c**5 for ex,c in f.dict().items()})
        self.original=(n+[s[h]-(1 if h==j else 0) for h in range(j+1)]+
            [self.lam**(3*self.a[h])*frob(s[h])-b[h] for h in range(j+1,32)]+
            [P.gens()[-1]*sum((self.lam**self.a[i]*v[i]*s[i] for i in range(32)),P.zero())-1])
        assert len(self.original)==97
        self.row_weights=[n-2*wj for n in nw]+[2*self.a[h] for h in range(j+1)]+self.a[j+1:]+[0]
        self.variable_weights=self.a+self.a[j+1:]+[0]
        self.locals=dict(zip(self.names,P.gens()),c=self.k.gen());self.input.close();self.input=None
        self.timings=dict(checked_native_root_cache=True,checked_deck_descent=True,
            original_degree_F5=degree,search_degree_F5=self.degree,total_seconds=time.monotonic()-start)

    def parse(self,text):
        from sage.all import sage_eval
        return self.ring(sage_eval(text,locals=self.locals))

    def verify_unit(self,multipliers):
        assert len(multipliers)==97
        assert sum((h*f for h,f in zip(multipliers,self.original)),self.ring.zero())==1
        return True

    def original_comparison(self,verify_all_rows=False,native_input=False):
        from atlas_original_chart import OriginalChart
        from atlas_field_maps import verified_embedding
        original=OriginalChart(self.path,self.chart,field_model=self.original_field_model,native_input=native_input)
        embedding=verified_embedding(self.k,original.k,original.k.gen()**3)
        @functools.lru_cache(maxsize=1024)
        def power(e):return original.k.gen()**e
        def substitute(f):
            return original.ring({tuple(ex):embedding(c)*power(-sum(e*a for e,a in zip(ex,self.variable_weights)))
                                  for ex,c in f.dict().items()})
        if verify_all_rows:
            assert all(substitute(f)*power(a)==old for f,a,old in
                       zip(self.original,self.row_weights,original.original))
        return original,substitute,power

    def lift_certificate(self,multipliers):
        self.verify_unit(multipliers)
        # Search may use the source-bound, every-coefficient checked cache.
        # Acceptance still requires a FRESH no-cache ORIGINAL-JSON replay.
        original,substitute,power=self.original_comparison(native_input=True)
        lifted=[substitute(h)*power(-a) for h,a in zip(multipliers,self.row_weights)]
        original.verify_unit(lifted)
        return original,lifted
