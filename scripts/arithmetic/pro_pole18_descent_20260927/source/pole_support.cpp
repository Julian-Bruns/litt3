// Exhaustive Hermite pole-support obstruction in F_(5^14)=F25[xi].
// Tests C^2 | A+t^12 B with deg A,deg B<=s, ord_0 A>=3, ord_0 B>=2,
// for each s-point subset of mu29, modulo multiplication by mu29.
// Full column rank rules out every geometric coefficient solution.
#include <cstdint>
#include <vector>
#include <iostream>
#include <array>
#include <algorithm>
#include <cstdlib>
#include <chrono>
#ifdef _OPENMP
#include <omp.h>
#endif
union F {std::uint64_t z; std::uint8_t a[8]; F(std::uint64_t x=0):z(x){} };
std::uint8_t ADD[25][25],SUB[25][25],MUL[25][25];
const int MOD[7]={4,6,23,9,5,23,8};
F powers[29];
inline F add(F x,F y){F o;for(int i=0;i<7;++i)o.a[i]=ADD[x.a[i]][y.a[i]];return o;}
inline F sub(F x,F y){F o;for(int i=0;i<7;++i)o.a[i]=SUB[x.a[i]][y.a[i]];return o;}
inline F neg(F x){F o;for(int i=0;i<7;++i)o.a[i]=SUB[0][x.a[i]];return o;}
inline F scale(F x,int c){F o;for(int i=0;i<7;++i)o.a[i]=MUL[c][x.a[i]];return o;}
inline F mul(F x,F y){
 if(!x.z||!y.z)return F();if(x.z==1)return y;if(y.z==1)return x;
 std::uint8_t a[13]={};
 for(int i=0;i<7;++i)if(x.a[i])for(int j=0;j<7;++j)if(y.a[j])a[i+j]=ADD[a[i+j]][MUL[x.a[i]][y.a[j]]];
 for(int d=12;d>=7;--d)if(a[d]){int v=a[d];for(int j=0;j<7;++j)a[d-7+j]=SUB[a[d-7+j]][MUL[v][MOD[j]]];}
 F o;for(int i=0;i<7;++i)o.a[i]=a[i];return o;
}
inline F phase_mul(F x,int e){
 F out;for(int i=0;i<7;++i)if(x.a[i]){F p=powers[(e+i)%29];for(int j=0;j<7;++j)out.a[j]=ADD[out.a[j]][MUL[x.a[i]][p.a[j]]];}return out;
}
F power(F x,std::uint64_t n){F r(1);while(n){if(n&1)r=mul(r,x);n>>=1;if(n)x=mul(x,x);}return r;}
void init(){
 for(int a=0;a<25;++a)for(int b=0;b<25;++b){
  ADD[a][b]=(a%5+b%5)%5+5*((a/5+b/5)%5);
  SUB[a][b]=(a%5-b%5+5)%5+5*((a/5-b/5+5)%5);
  MUL[a][b]=((a%5)*(b%5)+3*(a/5)*(b/5))%5+5*(((a%5)*(b/5)+(a/5)*(b%5)+(a/5)*(b/5))%5);
 }
 F xi;xi.a[1]=1;powers[0]=F(1);
 for(int i=1;i<29;++i)powers[i]=mul(powers[i-1],xi);
 if(mul(powers[28],xi).z!=1){std::cerr<<"bad field/order\n";std::exit(2);}
 for(int i=0;i<29;++i)for(int j=0;j<29;++j)if(mul(powers[i],powers[j]).z!=powers[(i+j)%29].z){std::cerr<<"phase multiplication error\n";std::exit(2);}
 for(int i=1;i<=20;++i){F x;for(int j=0;j<7;++j)x.a[j]=(i*7+j*11+i*j)%25;
  if(x.z&&power(x,6103515624ULL).z!=1){std::cerr<<"field self-check error\n";std::exit(2);}
 }
}
constexpr std::uint32_t ALL=(1U<<29)-1;
bool canonical(std::uint32_t m){for(int j=1;j<29;++j)if(m&(1U<<j)){auto r=((m>>j)|(m<<(29-j)))&ALL;if(r<m)return false;}return true;}
void masks_rec(int left,int start,std::uint32_t m,std::vector<std::uint32_t>&out){
 if(!left){if(canonical(m))out.push_back(m);return;}
 for(int j=start;j<=29-left;++j)masks_rec(left-1,j+1,m|(1U<<j),out);
}
int rank_matrix(F mat[12][9],int nr,int nc){
 int r=0;
 for(int c=0;c<nc;++c){int p=r;while(p<nr&&!mat[p][c].z)++p;if(p==nr)continue;
  if(p!=r)for(int j=c;j<nc;++j)std::swap(mat[p][j],mat[r][j]);
  F pivot=mat[r][c];
  for(int i=r+1;i<nr;++i)if(mat[i][c].z){F x=mat[i][c];for(int j=c+1;j<nc;++j)mat[i][j]=sub(mul(pivot,mat[i][j]),mul(x,mat[r][j]));mat[i][c]=F();}
  ++r;if(r==nc)return r;
 }
 return r;
}
int test(std::uint32_t mask,int s){
 F C[10]={};C[0]=F(1);int deg=0;
 for(int e=0;e<29;++e)if(mask&(1U<<e)){
  F N[10]={};for(int j=0;j<=deg;++j){N[j]=sub(N[j],phase_mul(C[j],e));N[j+1]=add(N[j+1],C[j]);}
  ++deg;for(int j=0;j<=deg;++j)C[j]=N[j];
 }
 F D[19]={};for(int i=0;i<=s;++i)for(int j=i;j<=s;++j){F x=mul(C[i],C[j]);if(i!=j)x=scale(x,2);D[i+j]=add(D[i+j],x);}
 const int d=2*s, maxe=12+s;
 F rem[22][18]={};for(int e=0;e<d;++e)rem[e][e]=F(1);
 for(int e=d;e<=maxe;++e){F lead=rem[e-1][d-1];for(int j=0;j<d;++j)rem[e][j]=sub(j?rem[e-1][j-1]:F(),mul(lead,D[j]));}
 F mat[12][9]={};int nr=0;
 for(int j=d-1;j>s;--j){for(int b=2;b<=s;++b)mat[nr][b-2]=rem[12+b][j];++nr;}
 for(int j=0;j<3;++j){for(int b=2;b<=s;++b)mat[nr][b-2]=rem[12+b][j];++nr;}
 // A is the negative of the allowed coefficients (degrees 3 through s).
 return rank_matrix(mat,nr,s-1);
}
void printmask(std::uint32_t m){std::cout<<"[";for(int j=0;j<29;++j)if(m&(1U<<j))std::cout<<j<<",";std::cout<<"]";}
int main(int argc,char**argv){
 init();int lo=argc>1?std::atoi(argv[1]):3,hi=argc>2?std::atoi(argv[2]):9;
 if(lo<3||hi>9||lo>hi)return 2;
 const std::uint64_t expected[10]={0,0,0,126,819,4095,16380,53820,148005,345345};
 std::uint64_t total_bad=0;
 for(int s=lo;s<=hi;++s){std::vector<std::uint32_t> masks;masks_rec(s-1,1,1,masks);
  if(masks.size()!=expected[s]){std::cerr<<"orbit count mismatch\n";return 2;}
  std::uint64_t bad=0;auto start=std::chrono::steady_clock::now();
  #pragma omp parallel for reduction(+:bad) schedule(dynamic,128)
  for(std::size_t i=0;i<masks.size();++i){int r=test(masks[i],s);if(r<s-1){++bad;
    #pragma omp critical
    {std::cout<<"KERNEL s="<<s<<" mask="<<masks[i]<<" rank="<<r<<" roots=";printmask(masks[i]);std::cout<<"\n";}
  }}
  total_bad+=bad;
  double secs=std::chrono::duration<double>(std::chrono::steady_clock::now()-start).count();
  std::cout<<"s="<<s<<" canonical_supports="<<masks.size()<<" full_rank="<<(masks.size()-bad)<<" kernel_supports="<<bad<<" elapsed_seconds="<<secs<<"\n"<<std::flush;
 }
 std::cout<<"TOTAL_KERNEL_SUPPORTS="<<total_bad<<"\n";
 return total_bad ? 1 : 0; // Any deficient support fails the claimed certificate.
}
