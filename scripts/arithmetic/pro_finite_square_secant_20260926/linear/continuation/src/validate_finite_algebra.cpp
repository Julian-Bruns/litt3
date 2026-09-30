// Independent specialization checks against the original, large residual.
#define SCALES_LIBRARY
#include "exceptional_scales.cpp"
int main(){try{initdata();
 // Karatsuba is checked against schoolbook over a nontrivial quotient algebra.
 qa::modulus=Poly(50);qa::modulus[0]=25;qa::modulus[1]=3;qa::modulus[49]=1;
 fa::AP a(37),b(45);for(int i=0;i<37;i++)for(int j=0;j<49;j++)a[i].push_back((i*1777+j*931+75)%CARD);for(int i=0;i<45;i++)for(int j=0;j<49;j++)b[i].push_back((i*751+j*541+31)%CARD);
 fa::AP school(81);for(int i=0;i<37;i++)for(int j=0;j<45;j++)school[i+j]=school[i+j]+qa::times(a[i],b[j]);fa::trim(school);assert(fa::times(a,b)==school);
 std::cout<<"PASS quotient-algebra Karatsuba against schoolbook degree 36 by 44, algebra degree 49\n";
 for(F r:ROOTS){auto c=parametrize(r);for(auto hw:std::vector<std::pair<F,F>>{{2,3},{25,2}}){F h=hw.first,w=hw.second,H=divi(h,w),q=fpow(w,3);qa::modulus={neg(q),1};auto Rnew=fa::residual(c,Poly{H});auto s=evaluate_source(c,h,w);auto R=residual(r,s,false);for(unsigned l=0;l<R.size();l++){R[l]=scale(R[l],mul(fpow(q,13),fpow(w,l)));assert(Rnew[l]==fa::scalar(R[l]));}
 auto[e71,e72]=fa::errors71_72(Rnew);auto j=full_root(R,72);assert(e71==fa::scalar(j[71]));assert(e72==fa::scalar(j[72]));std::cout<<"PASS small normalized residual vs original large norm and root recurrence r="<<r<<" h="<<h<<" w="<<w<<'\n';}}
 return 0;}catch(const std::exception&e){std::cerr<<e.what()<<'\n';return 1;}}
