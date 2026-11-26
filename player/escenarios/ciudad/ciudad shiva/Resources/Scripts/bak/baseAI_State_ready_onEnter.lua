--------------------------------------------------------------------------------
--  State............ : ready
--  Author........... : 
--  Description...... : 
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
function baseAI.ready_onEnter ( )
--------------------------------------------------------------------------------
	log.message ( "ready_onEnter" )
    
    hud.newTemplateInstance ( application.getCurrentUser ( ), "debug", "_" )
    local compo=hud.getComponent ( application.getCurrentUser ( ), "_.text" )
    hud.setLabelText ( compo , "welcome" )
    hud.setComponentVisible ( compo, false )
    this.getSection ( -1, "init" )
    this.indexblock ( -1 ) -- (aun no se ha entrado en el block 0)
    this.index ( -1 ) -- (aun no se ha ejecutado la diapo 0)
    this.postEvent ( 0, "onCmds" ) -- lanzar mensaje para ejecutar cola de comandos
--------------------------------------------------------------------------------
end
--------------------------------------------------------------------------------
