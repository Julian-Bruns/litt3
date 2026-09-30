#include "../src/field.hpp"
using kfield::F;
#include "fast_dft.hpp"
int main(){try{kfield::init();for(int n:{13,78,312,313,1248,12207,97656,195312,390624}){
 F root=F::code(kfield::primitive).pow(kfield::N/n);int nc=n<2000?3:1;Rows a(n,std::vector<F>(nc));for(int i=0;i<n;i++)for(int j=0;j<nc;j++)a[i][j]=F::code((12345LL*i*i+17*i+31*j+4567)%kfield::ORDER);
 auto b=fdft(a,root,4);for(int k:{0,1,2,7,n-1,n/2})for(int c=0;c<nc;c++){F z,fac(1),step=root.pow(k);for(int j=0;j<n;j++){z+=a[j][c]*fac;fac*=step;}if(b[k][c]!=z)throw std::runtime_error("direct DFT mismatch");}
 auto aa=fdft(b,root.inv(),4);F iv=F(n).inv();for(int i=0;i<n;i++)for(int j=0;j<nc;j++)if(aa[i][j]*iv!=a[i][j])throw std::runtime_error("roundtrip");
 if(n<=1248&&dft(a,root)!=b)throw std::runtime_error("old DFT mismatch");std::cout<<"n="<<n<<" direct sums and full inverse PASS";if(n<=1248)std::cout<<"; old small-transform reference PASS";std::cout<<"\n";
 }return 0;}catch(std::exception&e){std::cerr<<e.what()<<"\n";return 1;}}
