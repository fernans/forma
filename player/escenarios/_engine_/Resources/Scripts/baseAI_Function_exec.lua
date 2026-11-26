--------------------------------------------------------------------------------
--  Function......... : exec
--  Author........... : 
--  Description...... : 
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
function baseAI.exec ( cmd )
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
        ---[[
        elseif (name=="especial") then
            log.message ( "--- ESPECIAL ---" )
        --]]
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
        elseif (name=="smooth") then
            local d=this.getParamValueN ( cmd, "value" )
            if (d~=nil) then
                this.dvalue ( d )
                log.message ( "Set smooth D value to "..d )
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
                        hashtable.add ( this.cacheNames ( ), id.."."..ext, file )
                    end
                elseif (type=="audio") then
                    if (file~=nil) then
                        log.message ( "preload: audio ("..id..") "..file )
                        cache.addFile ( id..".mus", file ) --"musics/"
                        hashtable.add ( this.audios ( ), id, id )
                        table.add ( this.cacheList ( ), id..".mus" )
                        hashtable.add ( this.cacheNames ( ), id.."."..ext, file )
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
                        object.sendEvent ( cam, "animatedCam", "onSetDValue", this.dvalue ( ))
                        this.camara ( cam )
                        return true
                    end
                end
            end
        elseif (name=="cameragoto") then
            -- usa MODE
            local place=this.getParamValue ( cmd, "place" )
            if (place~=nil and this.camara ( )~=nil) then
                log.message ( "cameragoto: "..place )
                log.message ( mode )
                object.sendEvent ( this.camara ( ), "animatedCam", "onGoto", place, mode)
                return true
            end
        elseif (name=="camerasmooth") then
            local d=this.getParamValueN ( cmd, "value" )
            if (this.camara( )~=nil and d~=nil) then
                object.sendEvent ( this.camara ( ), "animatedCam", "onSetDValue", d)
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
        elseif (name=="camerafov") then
            local f=this.getParamValueN ( cmd, "value" )
            if (this.camara ( )~=nil and f~=nil) then
                camera.setFieldOfView ( this.camara ( ), f*0.5 )
            end
            
        ------------------------------------------------------------------------- FXs
        elseif (name=="fxDepthBlur") then
            local v=this.getParamValueN ( cmd, "value" )
            local vmin=this.getParamValueN ( cmd, "min" )
            local vmax=this.getParamValueN ( cmd, "max" )
            local c=this.camara ( )
            if (c~=nil) then
                if (v~=nil) then
                    camera.setDepthBlurFactor ( c, v )
                    log.message ( "setDepthBlurFactor "..v )
                end
                if (vmin~=nil) then
                    camera.setDepthBlurFocusRangeMin ( c, vmin )
                    log.message ( "setDepthBlurMin "..vmin)
                end
                if (vmax~=nil) then
                    camera.setDepthBlurFocusRangeMax ( c, vmax )
                    log.message ( "setDepthBlurMax "..vmax )
                end
            end
        elseif (name=="fxMotionBlur") then
            local v=this.getParamValueN ( cmd, "value" )
            local c=this.camara ( )
            if (c~=nil and v~=nil) then
                v = math.min(1,v)
                camera.setMotionBlurFactor ( c, v )
                log.message ( "setMotionBlurFactor "..v )
            end
        elseif (name=="fxBloom") then
            local v=this.getParamValueN ( cmd, "value" )
            local t=this.getParamValueN ( cmd, "limit" )
            local co=this.getParamValueN ( cmd, "color" )
            local s=application.getCurrentUserScene ( )
            if (s~=nil) then
                if (v~=nil) then
                    scene.setBloomIntensity ( s, v )
                    log.message ( "setBloom "..v )
                end
                if (t~=nil) then
                    scene.setBloomThreshold ( s, t )
                    log.message ( "setBloomLimit "..t )
                end
                if (co~=nil) then
                    scene.setBloomColoring ( s, co )
                    log.message ( "setBloomColoring "..co )
                end
            end
        elseif (name=="fxFog") then
            local v=this.getParamValueN ( cmd, "value" )
            local n=this.getParamValueN ( cmd, "near" )
            local r=this.getParamValueN ( cmd, "r" )
            local g=this.getParamValueN ( cmd, "g" )
            local b=this.getParamValueN ( cmd, "b" )
            local s=application.getCurrentUserScene ( )
            if (s~=nil) then
                if (v~=nil) then
                    scene.setFogDensity ( s, v )
                    log.message ( "setFog "..v )
                end
                if (n~=nil) then
                    scene.setDistanceFogStart ( s, n )
                    log.message ( "setFogNear "..n )
                end
                if (r~=nil and g~=nil and b~=nil) then
                    scene.setFogColor ( s, r,g,b )
                    log.message ( "setFogRGB "..r..","..g..","..b )
                end
            end
        elseif (name=="fxColorAmbient") then
            local r=this.getParamValueN ( cmd, "r" )
            local g=this.getParamValueN ( cmd, "g" )
            local b=this.getParamValueN ( cmd, "b" )
            local s=application.getCurrentUserScene ( )
            if (s~=nil and r~=nil and g~=nil and b~=nil) then
                scene.setAmbientColor ( s, r,g,b )
                log.message ( "setColorAmbient "..r..","..g..","..b )
            end
        elseif (name=="fxColorContrast") then
            local v=this.getParamValueN ( cmd, "value" )
            local s=application.getCurrentUserScene ( )
            if (s~=nil and v~=nil) then
                scene.setColorContrast ( s, v )
                log.message ( "setColoContrast "..v )
            end
        elseif (name=="fxColorSaturation") then
            local v=this.getParamValueN ( cmd, "value" )
            local r=this.getParamValueN ( cmd, "r" )
            local g=this.getParamValueN ( cmd, "g" )
            local b=this.getParamValueN ( cmd, "b" )
            local s=application.getCurrentUserScene ( )
            if (s~=nil and v~=nil and r~=nil and g~=nil and b~=nil) then
                scene.setColorSaturation ( s, r,g,b, v )
                log.message ( "setColorSaturation "..v.."  "..r..","..g..","..b )
            end
        elseif (name=="fxMonocromo") then
            local v=this.getParamValueN ( cmd, "value" )
            local r=this.getParamValueN ( cmd, "r" )
            local g=this.getParamValueN ( cmd, "g" )
            local b=this.getParamValueN ( cmd, "b" )
            local s=application.getCurrentUserScene ( )
            if (s~=nil and v~=nil and r~=nil and g~=nil and b~=nil) then
                scene.setMonochromeFilter ( s, r,g,b, v )
                log.message ( "setColorMonocromo "..v.."  "..r..","..g..","..b )
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
                object.sendEvent ( t, "anims", "onSetDValue", this.dvalue ( ) )
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
                if (ext=="cam") then
                    -- ajustar scala UV para que el pixelmap capturado ocupe toda la tarjeta
                    local hpm = pixelmap.getResourceHandle ( "parser/CameraPixelMap" )
                    local pmWidth = pixelmap.getWidth ( hpm )
                    local pmHeight = pixelmap.getHeight ( hpm )
                    local tuscale=video.getCaptureWidth ( )/pmWidth  -- 1024
                    local tvscale=video.getCaptureHeight ( )/pmHeight  -- 1024
                    shape.setMeshSubsetMaterialEffectMap0AdditionalUVScale ( tgeom, 0, tuscale, tvscale )
                else
                    -- restaurar scalaUV (por si lo ultimo/anterio fue camara)
                    shape.setMeshSubsetMaterialEffectMap0AdditionalUVScale ( tgeom, 0, 1, 1 )
                end
            end
        elseif (name=="pause_texture") then
            -- usa ID
            local t=hashtable.get ( this.tarjetas ( ), id )
            if (t~=nil) then
                log.message ( "pause_texture: ("..id..") " )
                local tanim=group.getSubObjectAt ( t,0 ) --animacion
                local ttemp=group.getSubObjectAt ( tanim, 0 ) --master de tarjeta (modelo)
                local tgeom=group.getSubObjectAt ( ttemp, 0 ) --geometria
                log.message ( tgeom )
                shape.pauseMeshSubsetMaterialEffectMap0Movie ( tgeom, 0 )
            end
        elseif (name=="play_texture") then
            -- usa ID
            local t=hashtable.get ( this.tarjetas ( ), id )
            if (t~=nil) then
                log.message ( "play_texture: ("..id..") " )
                local tanim=group.getSubObjectAt ( t,0 ) --animacion
                local ttemp=group.getSubObjectAt ( tanim, 0 ) --master de tarjeta (modelo)
                local tgeom=group.getSubObjectAt ( ttemp, 0 ) --geometria
                log.message ( tgeom )
                shape.playMeshSubsetMaterialEffectMap0Movie ( tgeom, 0 )
            end
        elseif (name=="stop_texture") then
            -- usa ID
            local t=hashtable.get ( this.tarjetas ( ), id )
            if (t~=nil) then
                log.message ( "stop_texture: ("..id..") " )
                local tanim=group.getSubObjectAt ( t,0 ) --animacion
                local ttemp=group.getSubObjectAt ( tanim, 0 ) --master de tarjeta (modelo)
                local tgeom=group.getSubObjectAt ( ttemp, 0 ) --geometria
                log.message ( tgeom )
                shape.stopMeshSubsetMaterialEffectMap0Movie ( tgeom, 0 )
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
                user.sendEvent ( this.getUser ( ), "loadParser", "onSetTextureVideo", tgeom )
                
                local hpm = pixelmap.getResourceHandle ( "parser/CameraPixelMap" )
                local pmWidth = pixelmap.getWidth ( hpm )
                local pmHeight = pixelmap.getHeight ( hpm )
                --log.message ( pmWidth )
                --log.message ( pmHeight )
                --log.message ( video.getCaptureWidth ( ) )
                --log.message ( video.getCaptureHeight ( ) )
                local tuscale=video.getCaptureWidth ( )/pmWidth  -- 1024
                local tvscale=video.getCaptureHeight ( )/pmHeight  -- 1024
                shape.setMeshSubsetMaterialEffectMap0AdditionalUVScale ( tgeom, 0, tuscale, tvscale )
                --]]
            end
        elseif (name=="set_smooth") then
            -- usa ID
            local t=hashtable.get ( this.tarjetas ( ), id )
            local d=this.getParamValueN ( cmd, "value" )
            if (t~=nil and d~=nil) then
                object.sendEvent ( t, "anims", "onSetDValue", d )
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
                        log.message ( "device: "..v )
                    end
                elseif (c=="width") then
                    local v=this.getParamValueN ( cmd, "value" )
                    if (v~=nil) then
                        video.setCaptureWidth ( v )
                        log.message ( "width: "..v )
                    end
                elseif (c=="height") then
                    local v=this.getParamValueN ( cmd, "value" )
                    if (v~=nil) then
                        video.setCaptureHeight ( v )
                        log.message ( "height: "..v )
                    end
                elseif (c=="fps") then
                    local v=this.getParamValueN ( cmd, "value" )
                    if (v~=nil) then
                        video.setCaptureRate ( v )
                        log.message ( "fps: "..v )
                    end
                elseif (c=="flip") then
                    local v=this.getParamValue ( cmd, "value" )
                    if (v~=nil) then
                        video.setCaptureHorizontalFlip ( v )
                        log.message ( "Hflip: "..v )
                    end
                elseif (c=="start") then
                    video.startCaptureToPixelMap ( "parser/CameraPixelMap" )
                elseif (c=="stop") then
                    video.stopCapture ( )
                    log.message ( "stopCapture" )
                elseif (c=="capture") then
                    -- usa ID
                    local hpm = pixelmap.getResourceHandle ( "parser/CameraPixelMap" )
                    --pixelmap.lock ( hpm )
                    --local w = pixelmap.getWidth ( hpm )
                    --local h = pixelmap.getHeight ( hpm )
                    --pixelmap.createBrushFromRectangle ( hpm, "tempBrush", 0,h-320, 320,320 )
                    --pixelmap.setFillMode ( hpm, pixelmap.kFillModeBrush )

                    --pixelmap.drawRectangle ( hpm, 0,0, w,h )
                    --pixelmap.destroyBrush ( hpm, "tempBrush" )
                    --pixelmap.unlock ( hpm )
                    
                    pixelmap.saveToTexture ( hpm, id) --"temp" )
                    if (hashtable.contains ( this.textures ( ), id) ) then
                        hashtable.remove ( this.textures ( ), id )
                    end
                    hashtable.add ( this.textures ( ), id, "cam" ) --"textures/"
                    log.message ( "camera capture texture to: "..id )
                end
            end
        -------------------------------------------------------------------------- AUDIO
        elseif (name=="audio_play") then
            -- usa ID
            local v=this.getParamValueN ( cmd, "volume" )
            local f=this.getParamValueN ( cmd, "fade" )
            if (f==nil) then f=0 end
            log.message ( "play audio: "..id.." (fade: "..f.."seg)")
            local musicname = hashtable.get ( this.audios ( ), id )
            if (musicname~=nil) then
                --musicname=musicname..".mus"
                log.message ( "(musicname: "..musicname..")" )
                music.playAdditional ( application.getCurrentUserScene ( ), musicname, f )
            end
            if (v~=nil) then
                log.message ("("..v.."%)" )
                music.setVolume ( application.getCurrentUserScene ( ), v, f )
            end
        elseif (name=="audio_volume") then
            local v=this.getParamValueN ( cmd, "volume" )
            local f=this.getParamValueN ( cmd, "fade" )
            if (f==nil) then f=0 end
            if (v~=nil) then
                log.message ( "audio volume: "..v.."% (fade: "..f.."seg)" )
                music.setVolume ( application.getCurrentUserScene ( ), v, f )
            end
        elseif (name=="audio_stop") then
            local f=this.getParamValueN ( cmd, "fade" )
            if (f==nil) then f=0 end
            log.message ( "audio_stop (fade "..f.."seg)" )
            --music.pause ( application.getCurrentUserScene(), 5 ) --f )
            --music.stop ( application.getCurrentUserScene(), 5 ) --f
            log.message ( "tras audio stop" )
            
        -------------------------------------------------------------------------- HUD
        elseif (name=="2d_create") then
            -- usa ID
            if (not hashtable.contains ( this.huds ( ), id )) then
                log.message ( "create hud: ("..id..") " )
                local hd="hud_"..id
                hud.newComponent ( this.getUser ( ), hud.kComponentTypeContainer, hd )
                hashtable.add ( this.huds ( ), id, hd )
                
                local hComponent = hud.getComponent ( this.getUser(), hd )
            
                hud.setComponentBackgroundColor ( hComponent, 127, 127, 127, 255 )
                hud.setComponentOrigin ( hComponent, hud.kOriginCenter )
                hud.setComponentPosition ( hComponent, 50, 50 )
                hud.setComponentSize ( hComponent, 100, 100 )
                hud.setComponentBorderColor ( hComponent, 0,0,0, 0 ) -- sin borde
                
                --crear hijos del hud
                hud.newComponent ( this.getUser ( ), hud.kComponentTypeMovie, hd.."_movie" )
                local hComponentMovie = hud.getComponent ( this.getUser(), hd.."_movie" )
                hud.setComponentContainer ( hComponentMovie, hComponent )
                hud.setComponentPosition ( hComponentMovie, 50,50 )
                hud.setComponentSize ( hComponentMovie, 100,100 )
                hud.newComponent ( this.getUser ( ), hud.kComponentTypePixelMap, hd.."_pixelmap" )
                local hComponentPixelmap = hud.getComponent ( this.getUser(), hd.."_pixelmap" )
                hud.setComponentContainer ( hComponentPixelmap, hComponent )
                hud.setComponentOrigin ( hComponentPixelmap, hud.kOriginBottomLeft )
                hud.setComponentPosition ( hComponentPixelmap, 0,0 )
                hud.setComponentSize ( hComponentPixelmap, 100,100 )
                hud.setComponentBorderColor ( hComponentPixelmap, 0,0,0, 0 ) -- sin borde
                hud.setComponentBackgroundColor ( hComponentPixelmap, 0, 0, 0, 0 ) --sin fondo
                hud.setComponentForegroundColor ( hComponentPixelmap, 127, 127, 127, 255 ) --luz normal
            end
        elseif (name=="2d_set_position") then
            -- usa ID
            local hd_name=hashtable.get ( this.huds ( ), id )
            if (hd_name~=nil) then
                local hd=hud.getComponent ( this.getUser ( ), hd_name )
                local x=this.getParamValueN ( cmd, "x" )
                local y=this.getParamValueN ( cmd, "y" )
                if (hd~=nil and x~=nil and y~=nil) then
                    hud.setComponentPosition ( hd, x,y )
                end
            end
        elseif (name=="2d_set_size") then
            -- usa ID
            local hd_name=hashtable.get ( this.huds ( ), id )
            if (hd_name~=nil) then
                local hd=hud.getComponent ( this.getUser ( ), hd_name )
                local sx=this.getParamValueN ( cmd, "w" )
                local sy=this.getParamValueN ( cmd, "h" )
                if (hd~=nil and sx~=nil and sy~=nil) then
                    hud.setComponentSize ( hd, sx,sy )
                end
            end
        elseif (name=="2d_set_origin") then
            -- usa ID
            local hd_name=hashtable.get ( this.huds ( ), id )
            if (hd_name~=nil) then
                local hd=hud.getComponent ( this.getUser ( ), hd_name )
                local origin=this.getParamValueN ( cmd, "origin" )
                if (origin=="1") then origin=hud.kOriginTopLeft
                elseif (origin=="2") then origin=hud.kOriginTop
                elseif (origin=="3") then origin=hud.kOriginTopRight
                elseif (origin=="4") then origin=hud.kOriginLeft
                elseif (origin=="5") then origin=hud.kOriginCenter
                elseif (origin=="6") then origin=hud.kOriginRight
                elseif (origin=="7") then origin=hud.kOriginBottomLeft
                elseif (origin=="8") then origin=hud.kOriginBottom
                elseif (origin=="9") then origin=hud.kOriginBottomRight
                end
                if (hd~=nil and origin~=nil) then
                    hud.setComponentOrigin ( hd, origin )
                end
            end
        elseif (name=="2d_set_texture") then
            -- usa ID
            local hd_name=hashtable.get ( this.huds ( ), id )
            if (hd_name~=nil) then
                local hd=hud.getComponent ( this.getUser ( ), hd_name )
                local texture=this.getParamValue ( cmd, "texture" )
                local ext=hashtable.get( this.textures ( ), texture)
                log.message ( "2d_set_texture" )
                log.message ( hd_name )
                if (texture~=nil and ext~=nil and hd~=nil) then
                    if (ext=="ogg") then --video/movie
                        local hdMovie = hud.getComponent ( this.getUser ( ), hd_name.."_movie" )
                        hud.setComponentVisible ( hdMovie, true )
                        hud.setMovieClip ( hdMovie, texture )
                        local hdPixelmap = hud.getComponent ( this.getUser ( ), hd_name.."_pixelmap" )
                        hud.setComponentVisible ( hdPixelmap, false )
                        hud.setPixelMap ( hdPixelmap, "" )
                    else --texturas estaticas
                        hud.setComponentBackgroundImage ( hd, texture )
                        local hdMovie = hud.getComponent ( this.getUser ( ), hd_name.."_movie" )
                        hud.setComponentVisible ( hdMovie, false )
                        hud.stopMovie ( hdMovie )
                        local hdPixelmap = hud.getComponent ( this.getUser ( ), hd_name.."_pixelmap" )
                        hud.setComponentVisible ( hdPixelmap, false ) 
                        hud.setPixelMap ( hdPixelmap, "" )
                        if (ext=="cam") then
                            -- ajustar scala UV para que el pixelmap capturado ocupe toda la tarjeta
                            local hpm = pixelmap.getResourceHandle ( "parser/CameraPixelMap" )
                            local pmWidth = pixelmap.getWidth ( hpm )
                            local pmHeight = pixelmap.getHeight ( hpm )
                            local tuscale=video.getCaptureWidth ( )/pmWidth  -- 1024
                            local tvscale=video.getCaptureHeight ( )/pmHeight  -- 1024
                            hud.setComponentBackgroundImageUVScale ( hd, tuscale, tvscale )
                        else
                            -- restaurar scalaUV (por si lo ultimo/anterio fue camara)
                            hud.setComponentBackgroundImageUVScale ( hd, 1, 1 )
                        end
                    end
                    log.message ( "2d_set_texture: ("..id..") "..ext )
                end
            end
        elseif (name=="2d_pause_texture") then
            --usa ID
            local hd_name=hashtable.get ( this.huds ( ), id )
            if (hd_name~=nil) then
                local hd=hud.getComponent ( this.getUser ( ), hd_name.."_movie" )
                if (hud.isComponentVisible ( hd )) then -- si no esta visible, no se controla ningun movie
                    hud.pauseMovie ( hd )
                end
            end
        elseif (name=="2d_play_texture") then
            --usa ID
            local hd_name=hashtable.get ( this.huds ( ), id )
            if (hd_name~=nil) then
                local hd=hud.getComponent ( this.getUser ( ), hd_name.."_movie" )
                if (hud.isComponentVisible ( hd )) then -- si no esta visible, no se controla ningun movie
                    hud.playMovie ( hd )
                end
            end
        elseif (name=="2d_stop_texture") then
            --usa ID
            local hd_name=hashtable.get ( this.huds ( ), id )
            if (hd_name~=nil) then
                local hd=hud.getComponent ( this.getUser ( ), hd_name.."_movie" )
                if (hud.isComponentVisible ( hd )) then -- si no esta visible, no se controla ningun movie
                    hud.stopMovie ( hd )
                end
            end
        elseif (name=="2d_set_texture_video") then
            -- usa ID
            local hd_name=hashtable.get ( this.huds ( ), id )
            if (hd_name~=nil) then
                local hd=hud.getComponent ( this.getUser ( ), hd_name )
                local hdPixelmap = hud.getComponent ( this.getUser ( ), hd_name.."_pixelmap" )
                hud.setComponentVisible ( hdPixelmap, true )
                hud.setPixelMap ( hdPixelmap, "CameraPixelMap" )
                local hpm = hud.getPixelMap ( hdPixelmap )
                local pmWidth = pixelmap.getWidth ( hpm )
                local pmHeight = pixelmap.getHeight ( hpm )
                local tuscale=pmWidth/video.getCaptureWidth ( )  -- 1024
                local tvscale=pmHeight/video.getCaptureHeight ( )  -- 1024
                --hud.setComponentBackgroundImageUVScale ( hdPixelmap, tuscale, tvscale )
                hud.setComponentSize ( hdPixelmap, tuscale*100, tvscale*100 )
                local hdMovie = hud.getComponent ( this.getUser ( ), hd_name.."_movie" )
                hud.setComponentVisible ( hdMovie, false )
                hud.stopMovie ( hdMovie )
            end
        elseif (name=="2d_set_color") then
            -- usa ID
            local hd_name=hashtable.get ( this.huds ( ), id )
            if (hd_name~=nil) then
                local hd=hud.getComponent ( this.getUser ( ), hd_name )
                local r=this.getParamValueN ( cmd, "r" )
                if (r==nil) then r=127 end
                local g=this.getParamValueN ( cmd, "g" )
                if (g==nil) then g=127 end
                local b=this.getParamValueN ( cmd, "b" )
                if (b==nil) then b=127 end
                local alpha=this.getParamValueN ( cmd, "alpha" )
                if (alpha==nil) then alpha=255 end
                if (hd~=nil) then
                    hud.setComponentBackgroundColor ( hd, r,g,b, alpha )
                end
            end
        elseif (name=="2d_delete") then
            -- usa ID
            local hd_name=hashtable.get ( this.huds ( ), id )
            if (hd_name~=nil) then
                log.message ( "2d_delete : "..hd_name )
                local hd=hud.getComponent ( this.getUser ( ), hd_name )
                if (hd~=nil) then
                    log.message ( "eliminando componente hud")
                    hud.destroyComponent ( hd )
                    hashtable.remove ( this.huds ( ), id )
                end
            end
        elseif (name=="2d_delete_all") then
            log.message ( "2d_delete_all:" )
            while (not hashtable.isEmpty ( this.huds ( ) )) do
                local id=hashtable.getKeyAt ( this.huds ( ), 0 )
                local cmdstring="<2d_delete id=\""..id.."\" />"
                log.message ( cmdstring )
                xml.createFromString (this.tcmd ( ), cmdstring )
                local _c=xml.getRootElement ( this.tcmd ( ) )
                this.exec ( _c )
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
