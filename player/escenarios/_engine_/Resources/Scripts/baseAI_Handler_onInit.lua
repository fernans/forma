--------------------------------------------------------------------------------
--  Handler.......... : onInit
--  Author........... : 
--  Description...... : 
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
function baseAI.onInit (  )
--------------------------------------------------------------------------------

    -- configuracion base (ex S3DClient.cfg)
    application.setOption ( application.kOptionSwapInterval, 1 )
    application.setOption ( application.kOptionShadersQuality, 2 )
    application.setOption ( application.kOptionHardwareOcclusion, 1 )
    application.setOption ( application.kOptionTexturesQuality, 1 )
    
    application.setOption (  application.kOptionAutomaticVirtualKeyboard, 1)
    
    --cargar stk de animaciones (anims.stk)
    cache.addFile ( "anims.stk","data/anims.stk" )
    
        local eXml = "doc.xml"
        if (eXml~=nil) then
            -- leer el xml
            log.message ( application.getPackDirectory ( ) )
            xml.receive ( this.doc ( ),"file://"..application.getPackDirectory ( ).."/data/".. eXml )
            this.loading ( )
        else
            this.ready ( )
        end

    
--------------------------------------------------------------------------------
end
--------------------------------------------------------------------------------
