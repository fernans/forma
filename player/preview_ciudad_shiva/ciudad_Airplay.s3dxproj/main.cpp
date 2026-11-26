
//-----------------------------------------------------------------------------
#include "s3eDevice.h"
//-----------------------------------------------------------------------------



//-----------------------------------------------------------------------------
//  ShiVa engine public interface
//-----------------------------------------------------------------------------
#define                 SHIVA_SCREEN_ORIENT_NONE            0
#define                 SHIVA_SCREEN_ORIENT_270             1
#define                 SHIVA_SCREEN_ORIENT_180             2
#define                 SHIVA_SCREEN_ORIENT_90              3
//-----------------------------------------------------------------------------
extern "C" s3eResult    ShiVa_Initialise                    ( const char *filename ) ;
extern "C" void         ShiVa_Terminate                     ( ) ;
extern "C" void         ShiVa_Update                        ( ) ;
extern "C" void         ShiVa_Pause                         ( ) ;
extern "C" void         ShiVa_Resume                        ( ) ;
//-----------------------------------------------------------------------------
extern "C" int          ShiVa_GetScreenOrient               ( ) ;
extern "C" s3eResult    ShiVa_SetScreenOrient               ( int orient ) ;
//-----------------------------------------------------------------------------
extern "C" void         ShiVa_UserEventArgsClear            ( ) ;
extern "C" s3eResult    ShiVa_UserEventArgsPushNumber       ( float       arg ) ;
extern "C" s3eResult    ShiVa_UserEventArgsPushBoolean      ( bool        arg ) ;
extern "C" s3eResult    ShiVa_UserEventArgsPushString       ( const char *arg ) ;
extern "C" s3eResult    ShiVa_UserEventSend                 ( const char *aimodel, const char *handler ) ;
//-----------------------------------------------------------------------------
extern "C" s3eResult    ShiVa_UserEventHookInstall          ( const char *aimodel, const char *handler, s3eCallback fn, void *userData ) ;
extern "C" s3eResult    ShiVa_UserEventHookUninstall        ( const char *aimodel, const char *handler ) ;
extern "C" int          ShiVa_UserEventHookArgsGetCount     ( const void *args ) ;
extern "C" int          ShiVa_UserEventHookArgsGetType      ( const void *args, int index ) ;
extern "C" float        ShiVa_UserEventHookArgsGetNumber    ( const void *args, int index ) ;
extern "C" bool         ShiVa_UserEventHookArgsGetBoolean   ( const void *args, int index ) ;
extern "C" const char  *ShiVa_UserEventHookArgsGetString    ( const void *args, int index ) ;
//-----------------------------------------------------------------------------


//-----------------------------------------------------------------------------
//  Main
//-----------------------------------------------------------------------------

int main ( int argc, char **argv )
{    
	if ( ShiVa_Initialise ( "ciudad.stk" ) == S3E_RESULT_SUCCESS )
    {
        while ( s3eDeviceCheckQuitRequest ( ) == false )
        {
            ShiVa_Update ( ) ;
        }
        
        ShiVa_Terminate ( ) ;
	}
    return 0 ;
}

//-----------------------------------------------------------------------------
