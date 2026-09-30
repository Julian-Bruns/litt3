// Minimal Hermite words, tested against the actual two endpoint labels.
#define KLEIN_FOUR_MINIMUM_WORD_NO_MAIN
#include "klein_four_minimum_word_endpoints.cpp"

F7 add(const F7&a,const F7&b){F7 c;for(int i=0;i<7;i++)c[i]=add25[a[i]][b[i]];return c;}
F7 neg(const F7&a){F7 c;for(int i=0;i<7;i++)c[i]=neg25[a[i]];return c;}
bool zero(const F7&a){for(int c:a)if(c)return false;return true;}
F7 scale(const F7&a,int v){F7 c;for(int i=0;i<7;i++)c[i]=mul25[a[i]][v];return c;}
F7 determinant(const std::vector<std::vector<F7>>&a){
 int n=a.size();F7 sum{};std::vector<int>p(n);for(int i=0;i<n;i++)p[i]=i;
 do{F7 v{};v[0]=1;int inv=0;for(int i=0;i<n;i++){v=mul(v,a[i][p[i]]);for(int j=i+1;j<n;j++)inv+=p[i]>p[j];}
  sum=add(sum,(inv%2)?neg(v):v);
 }while(std::next_permutation(p.begin(),p.end()));return sum;
}
int endpoint_norm(const F7&q,const F7&t){
 F7 a=power(q,29),b=power(t,29);
 if(a==scale(b,18))return 18;
 if(a==scale(b,11))return 11;
 return -1;
}
void work(int d){
 int N=13-2*d;Mask comb=(Mask(1)<<(N-1))-1,limit=Mask(1)<<28;
 long visited=0,reps=0,covered=0,zero_kernel=0,simple_end_zero=0,first=0,both=0,blind=0;
 while(comb<limit){Mask m=(comb<<1)|1;visited++;
  // Advance before any rejected-word continue, so every subset is visited once.
  Mask nextbit=comb&-comb,nextmask=comb+nextbit;
  comb=(((comb^nextmask)>>2)/nextbit)|nextmask;
  if(canonical(m)){
   reps++;covered+=orbit_normalized(m);
   std::array<std::array<int,29>,8>e{};e[0][0]=1;int used=0;Mask bits=m;
   while(bits){int r=__builtin_ctz(bits);bits&=bits-1;used++;
    for(int k=std::min(7,used);k>=1;k--)for(int i=0;i<29;i++)e[k][(i+r)%29]=(e[k][(i+r)%29]+e[k-1][i])%5;
   }
   std::array<F7,8>h{};for(int i=0;i<8;i++){h[i]=red(e[i]);if(i%2)h[i]=neg(h[i]);}
   auto hv=[&](int j)->F7{if(j<0||j>7)return F7{};return h[j];};
   std::vector<std::vector<F7>>mat(d,std::vector<F7>(d+1));
   for(int row=0;row<d;row++)for(int r=0;r<=d;r++)mat[row][r]=hv(7-2*d+row+r);
   std::vector<F7>ts(d+1);
   if(d==0)ts[0][0]=1;
   else for(int col=0;col<=d;col++){
    std::vector<std::vector<F7>>minor(d);
    for(int row=0;row<d;row++)for(int r=0;r<=d;r++)if(r!=col)minor[row].push_back(mat[row][r]);
    ts[col]=determinant(minor);if(col%2)ts[col]=neg(ts[col]);
   }
   bool allzero=true;for(auto&t:ts)if(!zero(t))allzero=false;
   if(allzero){zero_kernel++;continue;}
   for(int row=0;row<d;row++){
    F7 val{};for(int r=0;r<=d;r++)val=add(val,mul(mat[row][r],ts[r]));
    if(!zero(val))throw std::runtime_error("wrong cofactor kernel");
   }
   if(d && ((zero(ts[0])&&!zero(ts[1]))||(zero(ts[d])&&!zero(ts[d-1])))){
    simple_end_zero++;continue;
   }
   if(zero(ts[0])&&zero(ts[d])){blind++;continue;}
   F7 q0{},qinf{};
   for(int r=0;r<=d;r++){
    q0=add(q0,mul(ts[r],hv(6-2*d+r)));
    qinf=add(qinf,mul(ts[r],hv(7-d+r)));
   }
   qinf=neg(qinf);
   int c0=zero(ts[0])?0:endpoint_norm(q0,ts[0]);
   int cinf=zero(ts[d])?0:endpoint_norm(qinf,ts[d]);
   if(c0!=-1)first++;
   if(c0==-1||cinf==-1||(c0&&cinf&&c0!=cinf))continue;
   both++;std::cout<<"SURVIVOR d="<<d<<" roots=";Mask b=m;while(b){int r=__builtin_ctz(b);b&=b-1;std::cout<<r<<",";}
   std::cout<<" endpoint_norms="<<c0<<","<<cinf<<"\n";
  }
 }
 std::cout<<"d="<<d<<" complementary_nodes="<<N<<" normalized_subsets="<<visited<<" representatives="<<reps<<" covered="<<covered
  <<" zero_cofactor_kernel="<<zero_kernel<<" simple_end_zero="<<simple_end_zero<<" first_endpoint_orbits="<<first
  <<" both_endpoint_orbits="<<both<<" both_ends_double_zero="<<blind<<std::endl;
 if(covered!=visited||zero_kernel||simple_end_zero||first||both||blind)
  throw std::runtime_error("coverage, rank, or endpoint exclusion failed");
}
#ifndef KLEIN_FOUR_MINIMUM_WORD_ALL_NO_MAIN
int main(int argc,char**argv){try{
 init();D={4,6,23,9,5,23,8,1};
 int first=argc>1?std::stoi(argv[1]):1,last=argc>2?std::stoi(argv[2]):5;
 if(first<0||last>5||first>last)throw std::runtime_error("require 0 <= first <= last <= 5");
 for(int d=first;d<=last;d++)work(d);
 return 0;
 }catch(const std::exception&e){std::cerr<<e.what()<<"\n";return 1;}}
#endif
