--------------------------------------------------------------------------------
--  Function......... : init
--  Author........... : 
--  Description...... : 
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
function animatedCam.init ( )
--------------------------------------------------------------------------------
	
	--
	-- Write your code here, using 'this' as current AI instance.
	--
    local t=this.target ( )
    --activo la animacion_1 (desde pos 1 a 2), y la dejo parada en el frame 0
    log.warning ( "animatedCam.init : animation init" )
    if (t~=nil) then        
        local anim=this.getGoto ( 2, 1 )
        animation.changeClip ( t, 0, anim )
        animation.setPlaybackMode ( t, 0, animation.kPlaybackModeOnce )    
        animation.setPlaybackLevel ( t, 0, 1)
        animation.setPlaybackCursor ( t, 0, animation.getPlaybackKeyFrameEnd ( t, 0 ) )
        animation.setPlaybackSpeed ( t, 0, this.fps() )
        this.currentPlace ( 1 )
    end
--------------------------------------------------------------------------------
end
--------------------------------------------------------------------------------
