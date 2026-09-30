// Close the finite exceptional chart of endpoint_content_mobius.cpp.
// Reuse the received, verified norm/square circuit without modifying it.
#define main archived_square_main
#include "pro_two_sheet_quintic_20260927/two_sheet/src/square.cpp"
#undef main

int main(int argc, char** argv) {
    try {
        if (argc != 4) throw runtime_error("usage: boundary original-evidence mobius-data output");
        F::init();
        filesystem::create_directories(argv[3]);
        ofstream summary(string(argv[3])+"/boundary_summary.txt");
        for (int rc : {145049,211895,211959}) {
            ifstream in(string(argv[2])+"/mobius_"+to_string(rc)+".txt");
            string header; getline(in,header); assert(header=="MOBIUS_V1 H v z unused");
            int r,p,m; in>>r>>p>>m; assert(r==rc);
            LP delta=readLP(in), G=readLP(in);
            vector<LP> a; for(int i=0;i<7;i++) a.push_back(readLP(in));
            PF modulus;
            for(auto[e,c]:delta.a) {
                assert(!e[0]&&!e[2]&&!e[3]&&e[1]>=-8);
                modulus+=PF::mon(e[1]+8,c);
            }
            modulus=modulus*modulus.a.back().inverse();
            assert(modulus.deg()==15 && modulus[0]!=F(0));
            assert(pgcd(modulus,modulus.deriv()).deg()==0);
            QE::setmod(modulus);
            QE v(PF::mon(1)); vector<QE> b;
            for(auto f:a)b.push_back(evaluateLP(f,QE(0),v));
            // B1 is a unit, and the content equation on delta=0 is
            // B^5 times the following linear polynomial in H.
            QE z=b[3]/b[1];
            QE T0=b[4]-b[6]*qpow(z,5)+QE(F(2)*F::raw(m))*qpow(z,2)*b[0];
            QE T1=b[5]+QE(F(2)*F::raw(m))*qpow(z,2)*b[1];
            QE H=-T0/T1, q=QE(F::raw(p))/qpow(v,3);
            QE B=b[0]+b[1]*H,C=b[2]+b[3]*H,E=b[4]+b[5]*H;
            assert(!(qpow(B,5)*E-b[6]*qpow(C,5)+QE(F(2)*F::raw(m))*qpow(B,4)*qpow(C,2)));
            int codes[]={89654,311173,214299,163299,315361,33043,356725,245794};
            QE a0;for(int i=7;i>=0;i--)a0=a0*q+QE(F::raw(codes[i]));
            QE Psi=a0+q*(QE(F::raw(299833))+QE(F::raw(232505))*q)*H;
            QE op=H*B*a0*Psi*(q-QE(F::raw(15383)))*(q-QE(1));
            auto [keep,closed]=split_support(modulus,op.a);
            summary<<rc<<" delta "<<modulus.deg()<<" open "<<keep.deg()<<" closed "<<closed.deg()<<'\n';
            cerr<<rc<<" delta "<<modulus.deg()<<" open "<<keep.deg()<<" closed "<<closed.deg()<<'\n';
            ofstream chart(string(argv[3])+"/boundary_chart_"+to_string(rc)+".txt");
            chart<<"MOBIUS_BOUNDARY_V1 delta H q B1 T1 open closed\n";
            for(auto f:{modulus,H.a,q.a,b[1].a,T1.a,keep,closed})writePF(chart,f);
            if(keep.deg()==0)continue;
            Context ctx;ctx.dir=argv[3];ctx.work=string(argv[3])+"/work";
            filesystem::create_directories(ctx.work);
            ctx.tag=to_string(rc)+"_mobius_boundary";ctx.rc=rc;ctx.modulus=keep;
            QE::setmod(keep);ctx.H=QE(H.a);ctx.q=QE(q.a);
            ctx.E=loadE(argv[1]);
            Bi R=generate(ctx);auto eq=circuit(ctx,R);certify(ctx,eq);
            summary<<rc<<" square excluded\n";
        }
        cout<<"ALL THREE MOBIUS BOUNDARIES EXCLUDED\n";
    } catch(exception&e) {cerr<<"ERROR "<<e.what()<<'\n';return 1;}
}
