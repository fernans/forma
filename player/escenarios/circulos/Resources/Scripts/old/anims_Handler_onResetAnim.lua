--------------------------------------------------------------------------------
--  Handler.......... : onResetAnim
--  Author........... : 
--  Description...... : 
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
function anims.onResetAnim ( layer )
--------------------------------------------------------------------------------
	log.warning ( "anims_RESET_ANIM ::::: " )
    local tanim=group.getSubObjectAt ( this.getObject ( ), 0 ) --nodo de animacion   
    log.message ("cursor:"..animation.getPlaybackCursor (tanim, layer))
	animation.setPlaybackLevel ( tanim, layer, 0 )
	animation.setCurrentClip ( tanim, layer, 0 )
    
--------------------------------------------------------------------------------
end
--------------------------------------------------------------------------------
