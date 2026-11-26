--------------------------------------------------------------------------------
--  State............ : loading
--  Author........... : 
--  Description...... : 
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
function baseAI_local.loading_onLoop ( )
--------------------------------------------------------------------------------
	
	--
	-- Write your code here, using 'this' as current AI instance.
	--
    local readyDoc=false
    local readyAnims=false
    
    local v=xml.getReceiveStatus ( this.doc ( ) )
    log.message ( "doc.xml: "..v.."%" )
    if (v==1) then
        readyDoc=true
    elseif (v<0) then
        log.error ( "ERROR CARGANDO XML" )
    end
    
    local a=cache.getFileStatus ( "anims.stk" )
    log.message ( "anims: "..a.."%" )
    if (a==1) then
        readyAnims=true
    elseif (a<0) then
        log.error ( "ERROR CARGANDO ANIMS.STK" )
    end
    
    if (readyDoc==true and readyAnims==true) then
        this.ready ( )
    end
--------------------------------------------------------------------------------
end
--------------------------------------------------------------------------------
