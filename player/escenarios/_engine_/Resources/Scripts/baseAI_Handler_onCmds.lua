--------------------------------------------------------------------------------
--  Handler.......... : onCmds
--  Author........... : 
--  Description...... : 
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
function baseAI.onCmds (  )
--------------------------------------------------------------------------------
	
    if (this.delayTime ( )>0) then
        -- esperar hasta que se llegue al tiempo de espera indicado
        if (this.delayTime ( )<application.getTotalFrameTime ( )) then
            -- resetear el contador de "delayTime"
            this.delayTime ( 0 )
            log.message ( "---Delay end---" )
            -- al proximo Loop, se ejecutará la cola (si existen pendientes)
        end
        this.postEvent ( 0, "onCmds" )
    elseif (this.waitLoading ( )) then
        -- comprobar que todo este cargado
        -- antes de ejecutar mas ordenes
        if (table.getSize ( this.cacheList ( ))<1 ) then
            this.waitLoading ( false )
        else
            local i=0
            while (i<table.getSize ( this.cacheList ( ) )) do
                local file=table.getAt ( this.cacheList ( ), i )
                local s = cache.getFileStatus ( file )
                if (s==1) then
                    log.message ( "Cargado: "..file )
                    --local ind=string.findFirst ( file, ".", 0 )
                    --file = string.getSubString ( file, 0, ind )
                    
                    file = hashtable.get ( this.cacheNames ( ), file )
                    log.message ( file )
                    application.forceResourceToStayLoaded ( file,application.kResourceTypeTexture, true )
                    table.removeAt ( this.cacheList ( ), i )
                    hashtable.remove ( this.cacheNames ( ), file )
                    i=i-1
                end
                i=i+1
            end
        end
        this.postEvent ( 0, "onCmds" )
    else
        -- compruebo que quedan comandos por hacer
        local t=table.getSize ( this.cmds ( ) ) 
        if (t>0) then
            -- ejecutar mensaje de la cola
            log.message ( "onLoop: "..t)
            local _cmds=this.cmds ( )
            local _currcmd = table.getFirst ( _cmds )
            if (_currcmd ~= nil) then
                xml.createFromString (this.tcmd ( ), _currcmd )
                local _c=xml.getRootElement ( this.tcmd ( ) )
                this.exec ( _c )
                table.removeFirst ( _cmds )
            end
            this.sendEvent ( "onCmds" )
        end
        --user.postEvent ( application.getCurrentUser ( ), 1, "baseAI", "onCmds" )

        --this.postEvent ( 0, "onCmds" )

    end
	
--------------------------------------------------------------------------------
end
--------------------------------------------------------------------------------
