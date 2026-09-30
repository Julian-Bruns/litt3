#define main inherited_resultants_main
#include "fiber_resultants.cpp"
#undef main
int main(){try{init_curve();addtab.resize(625*625);for(F a=0;a<625;a++)for(F b=0;b<625;b++)addtab[a*625+b]=FF::add(a,b);negate.resize(FF::N);for(F a=0;a<FF::N;a++)negate[a]=FF::neg(a);std::mt19937 gen(582871);int checked=0,drops=0;
for(int da=1;da<=9;da++)for(int db=1;db<=9;db++)for(int mode=0;mode<5;mode++){Poly a(da+1),b(db+1);for(auto&v:a)v=gen()%FF::N;for(auto&v:b)v=gen()%FF::N;if(mode==1)a.back()=0;if(mode==2)b.back()=0;if(mode==3){a.back()=0;b.back()=0;}if(mode==4){a=Poly{1};b=Poly{0,1};}a.trim();b.trim();if(a.deg()<da||b.deg()<db)drops++;F r=resultant(a,b,da,db),s=fixed_resultant(a,b,da,db);if(r!=s)throw std::runtime_error("Euclidean vs Sylvester mismatch");checked++;}
std::cout<<"PASS: "<<checked<<" exact fast-resultant/direct-Sylvester comparisons, including "<<drops<<" fixed-degree drops. Bounded implementation tests, not additional geometric exclusions.\n";return 0;}catch(const std::exception&e){std::cerr<<"FAIL: "<<e.what()<<"\n";return 1;}}
