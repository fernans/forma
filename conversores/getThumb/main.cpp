#include <iostream>
#include <stdlib.h>
#include <sstream>


using namespace std;

int main(int argc, char* argv[])
{
    if (argc!=3 && argc!=5) {
        cout << "Usage:" << endl << argv[0] << " <inputfile> <outputfile> [width height]" << endl;
        return 0;
    }

    std::stringstream command;//=new std::stringstream();

    command << string("ffmpeg -ss 1 -i ");
    command << argv[1] << " ";
    if (argc>3) {
        int w=atoi(argv[3]);
        int h=atoi(argv[4]);
        if (w<1 || h<1) {
            cout << "ERROR rescaling video : ("<<w<<") "<<argv[3]<<" x ("<<h<<") "<<argv[4]<<endl;
            return -1;
        }
        cout << "Rescaling to " << w << "x" << h << endl;
        command << "-s " << w << "x" << h << " ";
    }
        command << argv[2];

    //command << " > null"; //para silenciar la salida

    cout << "Iniciando la conversion..." << endl;
    int r=system(command.str().c_str());
    if (r==0) r=1; else r=-1;
    return r;

}
