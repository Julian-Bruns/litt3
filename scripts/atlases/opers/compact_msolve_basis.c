/* Exact, bounded-memory re-encoding of msolve -g2 text over F5.
 * This checks the encoding and reduced-tail shape, NOT the Groebner property.
 * Usage: compact_msolve_basis BASIS STANDARD_EXPONENT_TSV OUTPUT_PREFIX
 * Outputs row-major negative tails (.u8), little-endian packed leading and
 * standard monomials (.lm.u64, .standard.u64), and metadata (.json).
 * Variable i occupies bits [4*i,4*i+3]. No header in binary files.
 */
#define _POSIX_C_SOURCE 200809L
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <ctype.h>
#include <errno.h>
#include <sys/stat.h>
#include <unistd.h>

typedef struct { uint64_t key; size_t value; } Slot;
static void fail(const char *s) { fprintf(stderr,"compact_msolve_basis: %s\n",s); exit(2); }
static void *alloc(size_t n) { void *p=calloc(n,1); if(!p)fail("allocation failed"); return p; }
static uint64_t hash(uint64_t x) { x^=x>>30; x*=UINT64_C(0xbf58476d1ce4e5b9); x^=x>>27; x*=UINT64_C(0x94d049bb133111eb); return x^(x>>31); }
static size_t lookup(Slot *h,size_t mask,uint64_t key) { size_t i=hash(key)&mask; while(h[i].value&&h[i].key!=key)i=(i+1)&mask; return i; }
static unsigned degree(uint64_t k) { unsigned d=0; while(k){d+=(k&15);k>>=4;}return d; }
static int compare(uint64_t a,unsigned da,uint64_t b,unsigned db) { if(da!=db)return da>db?1:-1;return a==b?0:(a<b?1:-1); }
static void putkey(FILE *f,uint64_t k) { unsigned char bytes[8];for(int i=0;i<8;i++)bytes[i]=(unsigned char)(k>>(8*i));if(fwrite(bytes,1,8,f)!=8)fail("binary write failed"); }
static void finish(FILE *f) { if(fflush(f)||fsync(fileno(f))||fclose(f))fail("output flush failed"); }
static char *path(const char *prefix,const char *suffix) { size_t n=strlen(prefix)+strlen(suffix)+1;char *p=alloc(n);snprintf(p,n,"%s%s",prefix,suffix);return p; }
static FILE *newfile(const char *p) { FILE *f=fopen(p,"wx");if(!f)fail("output exists or cannot be created");return f; }

int main(int argc,char **argv) {
    if(argc!=4)fail("usage: compact_msolve_basis BASIS STANDARD_EXPONENT_TSV OUTPUT_PREFIX");
    FILE *in=fopen(argv[1],"r");if(!in)fail("cannot open basis");
    struct stat source_stat;if(fstat(fileno(in),&source_stat))fail("cannot stat basis");
    char *line=NULL,*names[15]={0};size_t cap=0;ssize_t len;int n=0,characteristic=0;size_t expected=0;
    off_t body=0;
    while((len=getline(&line,&cap,in))>=0) {
        if(line[0]!='#'){if(fseeko(in,body,SEEK_SET))fail("seek failed");break;}
        char *p;
        if((p=strstr(line,"#field characteristic:")))characteristic=atoi(p+22);
        if((p=strstr(line,"#length of basis:")))expected=strtoull(p+17,NULL,10);
        if((p=strstr(line,"#variable order:"))) {
            if(n)fail("repeated variable header");char *save=NULL;
            for(char *t=strtok_r(p+16,", \t\r\n",&save);t;t=strtok_r(NULL,", \t\r\n",&save)) {
                if(n==15)fail("more than 15 variables");
                for(int j=0;j<n;j++)if(!strcmp(t,names[j]))fail("duplicate variable name");
                names[n++]=strdup(t);
            }
        }
        body=ftello(in);
    }
    if(characteristic!=5||!n||!expected)fail("missing/invalid F5 basis header");
    FILE *std=fopen(argv[2],"r");if(!std)fail("cannot open standard monomials");
    size_t count=0,capacity=32768;uint64_t *keys=alloc(capacity*sizeof(*keys));
    while((len=getline(&line,&cap,std))>=0) {
        char *p=line;while(isspace((unsigned char)*p))p++;if(!*p||*p=='#')continue;
        uint64_t key=0;
        for(int i=0;i<n;i++) {
            while(isspace((unsigned char)*p))p++;
            if(!isdigit((unsigned char)*p))fail("standard exponent missing");
            char *end;errno=0;unsigned long e=strtoul(p,&end,10);if(errno||e>15)fail("standard exponent exceeds four bits");p=end;key|=(uint64_t)e<<(4*i);
            if(*p&&!isspace((unsigned char)*p))fail("invalid standard separator");
        }
        while(isspace((unsigned char)*p))p++;if(*p)fail("extra standard exponent data");
        if(count&&compare(keys[count-1],degree(keys[count-1]),key,degree(key))>=0)fail("standards not strictly ascending degrevlex");
        if(count==capacity){capacity*=2;uint64_t *q=realloc(keys,capacity*sizeof(*keys));if(!q)fail("allocation failed");keys=q;}
        keys[count++]=key;
    }
    if(ferror(std)||!count)fail("empty/unreadable standard list");fclose(std);
    size_t hsize=1;while(hsize<count*4)hsize*=2;Slot *h=alloc(hsize*sizeof(*h));
    for(size_t i=0;i<count;i++){size_t s=lookup(h,hsize-1,keys[i]);h[s]=(Slot){keys[i],i+1};}
    const char *suffixes[]={".u8",".lm.u64",".standard.u64",".json"};char *final[4],*temp[4];FILE *out[4];
    for(int i=0;i<4;i++){final[i]=path(argv[3],suffixes[i]);if(!access(final[i],F_OK))fail("refusing to replace existing output");temp[i]=path(final[i],".partial");out[i]=newfile(temp[i]);}
    for(size_t i=0;i<count;i++)putkey(out[2],keys[i]);
    uint8_t *row=alloc(count);size_t rows=0;uint64_t terms=0,previous_lm=0;unsigned previous_degree=0;int closed=0,opened=0;
    while((len=getline(&line,&cap,in))>=0) {
        char *p=line;while(isspace((unsigned char)*p))p++;
        if(!*p)continue;
        if(!opened){if(*p!='[')fail("expected opening bracket");p++;opened=1;}
        if(closed)fail("data after closing bracket");
        if(*p==']'){closed=1;p++;if(*p==':')p++;while(isspace((unsigned char)*p))p++;if(*p)fail("data after closing bracket");continue;}
        memset(row,0,count);size_t rowterms=0;uint64_t lm=0;unsigned lmdegree=0;
        for(;;) {
            if(*p<'1'||*p>'4')fail("expected nonzero single-digit F5 coefficient");unsigned coeff=(unsigned)(*p++-'0');
            uint64_t key=0;unsigned d=0;
            while(*p=='*') {
                p++;char *start=p;while(isalnum((unsigned char)*p)||*p=='_')p++;size_t width=(size_t)(p-start);int v=-1;
                for(int i=0;i<n;i++)if(strlen(names[i])==width&&!memcmp(start,names[i],width)){v=i;break;}
                if(v<0||*p++!='^')fail("invalid variable factor");
                if(!isdigit((unsigned char)*p))fail("missing exponent");unsigned e=0;
                while(isdigit((unsigned char)*p)){e=e*10+(unsigned)(*p++-'0');if(e>15)fail("exponent exceeds four bits");}
                if(!e||((key>>(4*v))&15))fail("zero exponent or repeated factor");key|=(uint64_t)e<<(4*v);d+=e;
            }
            if(!rowterms) {
                if(coeff!=1)fail("nonmonic leading coefficient");lm=key;lmdegree=d;
                if(h[lookup(h,hsize-1,lm)].value)fail("leading monomial occurs in standard list");
                if(rows&&compare(previous_lm,previous_degree,lm,lmdegree)>=0)fail("leading monomials not strictly ascending");
            } else {
                if(compare(key,d,lm,lmdegree)>=0)fail("tail is not less than leading monomial");
                size_t s=lookup(h,hsize-1,key);if(!h[s].value)fail("nonstandard tail monomial");size_t col=h[s].value-1;
                if(row[col])fail("duplicate tail monomial");row[col]=(uint8_t)(5-coeff);
            }
            rowterms++;terms++;if(*p=='+'){p++;continue;}break;
        }
        if(*p==',')p++;
        else if(*p==']'){closed=1;p++;if(*p==':')p++;}
        else fail("missing polynomial delimiter");
        while(isspace((unsigned char)*p))p++;if(*p)fail("unexpected data after polynomial");
        if(fwrite(row,1,count,out[0])!=count)fail("row write failed");putkey(out[1],lm);
        previous_lm=lm;previous_degree=lmdegree;rows++;
        if(rows%1000==0)fprintf(stderr,"encoded %zu rows, %llu terms\n",rows,(unsigned long long)terms);
    }
    if(ferror(in)||!closed||rows!=expected)fail("incomplete basis or wrong polynomial count");
    if(fprintf(out[3],"{\n  \"format\": \"msolve-negative-tail-u8-v1\",\n  \"characteristic\": 5,\n  \"variables\": %d,\n  \"rows\": %zu,\n  \"columns\": %zu,\n  \"source_terms\": %llu,\n  \"source_bytes\": %lld,\n  \"matrix_bytes\": %llu,\n  \"coefficient_convention\": \"LM = sum(row[j] * standard[j]) modulo 5\",\n  \"monomial_encoding\": \"uint64 little endian; variable i exponent in bits 4*i through 4*i+3\",\n  \"standard_order\": \"strictly ascending graded reverse lexicographic\",\n  \"validated\": [\"monic leading terms\", \"ascending distinct leading monomials\", \"all tails in supplied standard list\", \"distinct tail terms\", \"tails less than leading term\", \"four-bit exponents\", \"declared polynomial count\"],\n  \"groebner_basis_certified\": false\n}\n",n,rows,count,(unsigned long long)terms,(long long)source_stat.st_size,(unsigned long long)rows*count)<0)fail("metadata write failed");
    for(int i=0;i<4;i++)finish(out[i]);
    for(int i=0;i<4;i++)if(rename(temp[i],final[i]))fail("output rename failed");
    fprintf(stderr,"complete: %zu x %zu, %llu source terms; encoding only, not a GB certificate\n",rows,count,(unsigned long long)terms);
    fclose(in);free(line);free(row);free(keys);free(h);for(int i=0;i<n;i++)free(names[i]);return 0;
}
