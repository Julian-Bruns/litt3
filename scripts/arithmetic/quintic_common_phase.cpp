// Complete diagnostic on five-label multisets with one phase at each end.
// This tests necessary moment equations only, not existence of covers.
#include "pro_quartic_complete_partials_20260927/quartic/continuation/src/pair_kernel.hpp"
#include <cassert>
using IX5=std::array<int,5>;
std::array<F,4> endpoint5(const IX5&a,int phase){
    std::array<F,4> r{};
    for(int i:a)for(int k=0;k<4;k++)r[k]=r[k]+labels[4*phase+i][k];
    return r;
}
void print5(const IX5&a){for(int i:a)std::cout<<i;}
int main(){
    init();init_labels();K ie=K::code(22).inverse();
    for(auto& a:labels)for(auto& f:a)f=f.times(ie);
    std::vector<IX5> ends;
    for(int a=0;a<4;a++)for(int b=a;b<4;b++)for(int c=b;c<4;c++)
    for(int d=c;d<4;d++)for(int e=d;e<4;e++)if(a!=e)ends.push_back({a,b,c,d,e});
    assert(ends.size()==52);
    uint64_t total=0,linear=0,quad=0,fourth=0,lower=0;
    std::array<uint64_t,5> ranks{};
    for(auto qi:ends){auto Q=endpoint5(qi,0);
      for(int ph=0;ph<29;ph++)for(auto hi:ends){auto H=endpoint5(hi,ph);++total;
        F A=Q[1],B=Q[0],C=H[0],D=H[1],W=A*D-B*C;
        K beta=K::code(5),one(1);
        std::array<F,4> cols={-A-D,-A.times(beta)-D.times(one-beta),B+C,B.times(one-beta)+C.times(beta)};
        auto af=solve(cols,W);if(!af.consistent)continue;++linear;++ranks[af.rank];
        if(af.rank<4){++lower;std::cout<<"LOWER ";print5(qi);std::cout<<' ';print5(hi);std::cout<<' '<<ph<<' '<<af.rank<<'\n';continue;}
        int qr=quadratic(af.p,cols,W);
        std::cout<<"LINEAR ";print5(qi);std::cout<<' ';print5(hi);std::cout<<' '<<ph;
        for(int x:af.p)std::cout<<' '<<x;std::cout<<' '<<qr<<'\n';
        if(qr)continue;++quad;
        K x(af.p[0],af.p[1]),y(af.p[2],af.p[3]);
        F eps=(D-F(x))/(B-F(y));
        assert(eps*(A-F(x.bar()))==C-F(y.bar()));
        if(eps.zero())continue;
        bool ok=eps*Q[2]+Q[3]==eps*F(x.frob(4))-F(y.bar().frob(1))
             &&H[2]+eps*H[3]==F(x.bar().frob(4))-eps*F(y.frob(1));
        if(ok)++fourth;
        std::cout<<"UNIQUE ";print5(qi);std::cout<<' ';print5(hi);std::cout<<' '<<ph<<' '<<ok<<" x "<<x.a<<','<<x.b<<" y "<<y.a<<','<<y.b<<'\n';
      }
    }
    std::cout<<"SUMMARY tested "<<total<<" linear "<<linear<<" lower "<<lower
        <<" unique_quadric "<<quad<<" unique_fourth "<<fourth<<" ranks";
    for(auto r:ranks)std::cout<<' '<<r;std::cout<<'\n';
    assert(total==78416);
    assert(linear==32 && lower==0 && quad==0);
}
