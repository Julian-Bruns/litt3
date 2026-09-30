#include "fft.hpp"
#include <chrono>
using namespace comp;
int main(){F::init();uint64_t state=92182917;auto rnd=[&](){state^=state<<13;state^=state>>7;state^=state<<17;return F(state%F::N);};
 for(int n:{1,2,3,4,6,13,26,312,313,626,10016,30048,390624}){
  auto ts=std::chrono::steady_clock::now();F w(F::exps[F::NN/n]);DFT f(n,w),g(n,w.inverse());std::vector<F>a(n);for(auto&v:a)v=rnd();auto b=f.apply(a),c=g.apply(b);F ni=F(n%5).inverse();for(int i=0;i<n;i++)assert(c[i]*ni==a[i]);
  int checks=n<=626?n:16;for(int j=0;j<checks;j++){int idx=n<=626?j:(int)(rnd().v%n);F q=w.pow(idx),z=0;for(int k=n-1;k>=0;k--)z=z*q+a[k];assert(b[idx]==z);}
  std::cout<<"{\"length\":"<<n<<",\"inverse_and_Horner_checks\":\"PASS\",\"seconds\":"<<std::chrono::duration<double>(std::chrono::steady_clock::now()-ts).count()<<"}"<<std::endl;
 }
}
