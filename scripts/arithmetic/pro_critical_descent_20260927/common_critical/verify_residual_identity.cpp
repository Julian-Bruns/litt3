// Polynomial identity proof: 624 distinct evaluations versus degree bound 460.
// Here X is the residual's polynomial variable, NOT the incidence point.
#define RESIDUAL_NO_MAIN
#include "residual.cpp"
int main(int argc,char**argv){
 if(argc!=5){cerr<<"usage verify_residual_identity field.bin factors.txt data_directory residual_directory\n";return 2;}
 initfield(argv[1]);string dir=argv[3],rdir=argv[4];
 ifstream f(argv[2]);int nf;f>>nf;vector<KP> facs;for(int i=0;i<nf;i++){int n;f>>n;KP v(n);for(int&c:v)f>>c;facs.push_back(v);}
 ifstream hfile(dir+"/shape_H.txt");int ns;hfile>>ns;KP h(ns);for(int&c:h)hfile>>c;
 ifstream funcs(dir+"/residual_functions.txt");int nfun;funcs>>nfun;for(int i=0;i<nfun;i++){string name;int n;funcs>>name>>n;Fun ff(n);for(auto&t:ff)funcs>>t.c>>t.h>>t.q>>t.x;funs[name]=ff;}
 // A weight of 3 on X and 10 on v is preserved by v^3=P(X)/q.
 // The abstract resultant's 55 monomials have weight at most 460,
 // so its cubic norm has X-degree at most 460. The other side below
 // has degree at most 45+140=185. 624>460.
 const int GRID=624;int rho=fp(25,MM/GRID),z=1;set<int> nodes;
 for(int i=0;i<GRID;i++){if(nodes.count(z))abort();nodes.insert(z);z=mul(z,rho);}if(z!=1)abort();
 for(int k=0;k<nf;k++){
  MOD=facs[k];ND=MOD.size()-1;HH=md(h,MOD);FROB.clear();E z={1};for(int j=0;j<ND;j++){FROB.push_back(z);z=eqshift(z,5);}specialize();
  ifstream in(rdir+"/residual_"+to_string(k)+".txt");int dd,nmu,nx;in>>dd>>nmu>>nx;if(dd!=ND||nmu!=7||nx!=141)abort();
  vector<vector<E>> coeff(7,vector<E>(141));for(auto&row:coeff)for(E&v:row){v.resize(ND);for(int&c:v)in>>c;trim(v);}if(!in)abort();
  for(int x:nodes){
   auto D=resultant(x);EP actual=norm(D);actual.resize(7);
   E t=eval("t",x);int t15=fp(t.empty()?0:t[0],15);
   for(int l=0;l<7;l++){
    E expected;for(int j=140;j>=0;j--)expected=ea(ec(expected,x),coeff[l][j]);expected=ec(expected,t15);
    if(expected!=actual[l]){cerr<<"IDENTITY_FAILURE factor="<<k<<" X_code="<<x<<" ell_degree="<<l<<endl;return 3;}
   }
  }
  cerr<<"RESIDUAL_POLYNOMIAL_IDENTITY_VERIFIED factor="<<k<<" extension_degree="<<ND<<" points="<<GRID<<" proven_degree_bound=460\n";
 }
 cerr<<"ALL_FIVE_FULL_RESIDUAL_IDENTITIES_VERIFIED\n";
}
