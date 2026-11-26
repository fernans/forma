--------------------------------------------------------------------------------
--  Handler.......... : onEnterFrame
--  Author........... : 
--  Description...... : 
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
function Main.onEnterFrame (  )
--------------------------------------------------------------------------------
	
	--
	-- Write your code here, using 'this' as current AI instance.
	-- This handler is called every frame.
	--
    
	if (this.cam()~=nil) then 
        local td = application.getLastFrameTime( )
        object.translate ( this.cam(), this.lateral()*this.velocidad()*td, this.vertical()*this.velocidad()*td, this.avanzar()*this.velocidad()*td, object.kLocalSpace )
        
        
    end
--------------------------------------------------------------------------------
end
--------------------------------------------------------------------------------
