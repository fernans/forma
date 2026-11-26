--------------------------------------------------------------------------------
--  Handler.......... : onInit
--  Author........... : 
--  Description...... : 
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
function Main.onInit (  )
--------------------------------------------------------------------------------
	
	--
	-- Write your code here, using 'this' as current AI instance.
	-- This handler is called once, at AI instance initialization.
	--
	application.setCurrentUserScene ( "prueba11" )
    this.cam(application.getCurrentUserActiveCamera ( ))
    hud.setCursorVisible ( application.getCurrentUser ( ), false )
--------------------------------------------------------------------------------
end
--------------------------------------------------------------------------------
