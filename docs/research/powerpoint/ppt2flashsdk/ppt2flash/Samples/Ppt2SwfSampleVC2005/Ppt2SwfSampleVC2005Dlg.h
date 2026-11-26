// Ppt2SwfSampleVC2005Dlg.h : header file
//

#pragma once
#include "afxwin.h"


// CPpt2SwfSampleVC2005Dlg dialog
class CPpt2SwfSampleVC2005Dlg : public CDialog
{
// Construction
public:
	CPpt2SwfSampleVC2005Dlg(CWnd* pParent = NULL);	// standard constructor

// Dialog Data
	enum { IDD = IDD_Ppt2SwfSampleVC2005_DIALOG };

	protected:
	virtual void DoDataExchange(CDataExchange* pDX);	// DDX/DDV support


// Implementation
protected:
	HICON m_hIcon;

	// Generated message map functions
	virtual BOOL OnInitDialog();
	afx_msg void OnSysCommand(UINT nID, LPARAM lParam);
	afx_msg void OnPaint();
	afx_msg HCURSOR OnQueryDragIcon();
	DECLARE_MESSAGE_MAP()
public:
	afx_msg void OnBnClickedButton1();
	afx_msg void OnTcnSelchangeTab1(NMHDR *pNMHDR, LRESULT *pResult);
	CString presentationPath;
	CString folderConvertTo;
	afx_msg void OnBnClickedButton2();
	afx_msg void OnBnClickedButton4();
	CString swfFileName;
	CComboBox m_ComboBox;
	CEdit pptFileEdit;
	CEdit folderEdit;
	CEdit startFileEdit;
	CEdit slidesNameEdit;
	afx_msg void OnBnClickedButton5();
	CString startFile;
	CString slidesName;
public:
	afx_msg void OnBnClickedButton6();
public:
	afx_msg void OnBnClickedButton7();
};
