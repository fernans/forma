--------------------------------------------------------------------------------
--  Function......... : setAlfa
--  Author........... : 
--  Description...... : 
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
function anims.setAlfa ( alpha )
--------------------------------------------------------------------------------
	
    local tanim=group.getSubObjectAt ( this.getObject ( ), 0 ) --nodo de animacion
    if (tanim~=nil) then --solo si tengo hijos a los que afecte el alpha
        local numhijos=group.getSubObjectCount ( tanim )
        if (numhijos>0) then
            tanim = group.getSubObjectAt ( tanim, 0 ) --nodo modelo tarjeta
            numhijos=group.getSubObjectCount ( tanim )
            if (numhijos>0) then
                for hijo=0, (numhijos-1) do
                    local tanimhijo=group.getSubObjectAt ( tanim, hijo )
                    if (tanimhijo~=nil) then
                        shape.setMeshOpacity ( tanimhijo, alpha )
                    end
                end
            end
        end
    end
    this.currentAlfa ( alpha )
--------------------------------------------------------------------------------
end
--------------------------------------------------------------------------------
