#include "quotient.hpp"
int main(int argc,char**argv){try{F::init();string dir=argc>1?argv[1]:"evidence";for(int rc:{145049,211895,211959}){ifstream in(dir+"/elimination_"+to_string(rc)+".txt");string line;getline(in,line);PF resultant=readPF(in),s0=readPF(in),s1=readPF(in);auto [rv,vpart]=split_support(resultant,PF::mon(1));auto [main,bad]=split_support(rv,s1);cerr<<"endpoint "<<rc<<" nonzero v projection "<<rv.deg()<<", main "<<main.deg()<<", degree-drop "<<bad.deg()<<"\n";
 ifstream ei(dir+"/endpoint_"+to_string(rc)+".txt");getline(ei,line);int rr,pc,mc,zc;ei>>rr>>pc>>mc>>zc;vector<LP>l;for(int i=0;i<8;i++)l.push_back(readLP(ei));
 QE::setmod(main);QE v(PF::mon(1)),H=-QE(s0)/QE(s1),q=QE(F::raw(pc))/qpow(v,3);assert(!evaluateLP(l[6],H,v));assert(!evaluateLP(l[7],H,v));
 QE b=evaluateLP(l[1],H,v),bp=evaluateLP(l[1],H,v*QE(F::raw(zc)));QE a0;int codes[]={89654,311173,214299,163299,315361,33043,356725,245794};for(int i=7;i>=0;i--)a0=a0*q+QE(F::raw(codes[i]));QE a1=q*(QE(F::raw(299833))+q*QE(F::raw(232505))),Psi=a0+a1*H;
 QE op=H*b*bp*a0*Psi*(q-QE(F::raw(15383)))*(q-QE(1));auto [keep,closed]=split_support(main,op.a);cerr<<"main open retained dimension "<<keep.deg()<<", excluded closed factor "<<closed.deg()<<", nonreduced gcd degree "<<pgcd(keep,keep.deriv()).deg()<<"\n";
 ofstream out(dir+"/split_"+to_string(rc)+".txt");out<<"SPLIT_V1 nonzero_projection main degree_drop kept closed H s0 s1\n";for(PF p:{rv,main,bad,keep,closed,H.a,s0,s1})writePF(out,p);
 // Degree-drop part: inspect the polynomial ideal without reducing its modulus.
 QE::setmod(bad);PQ f=evaluate_v(l[6],QE(PF::mon(1))),g=evaluate_v(l[7],QE(PF::mon(1)));int steps=0;bool done=false;while(g){PF gg=pgcd(g.a.back().a,bad);if(gg.deg()>0){cerr<<"degree-drop nonunit leading coefficient: H degree "<<g.deg()<<", gcd degree "<<gg.deg()<<"\n";break;}PQ r=f%g;f=g;g=r;steps++;if(!g){cerr<<"degree-drop gcd H degree "<<f.deg()<<", unit divisions "<<steps<<"\n";if(f.deg()==0)done=true;}}
 if(done){auto gu=pgcd(f[0].a,bad);assert(gu.deg()==0);cerr<<"DEGREE-DROP PART EXCLUDED over full modulus (including nilpotents)\n";}
 }
 }catch(exception&e){cerr<<"ERROR "<<e.what()<<"\n";return 1;}}
