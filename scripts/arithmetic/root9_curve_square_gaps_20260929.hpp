// Regular-root necessary conditions on X, not merely square cubic norms.
// This transfers the pole-semigroup construction of primitive140 §67.
// The coordinate x=q*T^-3, z=q^3*T^-10*Y(T^3/q), z^3=P/q,
// avoids adjoining any cube root of the moving coefficient q.
#ifndef ROOT9_CURVE_SQUARE_GAPS_HPP
#define ROOT9_CURVE_SQUARE_GAPS_HPP
void curve_square_gaps(const Curve<MR>&g,const MR&q,const std::string&prefix){
 constexpr int N=75,L=25;std::vector<F>yc(L);yc[0]=1;
 for(int n=1;n<L;n++){
  F old=0;for(int i=0;i<n;i++)for(int j=0;j<n;j++){
   int k=n-i-j;if(k>=0&&k<n)old+=yc[i]*yc[j]*yc[k];
  }
  yc[n]=F(2)*(PP[10-n]-old);
 }
 std::array<std::vector<F>,3>ys;for(auto&v:ys)v.resize(L);ys[0][0]=1;ys[1]=yc;
 for(int i=0;i<L;i++)for(int j=0;i+j<L;j++)ys[2][i+j]+=yc[i]*yc[j];
 MR qi=q.inverse();std::vector<MR>qp{MR(1)};for(int i=1;i<=L;i++)qp.push_back(qp.back()*qi);
 std::vector<MR>a(N);
 for(int n=0;n<N;n++)for(int j=0;j<3;j++)if((140-10*j-n)%3==0){
  int power=(2-j-n)/3;assert(power<=0&&-power<=L);
  for(int l=0;l<L;l++){
   int k=(140-10*j+3*l-n)/3;
   if(k>=0&&k<=g.c[j].deg()&&ys[j][l])a[n]+=g.c[j][k]*MR(ys[j][l]);
  }
  a[n]*=qp[-power];a[n].normalize();
 }
 auto mul=[&](const std::vector<MR>&u,const std::vector<MR>&v){std::vector<MR>r(N);
  #pragma omp parallel for schedule(dynamic,1)
  for(int n=0;n<N;n++){for(int i=0;i<=n;i++)if(u[i]&&v[n-i])r[n]+=u[i]*v[n-i];r[n].normalize();}return r;};
 auto frob=[&](const std::vector<MR>&v,int e){std::vector<MR>r(N);for(int i=0;e*i<N;i++)r[e*i]=v[i].pow(e);return r;};
 stats("curve_series",a);auto a2=mul(a,a);stats("curve_a2",a2);auto a3=mul(a2,a);stats("curve_a3",a3);
 auto a13=mul(a3,frob(a2,5));stats("curve_a13",a13);auto c=mul(a13,frob(a2,25));stats("curve_a63",c);
 std::vector<int>indices;std::vector<MR>gaps;
 for(int n=0;n<N;n++){
  int pole=70-n,j=-1;
  if(pole>=0)for(int k=0;k<3;k++)if(pole>=10*k&&(pole-10*k)%3==0){j=k;break;}
  if(j<0){indices.push_back(n);gaps.push_back(c[n]);}
  else for(int l=1;n+3*l<N;l++)if(ys[j][l])c[n+3*l]-=c[n]*MR(ys[j][l])*qp[l];
 }
 std::ofstream out(prefix+".curve_gaps.json");out<<"{\"scope\":\"Necessary regular-root conditions for squareness ON X; not necessary for a nontrivial unramified quadratic character.\",\"indices\":[";
 for(size_t i=0;i<indices.size();i++){if(i)out<<',';out<<indices[i];}out<<"],\"rows\":[";
 for(size_t i=0;i<gaps.size();i++){if(i)out<<',';save_mr(out,gaps[i]);}out<<"]}\n";
 std::cout<<"CURVE_GAPS_SAVED "<<indices.size()<<std::endl;
}
#endif
