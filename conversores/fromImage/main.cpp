#include <iostream>
#include <stdlib.h>

#include "FreeImage.h"

using namespace std;

FIBITMAP* GenericLoader(const char* lpszPathName, int flag);

int main(int argc, char* argv[])
{
    if (argc!=3 && argc!=5) {
        cout << "Usage:" << endl << argv[0] << " <inputfile> <outputfile> [width height]" << endl;
        return 0;
    }

    //FIBITMAP *bitmap = FreeImage_Load(FIF_BMP, argv[1], BMP_DEFAULT);
    FIBITMAP *bitmap = GenericLoader(argv[1], BMP_DEFAULT);

    if (bitmap) {
        cout << "image successfully loaded! : "<< argv[1] << endl;

        FIBITMAP *newImage;
        if (argc==5) {  //rescale
            int w=atoi(argv[3]);
            int h=atoi(argv[4]);
            if (w<1 || h<1) {
                cout << "ERROR rescaling image : ("<<w<<") "<<argv[3]<< "  x ("<<h<<") "<<argv[4]<<endl;
                return -1;
            }
            cout << "Rescaling to " << w << "x" << h << endl;
            newImage=FreeImage_Rescale(bitmap,w,h,FILTER_BICUBIC);
        } else newImage=bitmap;

        bool saved = FreeImage_Save(FIF_JPEG, newImage, argv[2], JPEG_QUALITYSUPERB);
        if (!saved) {
            cout << "ERROR saving image : " << argv[2] << endl;
            return -1;
        }
        cout << "image successfully saved! : " << argv[2] << endl;
        FreeImage_Unload(bitmap);
        return 1;
    } else {
        cout << "ERROR loading image : " << argv[1] << endl;
        return -1;
    }
}

/** Generic image loader
@param lpszPathName Pointer to the full file name
@param flag Optional load flag constant
@return Returns the loaded dib if successful, returns NULL otherwise
*/
FIBITMAP* GenericLoader(const char* lpszPathName, int flag) {
  FREE_IMAGE_FORMAT fif = FIF_UNKNOWN;
  // check the file signature and deduce its format
  // (the second argument is currently not used by FreeImage)
  fif = FreeImage_GetFileType(lpszPathName, 0);
  if(fif == FIF_UNKNOWN) {
    // no signature ?
    // try to guess the file format from the file extension
    std::cout << "file without signature... try to guess the file format from the file extension" << std::endl;
    fif = FreeImage_GetFIFFromFilename(lpszPathName);
  }
  // check that the plugin has reading capabilities ...
  std::cout << "file type: " << fif << std::endl;
  if((fif != FIF_UNKNOWN) && FreeImage_FIFSupportsReading(fif)) {
    // ok, let's load the file
    FIBITMAP *dib = FreeImage_Load(fif, lpszPathName, flag);
    // unless a bad file format, we are done !
    return dib;
  }
  return NULL;
}
