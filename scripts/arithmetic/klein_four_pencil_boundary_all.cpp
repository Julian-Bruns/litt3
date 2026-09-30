// Complete one-step Hermite boundary jet equations for d=1,...,6.
// Computes exact two-dimensional kernels; generated matches are necessary,
// not geometric realizations. Endpoint target closure is a safe superset.
#define KLEIN_FOUR_MINIMUM_WORD_NO_MAIN
#include "klein_four_minimum_word_endpoints.cpp"
#include <string>
F7 add7(const F7&a,const F7&b){F7 c{};for(int i=0;i<7;i++)c[i]=add25[a[i]][b[i]];return c;}
F7 sub7(const F7&a,const F7&b){F7 c{};for(int i=0;i<7;i++)c[i]=add25[a[i]][neg25[b[i]]];return c;}
F7 scale7(F7 a,int c){for(auto&x:a)x=mul25[x][c];return a;}
int pow25(int a,int n){int r=1;while(n){if(n&1)r=mul25[r][a];a=mul25[a][a];n>>=1;}return r;}
F7 det(const std::vector<std::vector<F7>>&a){
 int n=a.size();F7 ans{};if(!n){ans[0]=1;return ans;}
 std::vector<int>p(n);for(int i=0;i<n;i++)p[i]=i;
 do{F7 term{};term[0]=1;int neg=0;
  for(int i=0;i<n;i++){term=mul(term,a[i][p[i]]);for(int j=i+1;j<n;j++)neg^=(p[i]>p[j]);}
  ans=neg?sub7(ans,term):add7(ans,term);
 }while(std::next_permutation(p.begin(),p.end()));return ans;
}
struct Target{F7 lambda,nu,tau,upsilon;std::array<F7,7>ml,mt;};
struct Rat{F7 r,s,r2;};struct Quad{F7 a,b,c;};
#ifndef KLEIN_FOUR_PENCIL_BOUNDARY_NO_MAIN
int main(int argc,char**argv){try{
 if(argc!=4)throw std::runtime_error("usage: boundary targets.dat dmin dmax");
 int dmin=std::stoi(argv[2]),dmax=std::stoi(argv[3]);if(dmin<1||dmax>6||dmin>dmax)throw std::runtime_error("range");
 init();D={4,6,23,9,5,23,8,1};
 std::ifstream f(argv[1]);int nt;f>>nt;std::vector<Target>ts(nt);
 for(auto&t:ts){for(auto&a:t.lambda)f>>a;for(auto&a:t.nu)f>>a;for(auto&a:t.tau)f>>a;for(auto&a:t.upsilon)f>>a;
  for(int j=0;j<7;j++){F7 x{};x[j]=1;t.ml[j]=mul(t.lambda,x);t.mt[j]=mul(t.tau,x);}}
 F7 z{};z[1]=1;F7 one{};one[0]=1;
 std::array<F7,29>zs;zs[0]=one;for(int i=1;i<29;i++)zs[i]=mul(zs[i-1],z);
 std::vector<Rat>rats;std::vector<Quad>quads;
 int raw[2][3]={{10,15,0},{24,18,14}};
 for(int ff=0;ff<2;ff++)for(int k=0;k<29;k++){
  F7 rr=scale7(zs[(29-k)%29],ff?pow25(22,5):22);
  rats.push_back({rr,scale7(zs[3*k%29],ff?pow25(8,5):8),mul(rr,rr)});
  for(int i=0;i<2;i++)quads.push_back({scale7(zs[5*k%29],ff?pow25(raw[i][0],5):raw[i][0]),
    scale7(zs[4*k%29],ff?pow25(raw[i][1],5):raw[i][1]),scale7(zs[3*k%29],ff?pow25(raw[i][2],5):raw[i][2])});
 }
 for(int d=dmin;d<=dmax;d++){
  int N=14-2*d,m=d-1;Mask comb=(Mask(1)<<(N-1))-1,limit=Mask(1)<<28;
  long visited=0,reps=0,covered=0,nrh=0,rh=0,qh=0,zeros=0;
  while(comb<limit){
   Mask mask=(comb<<1)|1;visited++;
   Mask x=comb&-comb,y=comb+x;comb=(((comb^y)>>2)/x)|y;
   if(!canonical(mask))continue;
   reps++;covered+=orbit_normalized(mask);
   std::array<std::array<int,29>,15>e{};e[0][0]=1;int used=0,sum=0;Mask bits=mask;F7 alpha{};
   while(bits){int r=__builtin_ctz(bits);bits&=bits-1;sum+=r;used++;alpha=add7(alpha,zs[(29-r)%29]);
    for(int j=used;j>=1;j--)for(int i=0;i<29;i++)e[j][(i+r)%29]=(e[j][(i+r)%29]+e[j-1][i])%5;
   }
   std::array<F7,15>hs;for(int i=0;i<=N;i++)hs[i]=scale7(red(e[i]),i%2?4:1);
   auto h=[&](int i){return i>=0&&i<=N?hs[i]:F7{};};
   F7 c0=scale7(zs[(29-sum%29)%29],4);
   std::vector<std::vector<F7>>mat(m,std::vector<F7>(d+1));
   for(int i=0;i<m;i++)for(int j=0;j<=d;j++)mat[i][j]=h(8-2*d+i+j);
   std::vector<int>piv;int f0=-1,f1=-1;F7 den{};
   for(int a=0;a<=d&&den==F7{};a++)for(int b=a+1;b<=d&&den==F7{};b++){
    std::vector<int>p;for(int j=0;j<=d;j++)if(j!=a&&j!=b)p.push_back(j);
    std::vector<std::vector<F7>>block(m,std::vector<F7>(m));for(int i=0;i<m;i++)for(int j=0;j<m;j++)block[i][j]=mat[i][p[j]];
    F7 dd=det(block);if(dd!=F7{}){den=dd;piv=p;f0=a;f1=b;}
   }
   if(den==F7{})throw std::runtime_error("kernel rank dropped");
   std::array<std::vector<F7>,2>basis;
   for(int k=0;k<2;k++){
    int free=k?f1:f0;basis[k].assign(d+1,F7{});basis[k][free]=den;
    for(int col=0;col<m;col++){
     std::vector<std::vector<F7>>block(m,std::vector<F7>(m));
     for(int i=0;i<m;i++)for(int j=0;j<m;j++)block[i][j]=mat[i][j==col?free:piv[j]];
     basis[k][piv[col]]=scale7(det(block),4);
    }
   }
   F7 aa[2],bb[2],cc[2],dd[2];
   for(int k=0;k<2;k++){
    aa[k]=basis[k][0];cc[k]=basis[k][1];F7 q0{},q1{};
    for(int j=0;j<=d;j++){q0=add7(q0,mul(basis[k][j],h(7-2*d+j)));q1=add7(q1,mul(basis[k][j],h(6-2*d+j)));}
    bb[k]=scale7(mul(c0,q0),2);dd[k]=add7(mul(alpha,bb[k]),scale7(mul(c0,q1),2));
   }
   F7 delta=sub7(mul(aa[0],bb[1]),mul(aa[1],bb[0]));
   if(delta==F7{})throw std::runtime_error("endpoint map not invertible");
   F7 an=sub7(mul(cc[0],aa[1]),mul(cc[1],aa[0]));
   F7 bn=add7(sub7(sub7(mul(dd[1],aa[0]),mul(dd[0],aa[1])),mul(cc[0],bb[1])),mul(cc[1],bb[0]));
   F7 cn=sub7(mul(dd[0],bb[1]),mul(dd[1],bb[0]));
#ifdef KLEIN_FOUR_PENCIL_PROBE
   std::cout<<"PROBE "<<d<<" "<<mask;
   for(const auto&v:std::array<F7,4>{delta,an,bn,cn})for(int c:v)std::cout<<" "<<c;
   std::cout<<"\n";
   if(reps==8)break;
   continue;
#endif
   if(an==F7{})zeros++;
   for(int k=0;k<nt;k++){
    const auto&t=ts[k];bool ok=true;
    for(int i=0;i<7;i++){
     int v=0;for(int j=0;j<7;j++)v=add25[v][add25[mul25[t.ml[j][i]][delta[j]]][neg25[mul25[t.mt[j][i]][an[j]]]]];
     if(v!=bn[i]){ok=false;break;}
    }
    if(ok&&sub7(mul(delta,t.nu),mul(an,t.upsilon))==cn){nrh++;std::cout<<"MATCH kind=nr d="<<d<<" mask="<<mask<<" target="<<k<<"\n";}
   }
   for(int k=0;k<(int)quads.size();k++){
    const auto&t=quads[k];if(mul(t.a,delta)==an&&mul(t.b,delta)==bn&&mul(t.c,delta)==cn){qh++;std::cout<<"MATCH kind=quartic d="<<d<<" mask="<<mask<<" target="<<k<<"\n";}
   }
   for(int k=0;k<(int)rats.size();k++){
    const auto&t=rats[k];if(mul(delta,t.s)==add7(add7(mul(an,t.r2),mul(bn,t.r)),cn)){rh++;std::cout<<"MATCH kind=rational d="<<d<<" mask="<<mask<<" target="<<k<<"\n";}
   }
  }
  std::cout<<"TOTAL d="<<d<<" normalized_subsets="<<visited<<" representatives="<<reps<<" covered="<<covered<<" zero_quadratic="<<zeros<<" nonrational_hits="<<nrh<<" quartic_hits="<<qh<<" rational_hits="<<rh<<std::endl;
#ifndef KLEIN_FOUR_PENCIL_PROBE
  if(visited!=covered)throw std::runtime_error("incomplete coverage");
#endif
 }
 return 0;
 }catch(const std::exception&e){std::cerr<<e.what()<<"\n";return 1;}}
#endif
