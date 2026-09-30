#define main unused_expansion_main
#include "expand.cpp"
#undef main
int main(int argc,char**argv){try{
 ff::init();if(argc!=3)throw std::runtime_error("usage: evaluate_full ROOT TEST_INPUT");std::string root=argv[1];Poly R=readpoly(root+"/build/Rcal.bin");Bounds b=bounds(R);std::ifstream in(argv[2]);E h,w,lambda;while(in>>h>>w>>lambda){
 E Hh=ff::mul(h,w),q=ff::pow(w,3),mu=ff::div(lambda,w);
 std::vector<E> hs(b.h+1),ms(b.m+1),qs(b.q1-b.q0+1);for(int j=0;j<=b.h;j++)hs[j]=ff::pow(Hh,j);for(int j=0;j<=b.m;j++)ms[j]=ff::pow(mu,j);for(int j=b.q0;j<=b.q1;j++)qs[j-b.q0]=j<0?ff::pow(ff::inv(q),-j):ff::pow(q,j);
 std::vector<E> out(b.x+1);for(auto&t:R){E v=ff::mul(t.c,ff::mul(hs[H(t.m)],ff::mul(ms[M(t.m)],qs[Qexp(t.m)-b.q0])));out[X(t.m)]=ff::add(out[X(t.m)],v);}
 std::cout<<h<<" "<<w<<" "<<lambda;for(auto c:out)std::cout<<" "<<c;std::cout<<"\n";
 }
}catch(const std::exception&e){std::cerr<<e.what()<<"\n";return 1;}return 0;}
