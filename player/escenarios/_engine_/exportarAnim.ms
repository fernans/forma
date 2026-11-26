function exportarAnim ini fin = (
		flip=false
		if (fin<ini) then (
			swap ini fin
			flip=true
		)
	
		original = animationRange
		animationRange = (interval 0 (fin-ini))
		undo on (
			if (flip) then (
				reverseTime $ ini fin #incLeft #incRight
			)
			deleteTime $ (fin) 5000  -- (fin+1)
			deleteTime $ 0f (ini)     -- (ini-1)
		)
		max file export selected
		max undo
		animationRange = original
	)