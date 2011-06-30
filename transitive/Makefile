GHC=/home/davidt/Ghc/safeHaskell2/inplace/bin/ghc-stage2

# should fail as we don't trust the base package when compiling C
# and so B isn't safe anymore since B imports a trustworthy
# module from base.
c:
	${GHC} -c -fforce-recomp A.hs
	${GHC} -c -fforce-recomp B.hs -trust base
	${GHC} -c -fforce-recomp C.hs
	echo "Should fail!"

c2:
	${GHC} -c -fforce-recomp A.hs
	${GHC} -c -fforce-recomp B.hs -trust base
	${GHC} -c -fforce-recomp C.hs -trust base
	${GHC} -c -fforce-recomp C_2.hs -o C2
	echo "Should succeed!"

# should succeed as we do trust the base package when compiling C
# and so B is safe still.
c_trust:
	${GHC} -c -fforce-recomp A.hs
	${GHC} -c -fforce-recomp B.hs -trust base
	${GHC} -c -fforce-recomp C.hs -trust base
	echo "Should succeed!"

## should succeed as we aren't importing B as a safe module
d:
	${GHC} -c -fforce-recomp A.hs
	${GHC} -c -fforce-recomp B.hs -trust base
	${GHC} -c -fforce-recomp D.hs -o d
	echo "Should succeed!"

clean:
	rm *.o
	rm *.hi
	rm C2
	rm D

