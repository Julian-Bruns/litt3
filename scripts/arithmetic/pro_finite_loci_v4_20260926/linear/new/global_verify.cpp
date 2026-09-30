// Independent identities and off-grid evaluations of the global polynomial.
#define main global_interpolation_entry_unused
#include "global_interpolate.cpp"
#undef main
int main(int argc,char**argv){try{
 if(argc!=3)throw std::runtime_error("usage: global_verify ROOT_CODE GENERATED_DIR");input::init();int rr=std::stoi(argv[1]);fs::path out=argv[2];auto c=cramer(reconstruct(F::code(rr)));FRACTION_PIVOT=c.pivot;
 std::vector<LF> cf;for(auto a:c.num)cf.emplace_back(a,1);auto fj=TF_jets(cf);if(fj[6].e!=1)throw std::runtime_error("unexpected reduced denominator");LW theta=fj[6].n.as_q().shift(0,1);LW d=LW::mon(0,1)-LW(c.pivot);
 LW expected=(theta*LW::mon(3,0,F(3)*input::eps.pow(8))).pow(3)*LW::mon(0,48)*d.pow(33);
 std::array<F,4> Hs={F::code(31),F::code(93),F::code(0),F::code(351997)};
 std::array<F,4> ws={F::code(101),F::code(121),F::code(93),F::code(202345)};
 std::array<std::vector<F>,4> eval;for(auto& e:eval)e.resize(NC);
 for(int h=0;h<=72;h++){auto rows=read_rows(out/("N_H_"+std::to_string(h)+".bin"),181,NC);
  for(int q=0;q<=180;q++){F ex=expected.c.count({h,q})?expected.c.at({h,q}):F();if(rows[q][140]!=ex)throw std::runtime_error("global leading coefficient mismatch");for(int l=1;l<7;l++)if(rows[q][l*141+140])throw std::runtime_error("leading coefficient scale dependence");}
  for(int t=0;t<4;t++){F q=ws[t].pow(3),hp=Hs[t].pow(h);std::vector<F> v(NC);for(int j=180;j>=0;j--)for(int col=0;col<NC;col++)v[col]=q*v[col]+rows[j][col];for(int col=0;col<NC;col++)eval[t][col]+=hp*v[col];}
 }
 for(int t=0;t<4;t++){F w=ws[t],q=w.pow(3);auto s=evaluate_source(c,Hs[t],w);auto R=residual(s,F::code(rr));F fac=q.pow(48)*(q-c.pivot).pow(36);for(int l=0;l<7;l++){for(int i=0;i<=140;i++){F want=(l<(int)R.c.size()?R.c[l][i]:F())*fac;if(eval[t][l*141+i]!=want)throw std::runtime_error("off-grid mismatch");}fac*=w;}}
 // Check both DFT lengths directly, with separate dense summation.
 for(int n:{78,208}){Rows v(n,std::vector<F>(3));for(int j=0;j<n;j++)for(int a=0;a<3;a++)v[j][a]=F::code((j*j*97+31*a*j+89*a+3)%kfield::ORDER);F root=F::code(kfield::primitive).pow(kfield::N/n);auto fast=dft(v,root);for(int k=0;k<n;k++)for(int a=0;a<3;a++){F z;for(int j=0;j<n;j++)z+=v[j][a]*root.pow(j*k);if(z!=fast[k][a])throw std::runtime_error("DFT mismatch");}}
 std::ofstream f(out/"verification.json");f<<"{\"r\":"<<rr<<",\"leading_coefficient_all_13213_parameter_coefficients\":true,\"scale_independent_leading_coefficient\":true,\"off_grid_parameter_pairs\":[[31,101],[93,121],[0,93],[351997,202345]],\"off_grid_full_residuals_match\":true,\"DFT_78_and_208_vs_direct_sums\":true,\"square_decision\":\"not_performed\"}\n";
 std::cout<<"r="<<rr<<" PASS: global leading coefficient, four full off-grid residual comparisons, both DFT lengths. No square decision.\n";return 0;
 }catch(std::exception&e){std::cerr<<"ERROR "<<e.what()<<"\n";return 1;}}
