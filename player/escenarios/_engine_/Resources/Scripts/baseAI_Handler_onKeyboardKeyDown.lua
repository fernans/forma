--------------------------------------------------------------------------------
--  Handler.......... : onKeyboardKeyDown
--  Author........... : 
--  Description...... : 
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
function baseAI.onKeyboardKeyDown ( kKeyCode )
--------------------------------------------------------------------------------
	
	--
	-- Write your code here, using 'this' as current AI instance.
	-- This handler is called when a keyboard key is pressed.
	--
    
	if (kKeyCode == input.kKeyEscape) then
        application.quit ( )
    end
    
    local _doc = xml.getRootElement ( this.doc() )
    if (_doc==nil) then return end
    
	if (kKeyCode == input.kKeyRight or
        kKeyCode == input.kKeyDown  or
        kKeyCode == input.kKeyPageDown or
        kKeyCode == input.kKeySpace) then
        local t=this.index ( )+1
        log.message ( "siguiente >>> "..t )
        this.sendEvent ( "onGotoSlide", t )
        this.delayTime ( 0 ) --anular esperas
    elseif (kKeyCode == input.kKeyLeft or
            kKeyCode == input.kKeyUp or
            kKeyCode == input.kKeyPageUp or
            kKeyCode == input.kKeyBackspace) then
        local t=this.index ( )-1
        log.message ( "anterior <<< "..t )
        this.sendEvent ( "onGotoSlide", t )
        this.delayTime ( 0 ) --anular esperas
    elseif (kKeyCode == input.kKeyHome) then
        log.message ( "inicio block<!<" )
        local t=this.indexblock ( )
        local s=this.index ( )
        if (s==0) then t=t-1 end    --si estoy en la slide 0, salto al bloque anterior
        this.sendEvent ( "onGotoSlide", 0, t)
        this.delayTime ( 0 ) --anular esperas
    elseif (kKeyCode == input.kKeyEnd) then
        local t=this.indexblock ( )+1
        log.message ( "siguiente block >!>" )
        this.sendEvent ( "onGotoSlide", 0, t ) --supongo que no habrá tantas slides
        this.delayTime ( 0 ) --anular esperas
    end
    
--------------------------------------------------------------------------------
end
--------------------------------------------------------------------------------
