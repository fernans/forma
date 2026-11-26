#include <iostream>
#include <stdlib.h>
#include <sstream>


using namespace std;

int main(int argc, char* argv[])
{
    if (argc!=3 && argc!=5 && argc!=7) {
        cout << "Usage:" << endl << argv[0] << " <inputfile> <outputfile> [width height] [cropWidth cropHeight]" << endl;
        return 0;
    }

    std::stringstream command;//=new std::stringstream();

    command << string("ffmpeg -y -v 0 -i ");
    command << argv[1];
    command << " -vcodec libtheora -b 9000Kb ";
    if (argc>3) {
        int w=atoi(argv[3]);
        int h=atoi(argv[4]);
        if (w<1 || h<1) {
            cout << "ERROR rescaling video : ("<<w<<") "<<argv[3]<<" x ("<<h<<") "<<argv[4]<<endl;
            return -1;
        }
        cout << "Rescaling to " << w << "x" << h << endl;
        command << " -s " << w << "x" << h << " ";
    }
        command << argv[2];
    if (argc==7) {
        int cw=atoi(argv[5]);
        int ch=atoi(argv[6]);
        int pw=0;   // padding
        int ph=0;   // padding
        cout << "Cropping(or Padding) w:"<< cw << " h:"<<ch<<endl;
        if (cw<0) {pw=-cw;cw=0;}
        if (ch<0) {ph=-ch;ch=0;}
        cw=(int)(cw*0.5); // la mitad para cada lado
        ch=(int)(ch*0.5); // la mitad para cada lado
        pw=(int)(pw*0.5); // la mitad para cada lado
        ph=(int)(ph*0.5); // la mitad para cada lado
        if (cw>0) command << " -cropleft " << cw << " -cropright " << cw;
        if (ch>0) command << " -croptop " << ch << " -cropbottom " << ch;
        if (pw>0) command << " -padleft " << pw << " -padright " << pw;
        if (ph>0) command << " -padtop " << ph << " -padbottom " << ph;
    }

    //command << " > null"; //para silenciar la salida

    cout << "Iniciando la conversion..." << endl;
    int r=system(command.str().c_str());
    if (r==0) r=1; else r=-1;
    return r;

}
