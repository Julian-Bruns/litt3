// Polynomial row identity for all central x coefficients of the actual residual.
// All coefficient arithmetic is in K[u]; q is reduced only by the monic input g.
#include "field.cpp"
#include <fstream>
#include <chrono>
struct MR {vector<KP> a;int deg=-1,pos=-1;void lead(){deg=-1;pos=-1;for(int j=0;j<(int)a.size();j++)if(!a[j].empty()&&(int)a[j].size()-1>=deg){deg=(int)a[j].size()-1;pos=j;}}};
struct ME {int i,j;KP q;bool sw;};
static vector<KP> mg;
static vector<KP> Qmult(const vector<KP>&a){vector<KP>b(9);for(int j=0;j<9;j++)b[j]=psub(j?a[j-1]:KP(),pmul(a[8],mg[j]));return b;}
static bool redtarget(MR &v,const vector<MR>&r,const vector<int>&own,vector<pair<int,KP>>&trace){
 v.lead();while(v.pos>=0){int pos=v.pos,j=own[pos];if(j<0||v.deg<r[j].deg)return false;
 auto qr=pdiv(v.a[pos],r[j].a[pos]);if(qr.first.empty())return false;
 for(int c=0;c<(int)v.a.size();c++)v.a[c]=psub(v.a[c],pmul(qr.first,r[j].a[c]));
 trace.push_back({j,qr.first});v.lead();}return true;}
extern "C" int lacunary_certificate(const int*raw,int n,const int*gs,int maxpower,int*out,int cap,int*stats){
 try {ff_init();ED=1;EM={0,1};const int nc=63,nx=109,nr=nx*9;mg.assign(10,KP(3));for(int j=0;j<10;j++){for(int i=0;i<3;i++)mg[j][i]=gs[j*3+i];trim(mg[j]);}
 vector<MR>rs(nr);for(int x=16;x<=124;x++){
 vector<vector<KP>>poly(7,vector<KP>(9,KP(n)));
 for(int s=0;s<7;s++)for(int j=0;j<9;j++){for(int i=0;i<n;i++)poly[s][j][i]=raw[(((size_t)i*7+s)*141+x)*9+j];trim(poly[s][j]);}
 for(int b=0;b<9;b++){MR&r=rs[(x-16)*9+b];r.a.resize(nc);for(int s=0;s<7;s++)for(int j=0;j<9;j++)r.a[s*9+j]=poly[s][j];r.lead();for(auto &v:poly)v=Qmult(v);}}
 vector<int>own(nc,-1);vector<ME>tr;long reductions=0;int done=0,chosen=-1;vector<pair<int,KP>>soltrace;
 // A target d(q)^power, with d's exact coefficients passed in stats[8:10].
 int d0=stats[8],d1=stats[9];vector<vector<KP>>targets(maxpower+1,vector<KP>(9));targets[0][0]={1};
 for(int e=1;e<=maxpower;e++){auto q=Qmult(targets[e-1]);for(int j=0;j<9;j++)targets[e][j]=padd(pscale(targets[e-1][j],d0),pscale(q[j],d1));}
 for(int i=0;i<nr;i++){
 while(rs[i].pos>=0){int p=rs[i].pos,j=own[p];if(j<0){own[p]=i;break;}
 if(rs[i].deg<rs[j].deg){swap(rs[i],rs[j]);tr.push_back({i,j,{},true});}
 auto qr=pdiv(rs[i].a[p],rs[j].a[p]);if(qr.first.empty())throw runtime_error("row quotient empty");
 for(int c=0;c<nc;c++)rs[i].a[c]=psub(rs[i].a[c],pmul(qr.first,rs[j].a[c]));
 rs[i].lead();tr.push_back({i,j,qr.first,false});reductions++;
 }
 done=i+1;
 if(i%9==8||i==nr-1){
 int rank=0,ds=0;for(int j:own)if(j>=0){rank++;ds+=rs[j].deg;}
 fprintf(stderr,"lacunary rows %d rank %d sumdegree %d reductions %ld events %zu\n",done,rank,ds,reductions,tr.size());fflush(stderr);
 // The unlocalized identity d^e avoids discarding any companion q-sheet.
 for(int e=0;e<=maxpower;e++) {MR vv;vv.a.resize(nc);for(int j=0;j<9;j++)vv.a[j]=targets[e][j];vector<pair<int,KP>>st;
 if(redtarget(vv,rs,own,st)){chosen=e;soltrace=move(st);break;}}
 if(chosen>=0)break;
 }
 }
 if(chosen<0){stats[0]=done;stats[1]=reductions;return 1;}
 vector<KP>co(done);for(auto &ev:soltrace)co[ev.first]=padd(co[ev.first],ev.second);
 for(auto it=tr.rbegin();it!=tr.rend();++it){if(it->sw)swap(co[it->i],co[it->j]);else if(!co[it->i].empty())co[it->j]=psub(co[it->j],pmul(co[it->i],it->q));}
 int md=0,nz=0;for(const KP&p:co){md=max(md,(int)p.size()-1);nz+=p.size();}if(md>=cap){stats[0]=done;stats[1]=md;return -3;}
 fill(out,out+(size_t)nr*cap,0);for(int i=0;i<done;i++)copy(co[i].begin(),co[i].end(),out+(size_t)i*cap);
 stats[0]=done;stats[1]=reductions;stats[2]=chosen;stats[3]=md;stats[4]=tr.size();stats[5]=nz;
 return 0;
 }catch(const exception&e){fprintf(stderr,"lacunary module: %s\n",e.what());return -2;}}

extern "C" int late_linear_certificate(const int*raw,int n,const int*gs,int maxpower,int*out,int cap,int*stats){
 try {ff_init();ED=1;EM={0,1};const int nc=63,nx=8,nr=nx*9;mg.assign(10,KP(3));for(int j=0;j<10;j++){for(int i=0;i<3;i++)mg[j][i]=gs[j*3+i];trim(mg[j]);}
 vector<MR>rs(nr);for(int x=117;x<=124;x++){
 vector<vector<KP>>poly(7,vector<KP>(9,KP(n)));
 for(int s=0;s<7;s++)for(int j=0;j<9;j++){for(int i=0;i<n;i++)poly[s][j][i]=raw[(((size_t)i*7+s)*141+x)*9+j];trim(poly[s][j]);}
 for(int b=0;b<9;b++){MR&r=rs[(x-117)*9+b];r.a.resize(nc);for(int s=0;s<7;s++)for(int j=0;j<9;j++)r.a[s*9+j]=poly[s][j];r.lead();for(auto &v:poly)v=Qmult(v);}}
 vector<int>own(nc,-1);vector<ME>tr;long reductions=0;int done=0,chosen=-1;vector<pair<int,KP>>soltrace;
 // Powers of the actual leading coefficient, a unit on the original open.
 vector<KP> lc(9,KP(n));for(int j=0;j<9;j++){for(int i=0;i<n;i++)lc[j][i]=raw[(((size_t)i*7)*141+140)*9+j];trim(lc[j]);}
 auto prod=[&](const vector<KP>&a,const vector<KP>&b){vector<KP> p(17);for(int i=0;i<9;i++)for(int j=0;j<9;j++)p[i+j]=padd(p[i+j],pmul(a[i],b[j]));for(int d=16;d>=9;d--){auto h=p[d];p[d].clear();for(int j=0;j<9;j++)p[d-9+j]=psub(p[d-9+j],pmul(h,mg[j]));}p.resize(9);return p;};
 vector<vector<KP>> targets(maxpower+1,vector<KP>(9));targets[0][0]={1};for(int e=1;e<=maxpower;e++)targets[e]=prod(targets[e-1],lc);
 for(int i=0;i<nr;i++){
 while(rs[i].pos>=0){int p=rs[i].pos,j=own[p];if(j<0){own[p]=i;break;}
 if(rs[i].deg<rs[j].deg){swap(rs[i],rs[j]);tr.push_back({i,j,{},true});}
 auto qr=pdiv(rs[i].a[p],rs[j].a[p]);if(qr.first.empty())throw runtime_error("row quotient empty");
 for(int c=0;c<nc;c++)rs[i].a[c]=psub(rs[i].a[c],pmul(qr.first,rs[j].a[c]));
 rs[i].lead();tr.push_back({i,j,qr.first,false});reductions++;
 }
 done=i+1;
 if(i%9==8||i==nr-1){
 int rank=0,ds=0;for(int j:own)if(j>=0){rank++;ds+=rs[j].deg;}
 fprintf(stderr,"late-linear rows %d rank %d sumdegree %d reductions %ld events %zu\n",done,rank,ds,reductions,tr.size());fflush(stderr);
 // The unlocalized identity d^e avoids discarding any companion q-sheet.
 for(int e=0;rank==63&&e<=maxpower;e++) {MR vv;vv.a.resize(nc);for(int j=0;j<9;j++)vv.a[j]=targets[e][j];vector<pair<int,KP>>st;
 if(redtarget(vv,rs,own,st)){chosen=e;soltrace=move(st);break;}}
 if(chosen>=0)break;
 }
 }
 if(chosen<0){stats[0]=done;stats[1]=reductions;return 1;}
 vector<KP>co(done);for(auto &ev:soltrace)co[ev.first]=padd(co[ev.first],ev.second);
 for(auto it=tr.rbegin();it!=tr.rend();++it){if(it->sw)swap(co[it->i],co[it->j]);else if(!co[it->i].empty())co[it->j]=psub(co[it->j],pmul(co[it->i],it->q));}
 int md=0,nz=0;for(const KP&p:co){md=max(md,(int)p.size()-1);nz+=p.size();}if(md>=cap){stats[0]=done;stats[1]=md;return -3;}
 fill(out,out+(size_t)nr*cap,0);for(int i=0;i<done;i++)copy(co[i].begin(),co[i].end(),out+(size_t)i*cap);
 stats[0]=done;stats[1]=reductions;stats[2]=chosen;stats[3]=md;stats[4]=tr.size();stats[5]=nz;
 return 0;
 }catch(const exception&e){fprintf(stderr,"late-linear module: %s\n",e.what());return -2;}}
