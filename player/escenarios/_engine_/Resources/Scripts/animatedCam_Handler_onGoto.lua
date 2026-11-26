--------------------------------------------------------------------------------
--  Handler.......... : onGoto
--  Author........... : 
--  Description...... : 
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
function animatedCam.onGoto ( place, mode )
--------------------------------------------------------------------------------
	local place=string.toNumber ( place )
    local anim=this.getGoto ( this.currentPlace ( ), place )
    if (anim~=-1) then
        local t=this.target ( )
        log.message ( "set anim: "..anim )
        --activo la animacion correspondiente, y la lanzo
        animation.changeClip ( t, 0, anim )
        animation.setPlaybackMode ( t, 0, animation.kPlaybackModeOnce )    
        animation.setPlaybackLevel ( t, 0, 1)
        if (mode=="set") then -- stop at the end of the animation instantly
            animation.setPlaybackCursor ( t, 0, animation.getPlaybackKeyFrameEnd ( t, 0 ) )
        else -- run the animation smoothly
            animation.setPlaybackSpeed ( t, 0, this.fps() )
        end
        this.currentPlace ( place )
    end
	
--------------------------------------------------------------------------------
end
--------------------------------------------------------------------------------
