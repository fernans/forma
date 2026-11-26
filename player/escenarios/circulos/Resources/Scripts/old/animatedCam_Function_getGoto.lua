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
   	 -- funcion que nos devuelve el Indice de animacion, segun el movimiento de camara
    -- (-1 si no existe dicho movimiento, o si orig==dest y no es necesaria animacion)
    local r=-1
    
    local pmin=1
    local pmax=1
    
    pmax=application.getCurrentUserEnvironmentVariable ( "numpos" )
    if (pmax==nil) then pmax=1 end
    
    if (orig==dest or orig<pmin or orig>pmax or dest<pmin or dest>pmax) then
        r=-1
    else
        r=(orig-1)*pmax+(dest-1)
    end
    
    log.message ( "goto("..orig..","..dest..")="..r )
    return r
--------------------------------------------------------------------------------
end
--------------------------------------------------------------------------------
