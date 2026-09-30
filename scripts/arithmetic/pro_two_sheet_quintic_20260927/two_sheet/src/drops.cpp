#include "quotient.hpp"
struct PQX{PQ g,u,v;};
PQX xgcdq(PQ a,PQ b){PQ u(QE(1)),uu,v,vv(QE(1));while(b){PF fail=pgcd(b.a.back().a,QE::mod);if(fail.deg()>0)throw fail;auto [q,r]=a.divrem(b);a=b;b=r;PQ t=u-q*uu;u=uu;uu=t;t=v-q*vv;v=vv;vv=t;}if(a){PF fail=pgcd(a.a.back().a,QE::mod);if(fail.deg()>0)throw fail;QE unit=a.a.back().inverse();a=a*unit;u=u*unit;v=v*unit;}return {a,u,v};}
void writePQ(ostream&o,const PQ&p){o<<p.a.size()<<"\n";for(auto c:p.a)writePF(o,c.a);}
PQ readPQ(istream&i){int n;i>>n;PQ p;for(int j=0;j<n;j++)p.a.push_back(QE(readPF(i)));p.trim();return p;}
int main(int argc,char**argv){try{F::init();string dir=argc>1?argv[1]:"evidence";for(int rc:{145049,211895,211959}){ifstream sp(dir+"/split_"+to_string(rc)+".txt");string line;getline(sp,line);readPF(sp);readPF(sp);PF bad=readPF(sp);PF rad=bad.exact(pgcd(bad,bad.deriv()));cerr<<"bad degree "<<bad.deg()<<" derivative-gcd "<<pgcd(bad,bad.deriv()).deg()<<" trial rad degree "<<rad.deg()<<"\n";assert(pgcd(rad,rad.deriv()).deg()==0);int nil=1;while(ppow(rad,nil)%bad){nil++;assert(nil<20);}cerr<<"nilpotence exponent "<<nil<<"\n";cerr<<"endpoint "<<rc<<" degree-drop modulus "<<bad.deg()<<" radical "<<rad.deg()<<"; radical nilpotence verified\n";
 ifstream ei(dir+"/endpoint_"+to_string(rc)+".txt");getline(ei,line);int rr,pc,mc,zc;ei>>rr>>pc>>mc>>zc;vector<LP>l;for(int i=0;i<8;i++)l.push_back(readLP(ei));
 vector<PF> todo={rad};int num=0;while(!todo.empty()){PF m=todo.back();todo.pop_back();QE::setmod(m);QE vv(PF::mon(1));PQ f=evaluate_v(l[6],vv),g=evaluate_v(l[7],vv),B=evaluate_v(l[1],vv),Bp=evaluate_v(l[1],vv*QE(F::raw(zc)));
 try{auto eg=xgcdq(f,g);PQ op=B*Bp;auto eo=xgcdq(eg.g,op);PQ retained=eg.g;int n=0;for(;;){auto e=xgcdq(retained,op);if(e.g.deg()==0)break;retained=retained.exact(e.g);n++;}
 cerr<<"drop component base degree "<<m.deg()<<", common H degree "<<eg.g.deg()<<", retained after B B' localization "<<retained.deg()<<", saturation steps "<<n<<"\n";
 if(retained.deg()>0){ofstream out(dir+"/drop_remaining_"+to_string(rc)+"_"+to_string(num)+".txt");out<<"DROP_REMAINING_V1\n";writePF(out,m);writePQ(out,retained);num++;continue;}
 // Produce B^N=Uf+Vg on the reduced base, then lift to the full primary support.
 PQ power(QE(1));int exponent=0;for(;;){auto [q,r]=power.divrem(eg.g);if(!r){PQ U=q*eg.u,V=q*eg.v;assert(U*f+V*g==power);auto [other,thick]=split_support(bad,m);assert(pgcd(thick,other).deg()==0);int nilpow=1;while(ppow(m,nilpow)%thick){nilpow++;assert(nilpow<=nil);}
 // Store reduced coefficients, reinterpret them over the thick algebra, and square-lift.
 vector<PF> ua,va;for(auto c:U.a)ua.push_back(c.a);for(auto c:V.a)va.push_back(c.a);QE::setmod(thick);PQ Ut,Vt;for(auto p:ua)Ut.a.push_back(QE(p));for(auto p:va)Vt.a.push_back(QE(p));Ut.trim();Vt.trim();QE vt(PF::mon(1));PQ ft=evaluate_v(l[6],vt),gt=evaluate_v(l[7],vt),opt=evaluate_v(l[1],vt)*evaluate_v(l[1],vt*QE(F::raw(zc)));PQ pt=ppow(opt,exponent),comb=Ut*ft+Vt*gt,err=pt-comb;assert(!ppow(err,nilpow));PQ mult;for(int ii=0;ii<nilpow;ii++)mult+=ppow(pt,nilpow-1-ii)*ppow(err,ii);Ut=Ut*mult;Vt=Vt*mult;assert(Ut*ft+Vt*gt==ppow(opt,nilpow*exponent));
 ofstream out(dir+"/drop_certificate_"+to_string(rc)+"_"+to_string(num)+".txt");out<<"DROP_CERTIFICATE_V1 (BBprime)^exponent=U J+V Jprime modulo thick\n"<<nilpow*exponent<<"\n";writePF(out,thick);writePQ(out,Ut);writePQ(out,Vt);cerr<<"lifted certificate verified: base dimension "<<thick.deg()<<", open power "<<nilpow*exponent<<"\n";num++;break;}
 power=power*op;exponent++;if(exponent>30)throw runtime_error("drop saturation power exceeded");}
 }catch(const PF&factor){auto [good,zero]=split_support(m,factor);assert(good.deg()>0&&zero.deg()>0&&good.deg()+zero.deg()==m.deg());todo.push_back(good);todo.push_back(zero);cerr<<"splitting degree-drop base into "<<good.deg()<<" + "<<zero.deg()<<"\n";}
 }
 }
 }catch(exception&e){cerr<<"ERROR "<<e.what()<<"\n";return 1;}}
