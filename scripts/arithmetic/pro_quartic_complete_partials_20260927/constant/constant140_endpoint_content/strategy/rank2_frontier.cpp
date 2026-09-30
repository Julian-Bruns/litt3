// Exact global leading-two-column module over symbolic H,q.
#define FRONTIER_NO_MAIN
#include "frontier_complete.cpp"
#include <fstream>
std::map<std::pair<int,int>,BP> Wcache;
BP getW(int m,int t){if(m<0||m>6||t<0)return {};auto k=std::make_pair(m,t);if(!Wcache.count(k))Wcache[k]=wcoeff(m,140-t);return Wcache[k];}
BP frobB(const BP&a,int p){BP z(p*(a.size()-1)+1);for(int h=0;h<(int)a.size();h++)z[p*h]=frob(a[h],p);return trimB(z);}
int deficit[7]={0,2,3,4,7,9,11};
int multi3(int a,int b,int c){return a==c?1:(a==b||b==c?3:1);}
BP stop(int mu,int T){ // coefficient of A^3(A^2)^5; valid S/L^50 in range used
 BP out;
 for(int a=0;a<=6;a++)for(int b=a;b<=6;b++)for(int c=b;c<=6;c++)for(int d=0;d<=6;d++)for(int e=d;e<=6;e++){
  if(a+b+c+5*(d+e)!=mu)continue;
  int base=deficit[a]+deficit[b]+deficit[c]+5*(deficit[d]+deficit[e]);if(base>T)continue;
  int multi=multi3(a,b,c)*(d==e?1:2)%5,extra=T-base;
  for(int v=0;5*v<=extra;v++){
   BP pair;
   for(int vd=0;vd<=v;vd++)pair=addB(pair,mulB(getW(d,deficit[d]+vd),getW(e,deficit[e]+v-vd)));
   if(pair.empty())continue;pair=frobB(pair,5);BP triple;
   int left=extra-5*v;
   for(int va=0;va<=left;va++)for(int vb=0;vb<=left-va;vb++)triple=addB(triple,mulB(mulB(getW(a,deficit[a]+va),getW(b,deficit[b]+vb)),getW(c,deficit[c]+left-va-vb)));
   out=addB(out,scB(mulB(triple,pair),multi));
  }
 }
 return out;
}
bool divPsi(const BP&a,BP&ans){if(a.empty()){ans={};return true;}if(a.size()<2)return false;BP r=a,q(a.size()-1);Poly a1(std::vector<F>{0,299833,232505}),a0=a0poly();for(int h=int(a.size())-1;h>=1;h--){auto [d,rr]=divmod(r[h],a1);if(!rr.zero())return false;q[h-1]=d;r[h]=r[h]-d*a1;r[h-1]=r[h-1]-d*a0;}if(!r[0].zero())return false;ans=trimB(q);return true;}
std::array<int,3> normalize(std::vector<BP>&a){int hv=100000,qv=100000,ps=0;for(auto&b:a)for(int h=0;h<(int)b.size();h++)if(!b[h].zero()){hv=std::min(hv,h);for(int q=0;q<=b[h].deg();q++)if(b[h].at(q)){qv=std::min(qv,q);break;}}if(hv==100000)return {0,0,0};for(auto&b:a){if(b.empty())continue;b=BP(b.begin()+hv,b.end());for(auto&p:b)if(!p.zero())p=Poly(std::vector<F>(p.v.begin()+qv,p.v.end()));}
 while(true){std::vector<BP> z(a.size());bool ok=true;for(int i=0;i<(int)a.size();i++)if(!divPsi(a[i],z[i])){ok=false;break;}if(!ok)break;a=z;ps++;}return {hv,qv,ps};}
void info(const std::string&name,const BP&a){int qd=-1,terms=0;for(auto&p:a){qd=std::max(qd,p.deg());for(F c:p.v)terms+=(c!=0);}std::cout<<name<<" H_degree "<<int(a.size())-1<<" q_degree "<<qd<<" terms "<<terms<<std::endl;}
void outputBP(std::ofstream&out,const BP&a){for(int h=0;h<(int)a.size();h++)for(int q=0;q<=a[h].deg();q++)if(a[h].at(q))out<<h<<' '<<q<<' '<<a[h].at(q)<<'\n';out<<"END\n";}
#ifndef RANK_FRONTIER_NO_MAIN
int main(int argc,char**argv){try{ff::init();init_source();loadtable(argc>1?argv[1]:"inputs/E_records.tsv");std::map<std::pair<int,int>,BP>S;for(int T=71;T<=74;T++)for(int mu=(T==71?45:46);mu<=48;mu++){if(T<73&&mu==48)continue;S[{T,mu}]=stop(mu,T);info("S"+std::to_string(T)+"_"+std::to_string(mu),S[{T,mu}]);}
 F k=ff::mul(3,ff::div(270402,242747));if(!subB(S[{74,48}],scB(S[{73,48}],k)).empty())throw std::runtime_error("global degree-48 cancellation failed");std::vector<std::vector<BP>> rows;
 rows.push_back({S[{71,47}],S[{71,46}]});rows.push_back({S[{72,47}],S[{72,46}]});rows.push_back({subB(S[{74,47}],scB(S[{73,47}],k)),subB(S[{74,46}],scB(S[{73,46}],k))});
 rows.push_back({subB(mulB(S[{73,48}],S[{71,46}]),mulB(S[{71,47}],S[{73,47}])),subB(mulB(S[{73,48}],S[{71,45}]),mulB(S[{71,47}],S[{73,46}]))});
 std::string pref=argc>2?argv[2]:"build/rank2";std::ofstream out(pref+"_minors.dat");out<<"RANK2_MINORS_V1\n";
 std::vector<std::array<int,3>> rowunits;
 for(int i=0;i<(int)rows.size();i++){auto v=normalize(rows[i]);rowunits.push_back(v);std::cout<<"ROW "<<i<<" units_removed H "<<v[0]<<" q "<<v[1]<<" Psi "<<v[2]<<std::endl;info("c47",rows[i][0]);info("c46",rows[i][1]);}
 for(int i=0;i<4;i++)for(int j=i+1;j<4;j++){BP b=subB(mulB(rows[i][0],rows[j][1]),mulB(rows[i][1],rows[j][0]));std::vector<BP> z{b};auto v=normalize(z);out<<i<<' '<<j<<' '<<v[0]<<' '<<v[1]<<' '<<v[2]<<'\n';outputBP(out,z[0]);info("MINOR"+std::to_string(i)+std::to_string(j),z[0]);}
 std::ofstream ro(pref+"_rows.dat");ro<<"RANK2_ROWS_V2\n";for(int i=0;i<(int)rows.size();i++){ro<<"ROW "<<i<<' '<<rowunits[i][0]<<' '<<rowunits[i][1]<<' '<<rowunits[i][2]<<'\n';for(auto&b:rows[i])outputBP(ro,b);}
 std::cout<<"MATRIX GENERATED; RANK LOCUS NOT YET DECIDED; SQUARE LOCUS UNRESOLVED.\n";
}catch(std::exception&e){std::cerr<<e.what()<<std::endl;return 1;}return 0;}

#endif
