#define main buchberger_main
#include "groebner.cpp"
#undef main
#include <deque>
void initfield(const string&path){
 ifstream fl(path,ios::binary);fl.read((char*)EX.data(),EX.size()*4);fl.read((char*)LG.data(),LG.size()*4);if(!fl)abort();
 for(int a=0;a<625;a++){NE[a]=0;for(int p=1;p<625;p*=5)NE[a]+=((5-a/p%5)%5)*p;for(int b=0;b<625;b++){int c=0;for(int p=1;p<625;p*=5)c+=((a/p%5+b/p%5)%5)*p;AD[a][b]=c;}}
}
vector<Poly> readpolys(const string&path){
 ifstream inp(path);int n,ng;inp>>n>>ng;if(!inp)abort();NV=n;vector<Poly> fs;
 for(int j=0;j<ng;j++){int nt;inp>>nt;Work w;for(int k=0;k<nt;k++){int c;inp>>c;Mon m=0;for(int i=0;i<NV;i++){int e;inp>>e;m|=Mon(e)<<(8*i);}inc(w,m,c);}Poly f;for(auto a:w)f.t.push_back(a);fs.push_back(f);}
 return fs;
}

#ifndef FINITE_ALGEBRA_NO_MAIN
int main(int argc,char**argv){
 if(argc<5){cerr<<"usage finite_algebra field.bin input.txt gb.txt matrices.txt\n";return 2;}
 initfield(argv[1]);auto inp=readpolys(argv[2]);F=readpolys(argv[3]);G.clear();for(int i=0;i<(int)F.size();i++){if(F[i].t[0].second!=1)abort();G.insert(i);}
 for(auto f:inp){Work w;for(auto a:f.t)w[a.first]=a.second;auto z=nf(w,G,false);if(!z.t.empty()){cerr<<"input not zero\n";return 4;}}
 int np=0;
 for(int i:G)for(int j:G)if(i<j){
  Mon m=lcm(F[i].lm(),F[j].lm());Work w;
  for(auto [mm,c]:F[i].t)inc(w,mprod(mm,m-F[i].lm()),c);
  for(auto [mm,c]:F[j].t)inc(w,mprod(mm,m-F[j].lm()),neg(c));
  if(!nf(w,G,false).t.empty()){cerr<<"SPAIR_FAILURE "<<i<<" "<<j<<endl;return 5;}np++;
 }
 cerr<<"input reductions and all "<<np<<" S-pairs verified\n";
 set<Mon,Order> bases;deque<Mon> todo;bases.insert(0);todo.push_back(0);
 while(!todo.empty()){
  Mon m=todo.front();todo.pop_front();
  for(int i=0;i<NV;i++){Mon mm=mprod(m,(Mon(1)<<(8*i)));bool ok=true;for(int j:G)if(dvd(F[j].lm(),mm)){ok=false;break;}
   if(ok&&!bases.count(mm)){bases.insert(mm);todo.push_back(mm);if(bases.size()>10000){cerr<<"not finite within 10000\n";return 6;}}
  }
 }
 vector<Mon> bas(bases.rbegin(),bases.rend());map<Mon,int> ids;int n=bas.size();for(int i=0;i<n;i++)ids[bas[i]]=i;
 ofstream out(argv[4]);out<<NV<<" "<<n<<"\n";
 for(Mon m:bas){for(int i=0;i<NV;i++)out<<exponent(m,i)<<" ";out<<"\n";}
 for(int i=0;i<NV;i++){
  vector<vector<int>> mat(n,vector<int>(n));
  for(int j=0;j<n;j++){
   Work w;w[mprod(bas[j],(Mon(1)<<(8*i)))]=1;Poly z=nf(w,G,false);
   for(auto [m,c]:z.t){if(!ids.count(m))abort();mat[ids[m]][j]=c;}
  }
  for(auto row:mat){for(int c:row)out<<c<<" ";out<<"\n";}
 }
 cerr<<"finite algebra dimension="<<n<<" variables="<<NV<<" matrices written\n";
 return 0;
}

#endif
