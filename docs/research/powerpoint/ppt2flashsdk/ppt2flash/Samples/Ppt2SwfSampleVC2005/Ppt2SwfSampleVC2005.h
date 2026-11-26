// Ppt2SwfSampleVC2005.h : main header file for the PROJECT_NAME application
//

#pragma once

#ifndef __AFXWIN_H__
	#error "include 'stdafx.h' before including this file for PCH"
#endif

#include "resource.h"		// main symbols


// CPpt2SwfSampleVC2005App:
// See Ppt2SwfSampleVC2005.cpp for the implementation of this class
//

class CPpt2SwfSampleVC2005App : public CWinApp
{
public:
	CPpt2SwfSampleVC2005App();

// Overrides
	public:
	virtual BOOL InitInstance();

// Implementation

	DECLARE_MESSAGE_MAP()
};

extern CPpt2SwfSampleVC2005App theApp;