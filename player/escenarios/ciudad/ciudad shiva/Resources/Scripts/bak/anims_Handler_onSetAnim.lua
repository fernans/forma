--------------------------------------------------------------------------------
--  Handler.......... : onSetAnim
--  Author........... : 
--  Description...... : 
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
function anims.onSetAnim ( anim, mode, layer, level, scale, speed  )
--------------------------------------------------------------------------------
	
	local tanim=group.getSubObjectAt ( this.getObject ( ), 0 ) --nodo de animacion   
    if (layer==nil) then layer=0 end
    if (anim~=nil and anim~=0) then
        if (mode==nil) then mode="loop" end
        if (level==nil) then level=1 end
        if (speed==nil) then speed=1 end
        animation.setPlaybackCursor ( tanim, layer, 0 )
        animation.setCurrentClip ( tanim, layer, anim )
        animation.setPlaybackLevel ( tanim, layer, level )
        speed=speed*60  --1 normal = 60fps
        animation.setPlaybackSpeed ( tanim, layer, speed )
        local finalMode = animation.kPlaybackModeLoop --default
        if (mode=="once") then finalMode=animation.kPlaybackModeOnce end
        if (mode=="reverse") then finalMode=animation.kPlaybackModeOnceReversed end
        if (mode=="loop") then finalMode=animation.kPlaybackModeLoop end
        if (mode=="loopreverse") then finalMode=animation.kPlaybackModeLoopReversed end
        if (mode=="loopmirror" or mode=="mirror") then finalMode=animation.kPlaybackModeLoopMirrored end
        animation.setPlaybackMode ( tanim, layer, finalMode )
        if (scale~=nil) then --solo si hay "scale" explicitamente, si no... mantener
            -- escalando this (y dummy al contrario), para aplicar escala a la animacion
            if (this.animScale ( )~=1) then
                -- reestablecer scala original, antes de aplicar la nueva
                local trsx,trsy,trsz=object.getScale ( this.getObject ( ) )
                local rscale = this.animScale ( )
                object.setScale ( this.getObject ( ), trsx/rscale, trsy/rscale, trsz/rscale )
                object.setScale ( tanim, 1,1,1 )
            end
            this.animScale ( scale )
            local tsx,tsy,tsz=object.getScale ( this.getObject ( ) )
            object.setScale ( this.getObject ( ), tsx*scale, tsy*scale, tsz*scale )
            local invScale=1/scale
            object.setScale ( tanim, invScale, invScale, invScale )
        end --scale
	else
        -- reset anim
        animation.setPlaybackLevel ( tanim, layer, 1 )
        log.message ( "reset anim layer (" .. layer ..")")
        animation.setPlaybackCursor ( tanim, layer, animation.getPlaybackKeyFrameEnd ( tanim, layer ) )
        animation.setPlaybackSpeed ( tanim, layer, 0 )
        local scale = this.animScale ( )
        if (scale~=nil) then -- reset scale
            local tsx,tsy,tsz=object.getScale ( this.getObject ( ) )
            object.setScale ( this.getObject ( ), tsx/scale, tsy/scale, tsz/scale )
            object.setScale ( tanim, 1,1,1 )
            this.animScale ( 1 )
        end
    end
--------------------------------------------------------------------------------
end
--------------------------------------------------------------------------------
