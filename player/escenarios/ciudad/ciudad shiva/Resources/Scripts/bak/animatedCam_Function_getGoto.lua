--------------------------------------------------------------------------------
--  Function......... : getGoto
--  Author........... : 
--  Description...... : 
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
function animatedCam.getGoto ( orig, dest )
--------------------------------------------------------------------------------
	
	 -- funcion que nos devuelve el Indice de animacion, segun el movimiento de camara
    -- (-1 si no existe dicho movimiento, o si orig==dest y no es necesaria animacion)
    local r=-1
    
    
    if (orig==dest or orig<1 or orig>6 or dest<1 or dest>6) then
        r=-1
    else
        r=(orig-1)*6+(dest-1)
    end
    
    log.message ( "goto("..orig..","..dest..")="..r )
    return r
	
--------------------------------------------------------------------------------
end
--------------------------------------------------------------------------------
