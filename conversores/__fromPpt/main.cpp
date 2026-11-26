#include <iostream>

using namespace std;

#import "Ppt2FlashSdk.tlb"

int main()
{
    cout << "Hello world!" << endl;

    printf("%u --- \n",  __uuidof(Ppt2FlashSdk::IThumbnailProducer) );
    //printf("%ud --- \n",__uuidof(Ppt2SwfSdk::ThumbnailProducer));
    //Ppt2SwfSdk::IThumbnailProducerPtr thumbnailProducer();


      //__uuidof(Ppt2FlashSdk::ThumbnailProducer);
      //Ppt2FlashSdk::IThumbnailProducerPtr a;

    //Ppt2FlashSdk::IThumbnailProducerPtr a();
      Ppt2FlashSdk::IThumbnailProducerPtr a(__uuidof(Ppt2FlashSdk::ThumbnailProducer));

    //Ppt2SwfSdk::IThumbnailProducerPtr thumbnailProducer(__uuidof(Ppt2SwfSdk::ThumbnailProducer));
	//if (presentationPath.GetLength() < 0)
	//	return;
	//if (folderConvertTo.GetLength() < 0)
	//	return;
	//UpdateData(FALSE);

	//thumbnailProducer->put_PresentationPath(_bstr_t(presentationPath));

	//CString str;
	//int idx = m_ComboBox.GetCurSel();
	//if( idx < 0 ) return;
	//m_ComboBox.GetLBText( idx, str );
	//thumbnailProducer->put_ImageFormat(_bstr_t(str));
	//CString thumbs = folderConvertTo + "\\thumbs";
	//thumbnailProducer->put_OutputDirectory(_bstr_t(thumbs));
	//thumbnailProducer->put_IndexHTMLName(_bstr_t(startFile));
	//thumbnailProducer->put_SlidesHTMLName(_bstr_t(slidesName));
	//thumbnailProducer->Produce();


    return 0;
}
