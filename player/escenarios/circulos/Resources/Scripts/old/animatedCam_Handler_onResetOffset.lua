--------------------------------------------------------------------------------
--  Handler.......... : onResetOffset
--  Author........... : 
--  Description...... : 
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
function animatedCam.onResetOffset ( mode )
--------------------------------------------------------------------------------
	object.resetTranslation ( this.offset ( ), object.kParentSpace )
    object.resetRotation ( this.offset ( ), object.kParentSpace )
    --object.rotate ( this.offset ( ), 0,180,0, object.kLocalSpace )

    if (mode=="set") then
        object.resetTranslation ( this.anim ( ), object.kParentSpace )
        object.resetRotation ( this.anim ( ), object.kParentSpace )
        --object.rotate ( this.anim ( ), 0,180,0, object.kLocalSpace )
    end
	
--------------------------------------------------------------------------------
end
--------------------------------------------------------------------------------
