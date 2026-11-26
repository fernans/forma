--------------------------------------------------------------------------------
--  Handler.......... : onMouseMove
--  Author........... : 
--  Description...... : 
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
function Main.onMouseMove ( nPointX, nPointY, nDeltaX, nDeltaY, nRayPntX, nRayPntY, nRayPntZ, nRayDirX, nRayDirY, nRayDirZ )
--------------------------------------------------------------------------------
	
	--
	-- Write your code here, using 'this' as current AI instance.
	-- This handler is called when the mouse is moved.
	--
	if (this.cam()~=nil) then
        object.rotate ( this.cam(), 0, -nDeltaX*90, 0, object.kGlobalSpace )
        object.rotate ( this.cam(), nDeltaY*90, 0, 0, object.kLocalSpace )
        hud.setCursorPosition ( application.getCurrentUser ( ), 50, 50 )
    end
--------------------------------------------------------------------------------
end
--------------------------------------------------------------------------------
