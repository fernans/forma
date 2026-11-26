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
    if (t~=nil) then
        animation.changeClip ( t, 0, 0 )
        animation.setPlaybackMode ( t, 0, animation.kPlaybackModeOnce )    
        animation.setPlaybackLevel ( t, 0, 1)
        animation.setPlaybackSpeed ( t, 0, 0 )
        this.currentPlace ( 1 )
    end
--------------------------------------------------------------------------------
end
--------------------------------------------------------------------------------
