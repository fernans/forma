--------------------------------------------------------------------------------
--  Handler.......... : onKeyboardKeyDown
--  Author........... : 
--  Description...... : 
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
function Main.onKeyboardKeyDown ( kKeyCode )
--------------------------------------------------------------------------------
	
	--
	-- Write your code here, using 'this' as current AI instance.
	-- This handler is called when a keyboard key is pressed.
	--
	if (kKeyCode == input.kKeyUp or kKeyCode==input.kKeyW) then
        this.avanzar ( -1 )
    end
    if (kKeyCode == input.kKeyDown or kKeyCode==input.kKeyS) then
        this.avanzar ( 1 )
    end
    
    if (kKeyCode == input.kKeyRight or kKeyCode==input.kKeyD) then
        this.lateral ( 1 )
    end
    if (kKeyCode == input.kKeyLeft or kKeyCode==input.kKeyA) then
        this.lateral( -1 )
    end
    
    if (kKeyCode == input.kKeyR) then
        this.vertical ( 1 )
    end
    if (kKeyCode == input.kKeyF) then
        this.vertical ( -1 )
    end
    
    if (kKeyCode == input.kKeyEscape) then
        application.quit ( )
    end
    
    if (kKeyCode == input.kKeyBackspace) then
        application.restart ( )
    end
--------------------------------------------------------------------------------
end
--------------------------------------------------------------------------------
