--------------------------------------------------------------------------------
--  Handler.......... : onInit
--  Author........... : 
--  Description...... : 
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
function baseAI_local.onInit (  )
--------------------------------------------------------------------------------

    -- configuracion base (ex S3DClient.cfg)
    application.setOption ( application.kOptionSwapInterval, 1 )
    application.setOption ( application.kOptionShadersQuality, 2 )
    application.setOption ( application.kOptionHardwareOcclusion, 1 )
    application.setOption ( application.kOptionTexturesQuality, 1 )
    
    application.setOption (  application.kOptionAutomaticVirtualKeyboard, 1)
    
    --cargar stk de animaciones (anims.stk)
    cache.addFile ( "anims.stk","data/anims.stk" )
    --inicializar xmldoc (desde debug, desde environment, o nulo
    local eDebug = application.getCurrentUserEnvironmentVariable ( "debug" )
    if (eDebug) then
        -- crear xml interno para test particular
        xml.createFromString ( this.doc ( ), "<formacmds />" )
        local _doc=xml.getRootElement ( this.doc ( ) )
        --agregar (al menos) seccion "init"
        local xe=xml.appendElementChild ( _doc, "init", "" )
        local xc=xml.appendElementChild ( xe, "loadscn", "" )
            xml.appendElementAttribute ( xc,"stk", "test.stk") -- archivo stk de escena a cargar
            xml.appendElementAttribute ( xc, "scene", "prueba10" )
        --agregar comandos (en una primera slide)
        -- FIN:(xml interno para test)
        this.ready ( )
    else
        local eXml = application.getCurrentUserEnvironmentVariable ( "xml" )
        if (eXml~=nil) then
            -- leer el xml
            log.message ( application.getPackDirectory ( ) )
            xml.receive ( this.doc ( ),"file://"..application.getPackDirectory ( ).."/data/".. eXml )
            this.loading ( )
        else
            this.ready ( )
        end
    end
    
	
--------------------------------------------------------------------------------
end
--------------------------------------------------------------------------------
