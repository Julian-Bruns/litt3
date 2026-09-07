"""Exact constant-row/affine preprocessing with reversible ideal provenance.

Only equations z-g with a nonzero CONSTANT coefficient of z are solved.
No denominator depending on a variable, localization, rank assumption, or
omission of a higher-corank chart occurs. Unit proofs lift to the original
97 equations by telescoping polynomial division, not a second GB search.
"""
import time


class AffinePrecondition:
    def __init__(self,model):
        from sage.all import matrix
        from atlas_native_rref import NativeRref
        self.model=model;self.ring=model.ring;self.steps=[];self.statistics=[]
        self.original=list(model.original);self.rows=list(self.original)
        self.low_count=64+model.chart+1;native=NativeRref(model.k)
        P=self.ring;v=P.gens()[:32];started=time.monotonic()
        def row_reduce():
            before=self.low_count;low=self.rows[:before];high=self.rows[before:]
            terms=[{tuple(ex):c for ex,c in f.dict().items()} for f in low]
            exponents=set(ex for d in terms for ex in d)
            def order(ex):
                degree=sum(ex)
                if degree>1:return (0,str(P({ex:1})))
                if degree==1:
                    pos=next(i for i,e in enumerate(ex) if e)
                    return (1 if pos<32 else 2,pos)
                return (3,0)
            exponents=sorted(exponents,key=order)
            M=matrix(model.k,[[d.get(ex,0) for ex in exponents] for d in terms],implementation='generic')
            A,C=native.rref(M)
            low=[P({ex:c for ex,c in zip(exponents,row) if c}) for row in A.rows()]
            self.steps.append(dict(kind='linear',matrix=C,low_before=before,high_count=len(high)))
            self.low_count=len(low);self.rows=low+high
            self.statistics.append(dict(rows_before=before,rank=len(low),columns=len(exponents)))
        row_reduce()
        for _ in range(33):
            if any(f and f.total_degree()==0 for f in self.rows):break
            pivots=[]
            for index,f in enumerate(self.rows[:self.low_count]):
                if f.total_degree()!=1:continue
                candidates=[z for z in v if f.monomial_coefficient(z)]
                if not candidates:continue
                z=candidates[0];cc=f.monomial_coefficient(z);g=-(f-cc*z)/cc
                pivots.append((index,z,g,cc))
            if not pivots:break
            eliminated={z for _,z,_,_ in pivots}
            assert len(eliminated)==len(pivots)
            assert all(not set(g.variables()).intersection(eliminated) for _,_,g,_ in pivots)
            substitutions={z:g for _,z,g,_ in pivots}
            images=[substitutions.get(z,z) for z in P.gens()]
            sub=P.hom(images,P)
            self.steps.append(dict(kind='substitution',before=list(self.rows),pivots=pivots))
            self.rows=[sub(f) for f in self.rows]
            row_reduce()
        else:raise RuntimeError('Affine elimination did not terminate')
        self.seconds=time.monotonic()-started

    def immediate_unit(self):
        for j,f in enumerate(self.rows):
            if f and f.total_degree()==0:
                weights=[self.ring.zero() for _ in self.rows];weights[j]=self.ring(1/f)
                return self.lift(weights)
        return None

    def lift(self,weights):
        P=self.ring;weights=list(weights)
        assert len(weights)==len(self.rows)
        assert sum((h*f for h,f in zip(weights,self.rows)),P.zero())==1
        for step in reversed(self.steps):
            if step['kind']=='linear':
                C=step['matrix'];n=step['low_before'];high=step['high_count']
                assert len(weights)==C.nrows()+high
                old=[P.zero() for _ in range(n)]
                for h,row in zip(weights[:C.nrows()],C.rows()):
                    if h:
                        for j,c in enumerate(row):
                            if c:old[j]+=h*c
                weights=old+weights[C.nrows():]
            else:
                before=step['before'];assert len(before)==len(weights)
                substitutions={z:g for _,z,g,_ in step['pivots']}
                sub=P.hom([substitutions.get(z,z) for z in P.gens()],P)
                assert all(sub(h)==h for h in weights)
                total=sum((h*f for h,f in zip(weights,before)),P.zero())
                assert sub(total)==1
                for index,z,g,cc in step['pivots']:
                    one=P.hom([g if variable==z else variable for variable in P.gens()],P)
                    after=one(total)
                    quotient,remainder=(total-after).quo_rem(z-g)
                    assert not remainder
                    weights[index]-=quotient/cc
                    total=after
                assert total==1
        self.model.verify_unit(weights)
        return weights
