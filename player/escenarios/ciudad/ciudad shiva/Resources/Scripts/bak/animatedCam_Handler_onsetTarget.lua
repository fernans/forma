--------------------------------------------------------------------------------
--  Handler.......... : onsetTarget
--  Author........... : 
--  Description...... : 
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
function animatedCam.onsetTarget ( p, t, tanim)
--------------------------------------------------------------------------------
	
	--
	-- Write your code here, using 'this' as current AI instance.
	--
    -- crear nodo raiz (para animaciones)
    --local troot=scene.createRuntimeObject ( application.getCurrentUserScene ( ), "anims/anims" )
    --object.setParent ( troot, t, false ) -- engancharlo al target indicado
    --local tanim=group.getSubObjectAt ( troot, 0 ) --nodo de animacion
    
    -- poner actual (camara) hijo del nodo de parent indicado (p)
    object.resetTranslation ( this.getObject ( ), object.kGlobalSpace )
    object.resetRotation ( this.getObject ( ), object.kGlobalSpace )
    --object.rotate ( this.getObject ( ), 0,-90,0, object.kLocalSpace )
    object.setParent ( this.getObject ( ), p, false )
    
    this.target ( t ) -- guardar referencia al target (animaciones de la camara)
    this.anim ( tanim ) -- guardar referencia al anims maestro (animaciones locales)
    
    -- crear dummy offset (hijo del raiz para animaciones)
    local o=scene.createRuntimeObject ( application.getCurrentUserScene ( ), "anims/dummy" )
    --object.rotate ( o, 0,180,0, object.kLocalSpace )
    this.offset ( o )   -- referencia al dummy para offset
    object.setParent ( o, t, false )
    
    
    object.sendEvent ( tanim, "anims", "onsetTarget", o )
    this.init ( )
    
    log.message ( "camera target, asignado" )
--------------------------------------------------------------------------------
end
--------------------------------------------------------------------------------
