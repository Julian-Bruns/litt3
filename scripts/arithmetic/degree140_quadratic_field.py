"""Exact K[b]/(b^2-alpha), K=F_(5^8), for the remaining exceptional charts.

Codes are a+390625*c for a+c*b. No logarithm table for the large field
is used. The returned, fully verified K arithmetic supplies the base.
"""
def install(ff):
    q=390625; nonresidue=25
    base={name:getattr(ff,name) for name in ('add','mul','neg','inv','powf')}
    assert base['powf'](nonresidue,(q-1)//2)==4

    def add(a,b):
        return base['add'](a%q,b%q)+q*base['add'](a//q,b//q)
    def mul(a,b):
        a0,a1=a%q,a//q;b0,b1=b%q,b//q
        if not a1 and not b1:return base['mul'](a0,b0)
        c0=base['add'](base['mul'](a0,b0),base['mul'](nonresidue,base['mul'](a1,b1)))
        c1=base['add'](base['mul'](a0,b1),base['mul'](a1,b0))
        return c0+q*c1
    def neg(a):return base['neg'](a%q)+q*base['neg'](a//q)
    def sub(a,b):return add(a,neg(b))
    def inv(a):
        a0,a1=a%q,a//q
        norm=base['add'](base['mul'](a0,a0),base['neg'](base['mul'](nonresidue,base['mul'](a1,a1))))
        ni=base['inv'](norm)
        return base['mul'](a0,ni)+q*base['neg'](base['mul'](a1,ni))
    def powf(a,n):
        if n<0:a=inv(a);n=-n
        z=1
        while n:
            if n&1:z=mul(z,a)
            n//=2
            if n:a=mul(a,a)
        return z
    def sumf(xs):
        z=0
        for x in xs:z=add(z,x)
        return z
    functions={'add':add,'mul':mul,'neg':neg,'sub':sub,'inv':inv,
               'div':lambda a,b:mul(a,inv(b)), 'powf':powf,'sumf':sumf}
    for name,fun in functions.items():setattr(ff,name,fun)
    ff.ORDER=q*q
    assert mul(q,q)==25 and powf(q,q)==neg(q)
    # Deterministic arithmetic cross-checks supplement irreducibility, rather
    # than purporting to exhaust the large field.
    for i in range(1,80):
        a=(i*12917)%q+q*((i*3571)%q)
        b=(i*21101+3)%q+q*((i*1291+7)%q)
        c=(i*9091+11)%q+q*((i*523+17)%q)
        assert mul(a,inv(a))==1
        assert mul(a,add(b,c))==add(mul(a,b),mul(a,c))
        assert powf(a,q)==(a%q)+q*base['neg'](a//q)
    return base


CPP_BACKEND=r'''using F=uint64_t;
inline std::vector<int32_t> LG,EX;
inline std::vector<uint16_t> AD;
inline void loadfield(const std::string&path){
 LG.resize(390625);EX.resize(781248);AD.resize(390625);
 std::ifstream a(path+"/field_log.bin",std::ios::binary),b(path+"/field_exp.bin",std::ios::binary),c(path+"/field_add.bin",std::ios::binary);
 if(!a||!b||!c)throw std::runtime_error("missing generated field tables");
 a.read((char*)LG.data(),4*LG.size());b.read((char*)EX.data(),4*EX.size());c.read((char*)AD.data(),2*AD.size());
 if(LG[25]%2!=1)throw std::runtime_error("quadratic coefficient is not a nonsquare");
}
inline uint32_t ba(uint32_t a,uint32_t b){return AD[(a%625)*625+b%625]+625*AD[(a/625)*625+b/625];}
inline uint32_t bm(uint32_t a,uint32_t b){return a&&b?EX[LG[a]+LG[b]]:0;}
inline F add(F a,F b){return ba(a%390625,b%390625)+390625ULL*ba(a/390625,b/390625);}
inline F mul(F a,F b){
 if(a<390625&&b<390625)return bm(a,b);
 uint32_t a0=a%390625,a1=a/390625,b0=b%390625,b1=b/390625;
 return ba(bm(a0,b0),bm(25,bm(a1,b1)))+390625ULL*ba(bm(a0,b1),bm(a1,b0));
}
inline F neg(F a){return bm(4,a%390625)+390625ULL*bm(4,a/390625);}
inline F sub(F a,F b){return add(a,neg(b));}
inline F inv(F a){
 if(!a)throw std::runtime_error("division by zero");
 uint32_t a0=a%390625,a1=a/390625;
 uint32_t norm=ba(bm(a0,a0),bm(4,bm(25,bm(a1,a1))));
 if(!norm)throw std::runtime_error("invalid quadratic field element");
 uint32_t ni=EX[390624-LG[norm]];
 return bm(a0,ni)+390625ULL*bm(4,bm(a1,ni));
}
inline F divide(F a,F b){return mul(a,inv(b));}
inline F power(F a,int64_t n){
 if(n<0){a=inv(a);n=-n;}F z=1;
 while(n){if(n&1)z=mul(z,a);n>>=1;if(n)a=mul(a,a);}return z;
}
'''
