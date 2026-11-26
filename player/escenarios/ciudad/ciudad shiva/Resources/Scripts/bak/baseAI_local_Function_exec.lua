--------------------------------------------------------------------------------
--  Function......... : exec
--  Author........... : 
--  Description...... : 
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
function baseAI_local.exec ( cmd )
--------------------------------------------------------------------------------
    if (cmd~=nil) then
        local name=xml.getElementName ( cmd )
        log.message ( "exec: "..name )
        
        -- parametros generales (o con valor por defecto)
        local id=this.getParamValue ( cmd, "id" )
        if (id==nil) then id=1 end
        local type=this.getParamValue ( cmd, "type" )
        local mode=this.getParamValue ( cmd, "mode" )    
        
        ---------------------------------------------------------------- INIT
            
        if (name=="info") then
            log.message ( "  --info--" )
            return true
        elseif (name=="debug") then
            local show=this.getParamValue ( cmd, "show" )
            if (show~=nil) then
                log.message ( "debug: "..show )
                local compo=hud.getComponent ( application.getCurrentUser ( ), "_.text" )
                if (show=="true") then
                    hud.setComponentVisible ( compo, true )
                else
                    hud.setComponentVisible ( compo, false )
                end
                return true
            else return false
            end
        elseif (name=="loadscn") then
            local scn=this.getParamValue ( cmd, "scene" ) 
            if (scn~=nil) then
                log.message ("loadscn: "..scn)
                if (application.setCurrentUserScene ( scn )) then
                    this.hideTags ()
                    return true
                end
            else return false
            end
        elseif (name=="setScaleFactor") then
            local sfactor=this.getParamValueN ( cmd, "value" )
            if (sfactor~=nil and sfactor~=0) then
                this.scaleFactor ( sfactor )
            end
            log.message ( sfactor )
        
        elseif (name=="goto") then
            local targetBlock=this.getParamValueN ( cmd, "block" )
            if (targetBlock==nil)  then
                targetBlock=this.indexblock ( )
            end
            local targetSlide=this.getParamValueN ( cmd, "slide" )
            if (targetBlock~=nil and targetSlide~=nil) then
                log.message ( "goto: "..targetBlock.."."..targetSlide )
                this.sendEvent ( "onGotoSlide", targetSlide, targetBlock )
            end
        
        elseif (name=="delay") then
            local tiempo=this.getParamValueN ( cmd, "value" )
            if (tiempo~=nil) then
                this.delayTime ( application.getTotalFrameTime ( )+tiempo )
                log.message ( "--- Delay: "..tiempo.." ---" )
            end
        ------------------------------------------------------------------------- PRELOAD
        elseif (name=="preload") then
            -- usa ID
            -- usa TYPE
            local file=this.getParamValue ( cmd, "file" )
            if (type~=nil) then
                if (type=="model") then
                    local model_name=this.getParamValue ( cmd, "model" )
                    if (file~=nil and model_name~=nil) then
                        log.message ( "preload: model ("..id..") "..file )
                        cache.addFile ( id..".stk", file )
                        hashtable.add ( this.modelos ( ), id, model_name )
                        application.forceModelToStayLoaded ( id.."/"..model_name, true )
                    end
                elseif (type=="texture") then
                    local ext=this.getParamValue ( cmd, "ext" )
                    if (file~=nil) then
                        log.message ( "preload: texture ("..id..") "..file) 
                        cache.addFile ( id.."."..ext, file ) --"textures/"
                        hashtable.add ( this.textures(), id, ext ) --"textures/"
                        table.add ( this.cacheList ( ), id.."."..ext )
                    end
                end
            end
        elseif (name=="load") then
            -- esperar hasta que todo en caché esté cargado
            this.waitLoading ( true )
            --application.forceResourceToStayLoaded ( id, application.kResourceTypeTexture, true )
        ------------------------------------------------------------------------- CAMERA
            
        elseif (name=="setcamera") then
            local obj=this.getParamValue ( cmd, "cam_tag" )
            if (obj~=nil) then
                log.message ( "setcamera: "..obj)
                local s=application.getCurrentUserScene ( )
                local cam=( application.getCurrentUserActiveCamera ( ) )
                if (s~=nil and cam~=nil) then
                    -- buscar objeto target (guia camara)
                    local t=scene.getTaggedObject ( s, obj )
                    if (t~=nil) then
                        -- si el objeto indicado tiene un hijo camara (el primero)
                        -- usar como camara actual (para usar su config)
                        local subcamera = group.getSubObjectAt ( t, 0 )
                        if (object.isKindOf ( subcamera, object.kTypeCamera )==true) then
                            --cam=subcamera
                            --application.setCurrentUserActiveCamera ( cam )
                        end
                        -- crear nodo raiz (que seguirá al target) para animaciones
                        local troot=scene.createRuntimeObject ( application.getCurrentUserScene ( ), "anims/anims" )
                        --object.rotate ( troot, 0,180,0, object.kLocalSpace )
                        object.addAIModel ( troot, "anims" )
                        object.setParent ( troot, t, false ) -- engancharlo al target indicado
                        local tanim=group.getSubObjectAt ( troot, 0 ) --nodo de animacion
                        
                        object.addAIModel ( cam, "animatedCam" )
                        object.sendEvent ( cam, "animatedCam", "onsetTarget", tanim, t, troot) --agregar camara real (tanim=ser hijo de, t para anims de camra, troot para anims locales)
                        
                        this.camara ( cam )
                        return true
                    end
                end
            end
        elseif (name=="cameragoto") then
            local place=this.getParamValue ( cmd, "place" )
            if (place~=nil and this.camara ( )~=nil) then
                log.message ( "cameragoto: "..place )
                log.message ( "¿¿¿ PERO QUE ME DICES ???" )
                object.sendEvent ( this.camara ( ), "animatedCam", "onGoto", place)
                return true
            end
        elseif (name=="cameramove") then
            -- usa MODE
            if (this.camara ( )~=nil) then
                local x=this.getParamValueN ( cmd, "x" )
                local y=this.getParamValueN ( cmd, "y" )
                local z=this.getParamValueN ( cmd, "z" )
                local sf=this.scaleFactor ( )
                if (x==nil) then x=0 end
                if (y==nil) then y=0 end
                if (z==nil) then z=0 end
                log.message ( "cameramove: x:"..x.." y:"..y.." z:"..z )
                object.sendEvent ( this.camara ( ), "animatedCam", "onSetOffset", x,y,z, 0,0,0, mode )
            end
        elseif (name=="camerarotate") then
            -- usa MODE
            if (this.camara ( )~=nil) then
                local x=this.getParamValueN ( cmd, "x" )
                local y=this.getParamValueN ( cmd, "y" )
                local z=this.getParamValueN ( cmd, "z" )
                local sf=this.scaleFactor ( )
                if (x==nil) then x=0 end
                if (y==nil) then y=0 end
                if (z==nil) then z=0 end
                log.message ( "camerarotate: x:"..x.." y:"..y.." z:"..z )
                object.sendEvent ( this.camara ( ), "animatedCam", "onSetOffset", 0,0,0, x,y,z, mode )
            end  
        elseif (name=="camerareset") then
            -- usa MODE
            if (this.camara ( )~=nil) then
                log.message ( "camerareset (offset)" )
                object.sendEvent ( this.camara ( ), "animatedCam", "onResetOffset", mode )
            end
        elseif (name=="cameraanimation") then
            -- usa ID
            local t=this.camara ( )
            local anim=this.getParamValueN ( cmd, "anim" )
            if (t~=nil) then
                if (anim==nil) then anim=0 end
                log.message ( "camera animation: "..anim )
                local sf=this.scaleFactor ( )
                local mode=this.getParamValue ( cmd, "mode" )
                local layer=this.getParamValueN ( cmd, "layer" )
                local level=this.getParamValueN ( cmd, "level" )
                local scale=this.getParamValueN ( cmd, "scale" )
                if (scale==nil) then scale=sf else scale=scale*sf end
                local speed=this.getParamValueN ( cmd, "speed" )
                local tanim=object.getAIVariable ( t, "animatedCam", "anim" )
                object.sendEvent ( tanim, "anims", "onSetAnim", anim, mode, layer, level, scale, speed )
            end
        
        
        ------------------------------------------------------------------------- TARJETAS

        elseif (name=="create") then
            -- usa ID
            if (not hashtable.contains ( this.tarjetas ( ), id )) then
                log.message ( "create: ("..id..") " )
                --crear objeto controlador (target y anims)
                local t=scene.createRuntimeObject ( application.getCurrentUserScene ( ), "anims/anims" )
                local target=scene.createRuntimeObject ( application.getCurrentUserScene ( ), "anims/dummy" )
                object.addAIModel ( t, "anims" )
                object.sendEvent ( t, "anims", "onsetTarget", target )
                --almacenar objeto (aun sin marco)
                hashtable.add ( this.tarjetas ( ), id, t )
                hashtable.add ( this.dummies( ), id, target ) --dummy de auto-posicionamiento
                -- correccion de escala (por "scaleFactor")
                -- poner escala a 1 (internamente ya se usa el "scaleFactor"
                local cmdstring="<scale id=\""..id.."\" x=\"1\" y=\"1\" z=\"1\" mode=\"set\" />"
                log.message ( cmdstring )
                xml.createFromString (this.tcmd ( ), cmdstring )
                local _c=xml.getRootElement ( this.tcmd ( ) )
                this.exec ( _c )
            end
            
        elseif (name=="set_model") then
            -- usa ID
            local t=hashtable.get ( this.tarjetas ( ), id )
            local model=this.getParamValue ( cmd, "model" )
            local model_name=hashtable.get ( this.modelos ( ), model )
            if (model~=nil and model_name~=nil and t~=nil) then  
                log.message ( "set_model: ("..id..") "..model_name )
                local tanim=group.getSubObjectAt ( t, 0 ) --nodo de animacion
                --si el objeto(id) ya tiene marco, eliminarselo
                local numhijos=group.getSubObjectCount ( tanim )
                if (numhijos>0) then
                    log.message ( "Eliminando modelo anterior ("..numhijos..")" )
                    for hijo=0, (numhijos-1) do
                        local tanimhijo=group.getSubObjectAt ( tanim, hijo )
                        if (tanimhijo~=nil) then
                            object.setParent ( tanimhijo, nil, false )
                            scene.destroyRuntimeObject ( application.getCurrentUserScene ( ), tanimhijo )
                        end
                    end
                end           
                --crear marco
                local t2=scene.createRuntimeObject ( application.getCurrentUserScene ( ), model.."/"..model_name )
                --enlazar marco al objeto (en el nodo de animacion)
                object.setParent ( t2, tanim, false )
            end
        elseif (name=="set_texture") then
            -- usa ID
            local t=hashtable.get ( this.tarjetas ( ), id )
            local texture=this.getParamValue ( cmd, "texture" )
            local ext=hashtable.get( this.textures ( ), texture)
            if (texture~=nil and ext~=nil and t~=nil) then
                log.message ( "set_texture: ("..id..") "..ext )
                --buscar objeto con geometria
                local tanim=group.getSubObjectAt ( t,0 ) --animacion
                local ttemp=group.getSubObjectAt ( tanim, 0 ) --master de tarjeta (modelo)
                local tgeom=group.getSubObjectAt ( ttemp, 0 ) --geometria
                log.message ( tgeom )
                if (ext=="ogg") then
                    shape.overrideMeshMaterialEffectMap0 ( tgeom, texture, shape.kMapTypeMovie )
                else
                    shape.overrideMeshMaterialEffectMap0 ( tgeom, texture, shape.kMapTypeTexture )
                end
                shape.setMeshSubsetMaterialEffectMap0AdditionalUVScale ( tgeom, 0, 1, 1 )
            end
        elseif (name=="set_texture_video") then
            -- usa ID
            local t=hashtable.get ( this.tarjetas ( ), id )
            if (t~=nil) then
                log.message ( "set texture video: ("..id..")" )
                --buscar objeto con geometria
                local tanim=group.getSubObjectAt ( t,0 ) --animacion
                local ttemp=group.getSubObjectAt ( tanim, 0 ) --master de tarjeta (modelo)
                local tgeom=group.getSubObjectAt ( ttemp, 0 ) --geometria
                log.message ( tgeom )
                shape.overrideMeshMaterialEffectMap0 ( tgeom, "CameraPixelMap", shape.kMapTypePixelMap )
                local tuscale=video.getCaptureWidth ( )/1024
                local tvscale=video.getCaptureHeight ( )/1024
                shape.setMeshSubsetMaterialEffectMap0AdditionalUVScale ( tgeom, 0, tuscale, tvscale )
            end
        
        elseif (name=="set_position") then
            -- usa ID
            -- usa MODE
            local t=hashtable.get ( this.tarjetas ( ), id )
            local d=hashtable.get ( this.dummies ( ), id )
            local targetp=this.getParamValue ( cmd, "target" )
            local target=scene.getTaggedObject ( application.getCurrentUserScene ( ), targetp )
            if (t~=nil and d~=nil and target~=nil) then
                log.message ( "set_position: ("..id..") "..targetp )
                local x,y,z = object.getTranslation ( target, object.kGlobalSpace )
                local rx,ry,rz = object.getRotation ( target, object.kGlobalSpace )                
                object.setTranslation ( d, x,y,z, object.kGlobalSpace )
                object.setRotation ( d, rx,ry,rz, object.kGlobalSpace )
                if (mode~=nil and mode=="set") then
                    -- poner tanto target, como posicion actual de tarjeta
                    object.setTranslation ( t, x,y,z, object.kGlobalSpace )
                    object.setRotation ( t, rx,ry,rz, object.kGlobalSpace )
                end
            end
        
        elseif (name=="move") then
            -- usa ID
            -- usa MODE
            local t=hashtable.get ( this.tarjetas ( ), id )
            local d=hashtable.get ( this.dummies ( ), id )
            local x=this.getParamValueN ( cmd, "x" )
            local y=this.getParamValueN ( cmd, "y" )
            local z=this.getParamValueN ( cmd, "z" )
            local sf=this.scaleFactor ( )
            if (t~=nil and d~=nil) then
                if (x==nil) then x=0 end
                if (y==nil) then y=0 end
                if (z==nil) then z=0 end
                log.message ( "move: ("..id..") x:"..x.." y:"..y.." z:"..z )
                object.translate ( d, x*sf,y*sf,-z*sf, object.kLocalSpace )
                if (mode~=nil and mode=="set") then
                    -- poner tanto target, como posicion actual de tarjeta
                    object.translate ( t, x*sf,y*sf,-z*sf, object.kLocalSpace )
                end
            end
            
        elseif (name=="rotate") then
            -- usa ID
            -- usa MODE
            local t=hashtable.get ( this.tarjetas ( ), id )
            local d=hashtable.get ( this.dummies ( ), id )
            local rx=this.getParamValueN ( cmd, "x" )
            local ry=this.getParamValueN ( cmd, "y" )
            local rz=this.getParamValueN ( cmd, "z" )
            if (t~=nil and d~=nil) then
                if (rx==nil) then rx=0 end
                if (ry==nil) then ry=0 end
                if (rz==nil) then rz=0 end
                log.message ( "rotate: ("..id..") x:"..rx.." y:"..ry.." z:"..rz )
                object.rotate ( d, rx, ry, rz, object.kLocalSpace )
                if (mode~=nil and mode=="set") then
                    -- poner tanto target, como rotacion actual de tarjeta
                    object.rotate ( t, rx, ry, rz, object.kLocalSpace )
                end
            end
            
        elseif (name=="scale") then
            -- usa ID
            -- usa MODE
            local t=hashtable.get ( this.tarjetas ( ), id )
            local d=hashtable.get ( this.dummies ( ), id )
            local sx=this.getParamValueN ( cmd, "x" )
            local sy=this.getParamValueN ( cmd, "y" )
            local sz=this.getParamValueN ( cmd, "z" )
            local sf=this.scaleFactor ( )
            if (t~=nil and d~=nil) then
                if (sx==nil) then sx=1 end
                if (sy==nil) then sy=1 end
                if (sz==nil) then sz=1 end
                log.message ( "scale: ("..id..") x:"..sx.." y:"..sy.." z:"..sz )
                object.setScale ( d, sx*sf, sy*sf, sz*sf )
                if (mode~=nil and mode=="set") then
                    -- poner tanto target, como escala actual de tarjeta
                    object.setScale ( t, sx*sf, sy*sf, sz*sf )
                end
            end     
        elseif (name=="alpha") then
            -- usa ID
            -- usa MODE
            local t=hashtable.get ( this.tarjetas ( ), id )
            local al=this.getParamValueN ( cmd, "level" )
            if (t~=nil) then
                if (al==nil) then al=0 end
                log.message ( "alpha: ("..id..") "..al )
                object.sendEvent ( t, "anims", "onSetAlfa", al, mode )
            end
        elseif (name=="animation") then
            -- usa ID
            local t=hashtable.get ( this.tarjetas ( ), id )
            local anim=this.getParamValueN ( cmd, "anim" )
            if (t~=nil) then
                if (anim==nil) then anim=0 end
                log.message ( "animation: ("..id..") "..anim )
                local sf=this.scaleFactor ( )
                local mode=this.getParamValue ( cmd, "mode" )
                local layer=this.getParamValueN ( cmd, "layer" )
                local level=this.getParamValueN ( cmd, "level" )
                local scale=this.getParamValueN ( cmd, "scale" )
                if (scale==nil) then scale=sf else scale=scale*sf end
                local speed=this.getParamValueN ( cmd, "speed" )
                object.sendEvent ( t, "anims", "onSetAnim", anim, mode, layer, level, scale, speed )
            end
        elseif (name=="delete") then
            -- usa ID
            local t=hashtable.get ( this.tarjetas ( ), id )
            if (t~=nil) then
                --eliminar tarjeta (con su marco enlazado) [y quitar el id de la tabla]
                scene.destroyRuntimeObject ( application.getCurrentUserScene(), t )
                hashtable.remove ( this.tarjetas ( ), id )
                --eliminar el dummy que tenia esta tarjeta
                local d=hashtable.get( this.dummies ( ), id)
                if (d~=nil) then
                    scene.destroyRuntimeObject ( application.getCurrentUserScene(), d )
                    hashtable.remove ( this.dummies ( ), id )
                end
            end
            
        elseif (name=="delete_all") then
            log.message ( "delete_all:" )
            while (not hashtable.isEmpty ( this.tarjetas ( ) )) do
                local id=hashtable.getKeyAt ( this.tarjetas ( ), 0 )
                local cmdstring="<delete id=\""..id.."\" />"
                log.message ( cmdstring )
                xml.createFromString (this.tcmd ( ), cmdstring )
                local _c=xml.getRootElement ( this.tcmd ( ) )
                this.exec ( _c )
            end
            
        ---------------------------------------------------------------------- VARIABLES
        
        elseif (name=="set") then
            -- usa ID
            log.message ( "set variable: "..id)
            local v=this.getParamValue ( cmd, "value" )
            if (v~=nil) then    --set value
                -- buscar variable (si no existe, se añade)
                if (hashtable.contains ( this.variables ( ), id )) then
                    hashtable.set ( this.variables ( ), id, v )
                else
                    hashtable.add ( this.variables ( ), id, v )
                end
            else    -- si value es nil, eliminar variable
                log.message ( "removed" )
                hashtable.remove ( this.variables ( ), id )
            end
            
        ----------------------------------------------------------------------- CAMERA (VIDEO)
        
        elseif (name=="camera") then
            log.message ( "camera(video) setup" )
            local c=this.getParamValue ( cmd, "cmd" )
            if (c~=nil) then
                if (c=="device") then
                    local v=this.getParamValueN ( cmd, "value" )
                    if (v~=nil) then
                        video.setActiveCaptureDevice ( v )
                    end
                elseif (c=="width") then
                    local v=this.getParamValueN ( cmd, "value" )
                    if (v~=nil) then
                        video.setCaptureWidth ( v )
                    end
                elseif (c=="height") then
                    local v=this.getParamValueN ( cmd, "value" )
                    if (v~=nil) then
                        video.setCaptureHeight ( v )
                    end
                elseif (c=="fps") then
                    local v=this.getParamValueN ( cmd, "value" )
                    if (v~=nil) then
                        video.setCaptureRate ( v )
                    end
                elseif (c=="flip") then
                    local v=this.getParamValue ( cmd, "value" )
                    if (v~=nil) then
                        video.setCaptureHorizontalFlip ( v )
                    end
                elseif (c=="start") then
                    video.startCaptureToPixelMap ( "CameraPixelMap" )
                elseif (c=="stop") then
                    video.stopCapture ( )
                end
            end
        
        -------------------------------------------------------------------------- DEBUG
            
        elseif (name=="print") then
            -- usa ID
            log.message ( "print: "..id )
            log.message ( hashtable.get ( this.variables ( ), id ) )
            
        elseif (name=="test") then
            log.message ( "---------------------- preload" )
            local model_id="tarjeta"
            local model_name="tarjeta"
            cache.addFile ( model_id..".stk", "tarjeta.stk" )
            hashtable.add ( this.modelos(), model_id, model_name )
            
            log.message ( "---------------------- create" )
            local t=scene.createRuntimeObject ( application.getCurrentUserScene ( ), model_id.."/"..model_name )
            local tarjeta_id = "1"
            hashtable.add ( this.tarjetas ( ), tarjeta_id, t)
            log.message ( "----------------------" )
            
        elseif (name=="rollback") then
            -- ignorado per se
            
        ------------------------------------------------------------------------------ UNKNOWN    
            
        else
            log.message ( "  comando no reconocido" )
            return true
        end
        return false
    end
--------------------------------------------------------------------------------
end
--------------------------------------------------------------------------------
