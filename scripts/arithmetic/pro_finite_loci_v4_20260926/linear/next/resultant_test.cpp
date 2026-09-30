#include "../src/residual.hpp"
#include "io_dft.hpp"
#include "resultant.hpp"
Poly mk(int n,int seed){if(n<0)return Poly();Poly a;for(int i=0;i<=n;i++)a.c.push_back(F::code((1789LL*i*i+3456*i+113LL*seed+123)%kfield::ORDER));if(!a.c.back())a.c.back()=F(1);a.trim();return a;}
int main(){try{input::init();int cases=0;for(int m=1;m<=9;m++)for(int n=1;n<=9;n++)for(int da=-1;da<=m;da++)for(int db=-1;db<=n;db++){
 auto a=mk(da,3+m+da),b=mk(db,29+n+db);F x=fixed_resultant(a,b,m,n),y=sylvester_resultant(a,b,m,n);if(x!=y)throw std::runtime_error("small fixed resultant degree drop mismatch");cases++;}
 for(int da:{-1,0,1,49,50,51,52,53})for(int db:{-1,0,1,51,52,53,54}){auto a=mk(da,73+da),b=mk(db,199+db);if(fixed_resultant(a,b,53,54)!=sylvester_resultant(a,b,53,54))throw std::runtime_error("large degree drop mismatch");cases++;}
 std::cout<<cases<<" fixed-degree cases, including every small degree-drop pattern and zero inputs, match independent Sylvester determinants. PASS\n";return 0;}catch(std::exception&e){std::cerr<<e.what()<<"\n";return 1;}}
