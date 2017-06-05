@testset "IO" begin
include("randomOctreeMesh.jl") 
S = randomOctreeMesh( [256, 256, 256], 5 )


meshOut = getOcTreeMeshFV(S, rand(1.:100.0,3); x0=rand(1.:100.0,3))
exportUBCOcTreeMesh("mesh.msh", meshOut)
meshIn = importUBCOcTreeMesh("mesh.msh")
@test meshIn==meshOut

for modelOut in [
    rand(1:0.1:100, meshOut.nc),
    rand(1:0.1:100, meshOut.nc,3),
    rand(1:0.1:100, meshOut.nc,6)]
    
    exportUBCOcTreeModel("model.mod", meshOut, modelOut)
    modelIn = importUBCOcTreeModel("model.mod", meshIn)
    @test modelIn==modelOut  
    
end

for modelOut in [
    rand(Bool, meshOut.nc),
    rand(Bool, meshOut.nc, 3),
    rand(1:100, meshOut.nc),
    rand(1:100, meshOut.nc, 3),
    rand(1:0.1:100, meshOut.nc),
    rand(1:0.1:100, meshOut.nc, 3)]
    
    exportUBCOcTreeModel("model.mod", meshOut, modelOut)
    modelIn = importUBCOcTreeModel("model.mod", meshIn, eltype(modelOut))
    @test modelIn==modelOut
    @test eltype(modelIn)==eltype(modelOut)
    
end

rm("mesh.msh")
rm("model.mod")

end