--------------------------------------------------------------------------------
--  Handler.......... : onKeyboardKeyDown
--  Author........... : 
--  Description...... : 
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
function loadParser.onKeyboardKeyDown ( kKeyCode )
--------------------------------------------------------------------------------
	
	--
	-- Write your code here, using 'this' as current AI instance.
	-- This handler is called when a keyboard key is pressed.
	--
	if (this.isReady ( )) then
        user.sendEvent ( this.getUser ( ), "baseAI", "onKeyboardKeyDown", kKeyCode )
    end
--------------------------------------------------------------------------------
end
--------------------------------------------------------------------------------
