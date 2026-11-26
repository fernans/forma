--------------------------------------------------------------------------------
--  Handler.......... : onGotoSlide
--  Author........... : 
--  Description...... : 
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
function baseAI.onGotoSlide ( target, targetblock )
--------------------------------------------------------------------------------

    -- indice actual de slide y bloque
    local islide=this.index ( )
    local iblock=this.indexblock ( )
    -- if targetblock es distinto de nil... se fuerza el salto de bloque
    
    -- si avanzamos en el mismo bloque
    if (targetblock==nil) then
        log.message ( ">>>>>>>>>>  "..islide.." -> "..target.." ) >>>>>" )
        local alcanzado=true
        -- solo ejecutar slides
        local step=0
        if (target>islide) then step=1 else step=-1 end
        if (target==-1) then
            -- saltar al bloque anterior, ultimo slide
            alcanzado=false --para forzar salto de bloque
            step=-1 --para forzar al anterior
        else  --buscar slide target
            if (islide==target) then -- solo si indicado explicitamente, repetir el slide que estamos
                this.getSlide( iblock, islide, 1)
                alcanzado=true
            else
                -- avanzar hasta slide target
                islide=islide+step -- la slide actual no se "re-ejecuta"
                for ib=islide, target, step do
                    if this.getSlide ( iblock, ib, step ) then
                        -- existe la slide (actualizo a posible posicion final)
                        this.index ( ib )
                    else
                        alcanzado=false -- no existe el target en este bloque
                    end
                end
            end
        end
        islide=target --consideremos alcanzado el objetivo
        if (alcanzado) then
            -- lanzar mensaje para ejecutar cola de comandos
            this.postEvent ( 0, "onCmds" )
        else
            -- cambio de bloque (forzado, o por llegar al final de bloque sin alcanzar el target)
            if (step==1) then
                -- pasar al siguiente bloque (su diapo 0) (porque en este bloque no se encontró el target)
                log.message ( ">> next block" )
                this.index ( 0 )
                this.sendEvent ( "onGotoSlide", 0, iblock+1  )
            else
                -- pasar al anterior bloque (rollback a su ultima diapo) (target=-1)
                log.message ( ">> previous block" )
                local ultimo=this.getLast(iblock-1) --buscar el ULTIMO slide
                this.index ( 0 ) --tendrá que recorrer todo el bloque desde el inicio
                this.sendEvent ( "onGotoSlide", ultimo, iblock-1 ) 
            end
        end
    end --avanzando dentro del bloque
    
    
    --cambio de bloque
    if (targetblock~=nil) then
        log.message ( ">>>>>>>>>>  "..islide.." -> "..target.."  ( "..iblock.." -> "..targetblock.." ) >>>>>" )
        local origen=iblock
        local alcanzado=false
        local step
        if (iblock==targetblock) then -- repetir el block que estamos
            alcanzado=true
        else
            --buscar el bloque target que exista (en orden) o pararnos antes
            if (targetblock>iblock) then step=1 else step=-1 end
            iblock=iblock+step  --no podemos quedarnos al inicio de nosotros mismos
            for ib=iblock, targetblock, step do
                if this.existsBlock( ib ) then
                    -- existe el bloque (actualizo a posible posicion final)
                    this.indexblock ( ib )
                    alcanzado=true  -- hemos alcanzado un posible bloque target)
                else
                    -- no existe el target
                    break
                end
            end
        end
        iblock=this.indexblock ( )  -- donde he parado en la busqueda
        if (alcanzado) then
            -- nos decantamos por este bloque finalmente
            -- (donde haya parado)
            -- finalizo el bloque de origen
            this.getSection ( origen, "end" )
            -- ejecutar su seccion init
            this.getSection ( iblock, "init" )
            -- ir a su diapo target
            --this.index ( 0 )
            this.sendEvent ( "onGotoSlide", target ) -- sin bloque, para no forzar su init again
        else
            -- buscando el bloque target (distinto del actual)
            -- no me he podido mover mas alla de de mi mismo
            -- ya estoy en el primer, o en el ultimo bloque
            if (step==-1) then
                -- retrocediendo, estoy en el primer bloque
                -- me quedo en el bloque donde estoy --no(reinicio el bloque)
                --IGNORO
                this.postEvent ( 0, "onCmds" )
            else
                -- avanzando, estoy en el ultimo bloque (o al final, nulo)
                if this.existsBlock(iblock) then
                    -- si yo existo, voy al siguiente nulo
                    -- finalizo el bloque de origen
                    this.getSection ( origen, "end" )
                    this.indexblock ( iblock+1)
                    this.index ( 0 )
                else
                    -- si yo ya soy el nulo tras el ultimo
                    -- me quedo como estoy
                    this.index ( 0 )
                end --fin avanzando a nulo
                -- lanzar mensaje para ejecutar cola de comandos
                this.postEvent ( 0, "onCmds" )
            end --fin no me he podido mover
        end --fin target encontrado
    end -- fin cambio de bloque
    
--------------------------------------------------------------------------------
end
--------------------------------------------------------------------------------
