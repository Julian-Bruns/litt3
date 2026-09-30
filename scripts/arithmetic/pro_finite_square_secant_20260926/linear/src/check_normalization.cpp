#define CLOSURE_LIBRARY
#include "closure_at_boundary.cpp"
int main(){try{initdata();
 for(F r:ROOTS){auto c=parametrize(r);F h=2,w=3,H=divi(h,w),q=fpow(w,3);auto orig=evaluate_source(c,h,w);auto normalized=normalized_source(c,H,q);
  for(int i=0;i<4;i++)for(int j=0;j<3;j++)assert(normalized[i].a[j]==scale(orig[i].a[j],fpow(w,j-1)));
  auto R=residual(r,orig);auto RC=normalized_residual(c,H,q);assert(R.size()==RC.size());
  for(unsigned j=0;j<R.size();j++)assert(RC[j]==scale(R[j],mul(fpow(q,13),fpow(w,j))));
  std::cout<<"PASS cube-root-free source and residual normalization r="<<r<<" H="<<H<<" q="<<q<<" (one exact validation fiber)\n";
 }
 return 0;}catch(const std::exception&e){std::cerr<<e.what()<<'\n';return 1;}}
