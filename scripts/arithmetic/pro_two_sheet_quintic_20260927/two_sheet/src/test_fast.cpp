#include "ntt.hpp"
int main(){F::init();mt19937 rng(51791);for(int d:{1,8,31,32,80,381}){vector<F>c(d+1);for(F&x:c)x=F::raw(rng()%390625);c[d]=F(1);PF m(c);QE::setmod(m);for(int i=0;i<8;i++){vector<F>a(d),b(d);for(F&x:a)x=F::raw(rng()%390625);for(F&x:b)x=F::raw(rng()%390625);PF ap(a),bp(b);assert(fastmul(ap,bp)==ap*bp);assert((QE(ap)*QE(bp)).a==(ap*bp)%m);}cerr<<"fast multiplication and reduction dimension "<<d<<" passed\n";}
 QE::setmod(PF({F(1),F(1),F(1),F(1),F(1),F(1),F(1),F(1),F(1)}));for(int n:{2,3,8,13,24,26,39,96,156}){vector<QE>a(n);for(auto&z:a){vector<F>c(8);for(auto&x:c)x=F::raw(rng()%390625);z=QE(PF(c));}auto b=a;dft(b,false);dft(b,true);assert(a==b);}cerr<<"NTT inverses passed\n";
 for(int dx:{3,15,30}){Bi a,b;for(int i=0;i<dx;i++){PQ p,q;for(int j=0;j<3;j++){p.a.push_back(QE(F::raw(rng()%390625)));q.a.push_back(QE(F::raw(rng()%390625)));}a.a.push_back(p);b.a.push_back(q);}assert(bmul(a,b,40)==(a*b).trunc(40));}cerr<<"2D NTT versus direct multiplication passed\n";
}
