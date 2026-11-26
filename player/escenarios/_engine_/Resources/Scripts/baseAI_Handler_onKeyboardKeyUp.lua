--------------------------------------------------------------------------------
--  Handler.......... : onKeyboardKeyUp
--  Author........... : 
--  Description...... : 
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
function baseAI.onKeyboardKeyUp ( kKeyCode )
--------------------------------------------------------------------------------

	--
	-- Write your code here, using 'this' as current AI instance.
	-- This handler is called when a keyboard key is released.
	--

  if (false) then  
    if (kKeyCode == input.kKeyEscape) then
        application.quit ( )
    end
    
    local _doc = xml.getRootElement ( this.doc() )
    if (_doc==nil) then return end
    
	if (kKeyCode == input.kKeyRight or
        kKeyCode == input.kKeyDown  or
        kKeyCode == input.kKeySpace) then
        local t=this.index ( )+1
        log.message ( "siguiente >>> "..t )
        this.sendEvent ( "onGotoSlide", t )
    elseif (kKeyCode == input.kKeyLeft or
            kKeyCode == input.kKeyUp or
            kKeyCode == input.kKeyBackspace) then
        local t=this.index ( )-1
        log.message ( "anterior <<< "..t )
        this.sendEvent ( "onGotoSlide", t )
    elseif (kKeyCode == input.kKeyHome) then
        log.message ( "inicio block<!<" )
        local t=this.indexblock ( )
        local s=this.index ( )
        if (s==0) then t=t-1 end    --si estoy en la slide 0, salto al bloque anterior
        this.sendEvent ( "onGotoSlide", 0, t)
    elseif (kKeyCode == input.kKeyEnd) then
        local t=this.indexblock ( )+1
        log.message ( "siguiente block >!>" )
        this.sendEvent ( "onGotoSlide", 0, t ) --supongo que no habrá tantas slides
    end
  end
--------------------------------------------------------------------------------
end
--------------------------------------------------------------------------------
