#include "point_io.hpp"
using namespace alg;
F ae(const Ar&a,F x,F y){return add(add(eval(a[0],x),mul(eval(a[1],x),y)),mul(eval(a[2],x),mul(y,y)));}
F determinant(vector<vector<F>> M){int n=M.size();F d=1;for(int j=0;j<n;j++){int k=j;while(k<n&&!M[k][j])k++;if(k==n)return 0;if(k!=j){swap(M[k],M[j]);d=neg(d);}F pivot=M[j][j];d=mul(d,pivot);for(int i=j+1;i<n;i++)if(M[i][j]){F c=alg::div(M[i][j],pivot);for(int l=j;l<n;l++)M[i][l]=sub(M[i][l],mul(c,M[j][l]));}}return d;}
F scalar_res(const vector<F>&f,const array<F,3>&d){vector<vector<F>>M(12,vector<F>(12));for(int row=0;row<2;row++)for(int i=0;i<=10;i++)M[row][row+i]=f[10-i];for(int row=0;row<10;row++)for(int i=0;i<=2;i++)M[row+2][row+i]=d[2-i];return determinant(M);}
int main(int argc,char**argv){try{
 init();if(argc!=2)throw runtime_error("usage audit data_dir");string dir=argv[1];mt19937 rng(847629);
 for(int i=0;i<10000;i++){F a=rng()%q,b=rng()%q;if(mul(a,b)!=rawmul(a,b))throw runtime_error("log multiplication disagrees with raw polynomial arithmetic");if(a&&mul(a,inv(a))!=1)throw runtime_error("inverse");}
 if(gcd(A,derivative(A))!=Poly{1}||gcd(P,derivative(P))!=Poly{1}||gcd(A,P)!=Poly{1})throw runtime_error("squarefree/coprime input check");
 Poly t=scale(exact(A,Poly{neg(25),1}),inv(13));
 vector<F> xs;for(F x=0;xs.size()<4&&x<q;x++){F p=eval(P,x);if(p&&eval(t,x)&&logs[p]%3==0)xs.push_back(x);}
 if(xs.size()!=4)throw runtime_error("not enough audit x coordinates");
 int comparisons=0;
 for(int cid=0;cid<=10;cid++){
  Fam fam=readfam(dir+"/space_"+to_string(cid)+".txt");vector<F>z{1,1,1,1,1,1,1};Pt p=point(fam,z);
  if(pole(p.D2)!=(cid?13:12))throw runtime_error("audit point not open");
  auto fp=fpoly(p,t);array<Ar,3>dp={p.N[4],ac(p.N[3],2),ac(p.N[2],3)};
  Ar ar=resultant_dp(fp,dp);
  if(cid==0||cid==1){Ar ar2=resultant_quadratic(fp,dp[2],dp[1],dp[0]);if(ar!=ar2)throw runtime_error("two global resultant algorithms disagree");}
  Poly nr=norm(ar);Poly R=residual(p,t,cid,fam.r);Poly den=pm(pp(P,40),pp(t,15));if(cid)den=pm(den,pp(Poly{neg(fam.r),1},3));if(pm(R,den)!=nr)throw runtime_error("residual product identity");
  for(F x:xs){F y=exps[logs[eval(P,x)]/3],zeta=exps[qm/3],product=1;
   for(int j=0;j<3;j++){
    vector<F>f(11);for(int i=0;i<11;i++)f[i]=ae(fp[i],x,y);array<F,3>d;for(int i=0;i<3;i++)d[i]=ae(dp[i],x,y);
    F r=scalar_res(f,d);if(r!=ae(ar,x,y))throw runtime_error("scalar Gaussian determinant != polynomial subset determinant");product=mul(product,r);y=mul(y,zeta);comparisons++;
   }
   if(product!=eval(nr,x))throw runtime_error("cubic norm not product of conjugates");
  }
  // Boundary-aware square checker unit tests, including constants, odd degree,
  // leading coefficient nonsquares in the coefficient field, and p-th powers.
 }
 for(int i=0;i<50;i++){Poly j(i%16+1);for(F&a:j)a=rng()%q;if(!j.back())j.back()=1;Poly sq=scale(pm(j,j),25);if(!squaretest(sq).first)throw runtime_error("square detector missed geometric square");}
 if(squaretest({}).first||squaretest(Poly{1,1}).first||!squaretest(Poly{25}).first)throw runtime_error("boundary square checker");
 cout<<"PASS 10000 raw/log field products and inverses\nPASS A,P squarefree and coprime\nPASS two independent global resultant algorithms, cases 0 and 1\nPASS "<<comparisons<<" scalar Gaussian-vs-subset determinant comparisons\nPASS 44 cubic norm product checks and 11 exact residual product identities\nPASS 53 square-checker boundary/unit tests\n";
 }catch(exception&e){cerr<<"ERROR: "<<e.what()<<"\n";return 1;}}
