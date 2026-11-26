--------------------------------------------------------------------------------
--  Handler.......... : onSetOffset
--  Author........... : 
--  Description...... : 
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
function animatedCam.onSetOffset ( x,y,z, rx,ry,rz, mode )
--------------------------------------------------------------------------------
	
    object.translate ( this.offset ( ), x,y,z, object.kLocalSpace )
    object.rotate ( this.offset ( ), rx,ry,rz, object.kLocalSpace )
    
    if (mode=="set") then
        object.translate ( this.anim ( ), x,y,z, object.kLocalSpace )
        object.rotate ( this.anim ( ), rx,ry,rz, object.kLocalSpace )
    end
--------------------------------------------------------------------------------
end
--------------------------------------------------------------------------------
