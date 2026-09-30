// Exact length156 DFT over K=F_(5^8). All target products have degree<156.
// It is algebraic interpolation, not a field-valued parameter search.
#ifndef ROOT9_FOURIER_HPP
#define ROOT9_FOURIER_HPP
static constexpr int FN=156;
static std::array<F,FN> roots156;
void fourier_setup(){
 F z=F(25).pow(F::NN/FN);assert(z.pow(FN)==F(1));
 for(int p:{2,3,13})assert(z.pow(FN/p)!=F(1));roots156[0]=1;
 for(int i=1;i<FN;i++)roots156[i]=roots156[i-1]*z;
 assert(F(FN%5)==F(1));
}
MR times_constant(const MR&a,F k){MR b;if(!k)return b;for(int j=0;j<MRANK;j++){
 b.c[j].den=a.c[j].den;b.c[j].a=a.c[j].a.scale(k);b.c[j].b=a.c[j].b.scale(k);
 }return b;}
std::vector<MR> transform156(const std::vector<MR>&a,bool inverse=false,int count=FN){
 assert(a.size()<=FN&&count<=FN);std::vector<MR>b(count);
 #pragma omp parallel for schedule(dynamic,1)
 for(int k=0;k<count;k++){
  F z=roots156[inverse?(FN-k)%FN:k],p=1;MR sum;
  for(const auto&v:a){if(v)sum+=times_constant(v,p);p*=z;}
  sum.normalize();b[k]=std::move(sum);
 }
 return b;
}
std::vector<MR> convolution156(const std::vector<MR>&a,const std::vector<MR>&b,int count){
 assert(a.size()+b.size()-2<FN);auto av=transform156(a);auto bv=(&a==&b)?av:transform156(b);
 #pragma omp parallel for schedule(dynamic,1)
 for(int k=0;k<FN;k++)av[k]*=bv[k];
 return transform156(av,true,count);
}
Poly<MR> curve_norm156(const Curve<MR>&g,const MR&q){
 // Degree bounds for the accepted source after specializing the scale.
 assert(g.c[0].deg()<=46&&g.c[1].deg()<=43&&g.c[2].deg()<=40);
 auto a=transform156(g.c[0].c),b=transform156(g.c[1].c),c=transform156(g.c[2].c);auto qi=q.inverse();
 #pragma omp parallel for schedule(dynamic,1)
 for(int k=0;k<FN;k++){
  MR pq=times_constant(qi,PP.eval(roots156[k]));
  a[k]=(a[k].pow(3)+b[k].pow(3)*pq+c[k].pow(3)*pq* pq-times_constant(a[k]*b[k]*c[k]*pq,F(3)))*qi;
 }
 auto coeffs=transform156(a,true);
 for(int k=141;k<FN;k++)assert(!coeffs[k]);coeffs.resize(141);return Poly<MR>(std::move(coeffs));
}
#endif
