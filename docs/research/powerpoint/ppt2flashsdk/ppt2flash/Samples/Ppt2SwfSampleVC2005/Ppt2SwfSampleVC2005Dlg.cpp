// Ppt2SwfSampleVC2005Dlg.cpp : implementation file
//

#include "stdafx.h"
#include "Ppt2SwfSampleVC2005.h"
#include "Ppt2SwfSampleVC2005Dlg.h"
#import "../Precompiled/Ppt2SwfSdk.tlb"  

#ifdef _DEBUG
#define new DEBUG_NEW
#endif


// CAboutDlg dialog used for App About

class CAboutDlg : public CDialog
{
public:
	CAboutDlg();

	// Dialog Data
	enum { IDD = IDD_ABOUTBOX };

protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support

	// Implementation
protected:
	DECLARE_MESSAGE_MAP()
};

CAboutDlg::CAboutDlg() : CDialog(CAboutDlg::IDD)
{
}

void CAboutDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
}

BEGIN_MESSAGE_MAP(CAboutDlg, CDialog)
END_MESSAGE_MAP()


// CPpt2SwfSampleVC2005Dlg dialog




CPpt2SwfSampleVC2005Dlg::CPpt2SwfSampleVC2005Dlg(CWnd* pParent /*=NULL*/)
: CDialog(CPpt2SwfSampleVC2005Dlg::IDD, pParent)
, presentationPath(_T(""))
, folderConvertTo(_T(""))
, swfFileName(_T(""))
, startFile(_T(""))
, slidesName(_T(""))
{
	m_hIcon = AfxGetApp()->LoadIcon(IDR_MAINFRAME);
}

void CPpt2SwfSampleVC2005Dlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	DDX_Text(pDX, IDC_EDIT2, presentationPath);
	DDX_Text(pDX, IDC_EDIT3, folderConvertTo);
	DDX_Text(pDX, IDC_EDIT4, swfFileName);
	DDX_Control(pDX, IDC_COMBO1, m_ComboBox);
	DDX_Control(pDX, IDC_EDIT5, startFileEdit);
	DDX_Control(pDX, IDC_EDIT6, slidesNameEdit);
	DDX_Text(pDX, IDC_EDIT5, startFile);
	DDX_Text(pDX, IDC_EDIT6, slidesName);
}

BEGIN_MESSAGE_MAP(CPpt2SwfSampleVC2005Dlg, CDialog)
	ON_WM_SYSCOMMAND()
	ON_WM_PAINT()
	ON_WM_QUERYDRAGICON()
	//}}AFX_MSG_MAP
	ON_BN_CLICKED(IDC_BUTTON1, &CPpt2SwfSampleVC2005Dlg::OnBnClickedButton1)
	ON_BN_CLICKED(IDC_BUTTON2, &CPpt2SwfSampleVC2005Dlg::OnBnClickedButton2)
	ON_BN_CLICKED(IDC_BUTTON4, &CPpt2SwfSampleVC2005Dlg::OnBnClickedButton4)
	ON_BN_CLICKED(IDC_BUTTON5, &CPpt2SwfSampleVC2005Dlg::OnBnClickedButton5)
	ON_BN_CLICKED(IDC_BUTTON6, &CPpt2SwfSampleVC2005Dlg::OnBnClickedButton6)
	ON_BN_CLICKED(IDC_BUTTON7, &CPpt2SwfSampleVC2005Dlg::OnBnClickedButton7)
END_MESSAGE_MAP()


// CPpt2SwfSampleVC2005Dlg message handlers

BOOL CPpt2SwfSampleVC2005Dlg::OnInitDialog()
{
	CoInitialize(NULL);

	CDialog::OnInitDialog();

	// Add "About..." menu item to system menu.

	// IDM_ABOUTBOX must be in the system command range.
	ASSERT((IDM_ABOUTBOX & 0xFFF0) == IDM_ABOUTBOX);
	ASSERT(IDM_ABOUTBOX < 0xF000);

	CMenu* pSysMenu = GetSystemMenu(FALSE);
	if (pSysMenu != NULL)
	{
		CString strAboutMenu;
		strAboutMenu.LoadString(IDS_ABOUTBOX);
		if (!strAboutMenu.IsEmpty())
		{
			pSysMenu->AppendMenu(MF_SEPARATOR);
			pSysMenu->AppendMenu(MF_STRING, IDM_ABOUTBOX, strAboutMenu);
		}
	}

	// Set the icon for this dialog.  The framework does this automatically
	//  when the application's main window is not a dialog
	SetIcon(m_hIcon, TRUE);			// Set big icon
	SetIcon(m_hIcon, FALSE);		// Set small icon

	// TODO: Add extra initialization here

	CString tmp;
	tmp = "GIF";
    m_ComboBox.AddString(tmp);	
	tmp = "BMP";
	m_ComboBox.AddString(tmp);
	tmp = "JPG";
	m_ComboBox.AddString(tmp);
	m_ComboBox.SetCurSel(2);
	slidesName = "slides.html";
	startFile = "index.html";
    swfFileName = "Text.swf";
	UpdateData(FALSE);

	return TRUE;  // return TRUE  unless you set the focus to a control
}

void CPpt2SwfSampleVC2005Dlg::OnSysCommand(UINT nID, LPARAM lParam)
{
	if ((nID & 0xFFF0) == IDM_ABOUTBOX)
	{
		CAboutDlg dlgAbout;
		dlgAbout.DoModal();
	}
	else
	{
		CDialog::OnSysCommand(nID, lParam);
	}
}

// If you add a minimize button to your dialog, you will need the code below
//  to draw the icon.  For MFC applications using the document/view model,
//  this is automatically done for you by the framework.

void CPpt2SwfSampleVC2005Dlg::OnPaint()
{
	if (IsIconic())
	{
		CPaintDC dc(this); // device context for painting

		SendMessage(WM_ICONERASEBKGND, reinterpret_cast<WPARAM>(dc.GetSafeHdc()), 0);

		// Center icon in client rectangle
		int cxIcon = GetSystemMetrics(SM_CXICON);
		int cyIcon = GetSystemMetrics(SM_CYICON);
		CRect rect;
		GetClientRect(&rect);
		int x = (rect.Width() - cxIcon + 1) / 2;
		int y = (rect.Height() - cyIcon + 1) / 2;

		// Draw the icon
		dc.DrawIcon(x, y, m_hIcon);
	}
	else
	{
		CDialog::OnPaint();
	}
}

// The system calls this function to obtain the cursor to display while the user drags
//  the minimized window.
HCURSOR CPpt2SwfSampleVC2005Dlg::OnQueryDragIcon()
{
	return static_cast<HCURSOR>(m_hIcon);
}


void CPpt2SwfSampleVC2005Dlg::OnBnClickedButton1()
{
	CFileDialog dlg(TRUE,NULL,L"*.ppt; *.pptx",NULL,L"PowerPoint files (*.ppt; *.pptx)|*.ppt;*.pptx");
	INT_PTR fileResult = dlg.DoModal();

	if (fileResult == IDOK) 
	{
		presentationPath = dlg.GetPathName();
		int index = presentationPath.ReverseFind('\\');
		if(index > 0)
		{
			folderConvertTo = presentationPath.Left(index) + CString("\\converted");
		}
		CString str = dlg.GetFileTitle() + ".swf"; 
		swfFileName = str;
		UpdateData(FALSE);
	}
}



void CPpt2SwfSampleVC2005Dlg::OnBnClickedButton2()
{
	bool FolderSelected = false;

	try
	{
		BROWSEINFO bi;
		memset(&bi, 0, sizeof(bi));

		bi.ulFlags   = BIF_NEWDIALOGSTYLE;
		bi.hwndOwner = this->m_hWnd;
		bi.lpszTitle = L"Choose destination Folder...";
		//Showing dialog
		LPITEMIDLIST pIDL = ::SHBrowseForFolder(&bi);
		//if Folder Choosed proceed
		if(pIDL != NULL)
		{
			TCHAR buffer[33000];
			if(SHGetPathFromIDList(pIDL, buffer) != 0)
			{
				folderConvertTo = buffer;
				UpdateData(FALSE);
			}
		}
	}
	catch (...)
	{
	}
}

void CPpt2SwfSampleVC2005Dlg::OnBnClickedButton4()
{
	UpdateData();
	Ppt2SwfSdk::IPpt2SwfConverterPtr currConvertor(__uuidof(Ppt2SwfSdk::Ppt2SwfConverter));
	if (presentationPath.GetLength() < 0)
		return;
	if (folderConvertTo.GetLength() < 0)
		return;
	UpdateData(FALSE);
	if (swfFileName.GetLength() > 0){
		currConvertor->PutPresentationPath(_bstr_t(presentationPath));
		currConvertor->PutOutputDirectory(_bstr_t(folderConvertTo));
		currConvertor->put_ConvertSlideAnimation(true);
		currConvertor->put_ConvertSlideTransitions(true);
		currConvertor->put_ConvertToExe(true);
		currConvertor->put_EffectOnClick(true);
		currConvertor->put_GenerateXml(true);
		CString swfFile = folderConvertTo + "\\" + swfFileName;
		currConvertor->Convert(_bstr_t(swfFile)); 
		::ShellExecute(NULL, NULL, folderConvertTo, NULL,NULL,SW_SHOWNORMAL);
	}
	else 
		return;
}

void CPpt2SwfSampleVC2005Dlg::OnBnClickedButton5()
{
	UpdateData();
	Ppt2SwfSdk::IThumbnailProducerPtr thumbnailProducer(__uuidof(Ppt2SwfSdk::ThumbnailProducer));
	if (presentationPath.GetLength() < 0)
		return;
	if (folderConvertTo.GetLength() < 0)
		return;
	UpdateData(FALSE);
	
	thumbnailProducer->put_PresentationPath(_bstr_t(presentationPath));
	
	CString str;
	int idx = m_ComboBox.GetCurSel();
	if( idx < 0 ) return;
	m_ComboBox.GetLBText( idx, str );
	thumbnailProducer->put_ImageFormat(_bstr_t(str));
	CString thumbs = folderConvertTo + "\\thumbs";
	thumbnailProducer->put_OutputDirectory(_bstr_t(thumbs));
	thumbnailProducer->put_IndexHTMLName(_bstr_t(startFile));
	thumbnailProducer->put_SlidesHTMLName(_bstr_t(slidesName));
	thumbnailProducer->Produce();
	::ShellExecute(NULL, NULL, folderConvertTo, NULL,NULL,SW_SHOWNORMAL);
}

void CPpt2SwfSampleVC2005Dlg::OnBnClickedButton6()
{
	try
	{
		CString swfFile = folderConvertTo + "\\" + swfFileName;
		::ShellExecute(NULL, NULL, swfFile, NULL,NULL,SW_SHOWNORMAL);
	}
	catch (...)
	{
	}
}

void CPpt2SwfSampleVC2005Dlg::OnBnClickedButton7()
{
	try
	{
		CString swfFile = folderConvertTo + "\\" + swfFileName;
		::ShellExecute(NULL, NULL, L"iexplore.exe", swfFile, NULL,SW_SHOWNORMAL);
	}
	catch (...)
	{
	}
}
