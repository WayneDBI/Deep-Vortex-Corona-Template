-- This file is for use with Corona(R) SDK
--
-- This file is automatically generated with PhysicsEdtior (http://physicseditor.de). Do not edit
--
-- Usage example:
--			local scaleFactor = 1.0
--			local physicsData = (require "shapedefs").physicsData(scaleFactor)
--			local shape = display.newImage("objectname.png")
--			physics.addBody( shape, physicsData:get("objectname") )
--

-- copy needed functions to local scope
local unpack = unpack
local _pairs = pairs
--local ipairs = ipairs

local M = {}

function M.physicsData(scale)
	local physics = { data =
	{ 
		
		["wheel1"] = {
                    
                    
                    
                    
                    {
                    pe_fixture_id = "", density = 2, friction = 0, bounce = 0, 
                    filter = { categoryBits = 1, maskBits = 2, groupIndex = 0 },
                    shape = {   -76, -1  ,  -71, -29  ,  -57, -23  ,  -61, -1  }
                    }
                     ,
                    {
                    pe_fixture_id = "", density = 2, friction = 0, bounce = 0, 
                    filter = { categoryBits = 1, maskBits = 2, groupIndex = 0 },
                    shape = {   -71, -29  ,  -54, -54  ,  -29, -70  ,  -44, -43  ,  -57, -23  }
                    }
                     ,
                    {
                    pe_fixture_id = "", density = 2, friction = 0, bounce = 0, 
                    filter = { categoryBits = 1, maskBits = 2, groupIndex = 0 },
                    shape = {   24, -57  ,  -1, -76  ,  29, -70  ,  53, -54  ,  43, -44  }
                    }
                     ,
                    {
                    pe_fixture_id = "", density = 2, friction = 0, bounce = 0, 
                    filter = { categoryBits = 1, maskBits = 2, groupIndex = 0 },
                    shape = {   -29, -70  ,  -23, -56  ,  -44, -43  }
                    }
                     ,
                    {
                    pe_fixture_id = "", density = 2, friction = 0, bounce = 0, 
                    filter = { categoryBits = 1, maskBits = 2, groupIndex = 0 },
                    shape = {   -29, -70  ,  -1, -76  ,  -1, -61  ,  -23, -56  }
                    }
                     ,
                    {
                    pe_fixture_id = "", density = 2, friction = 0, bounce = 0, 
                    filter = { categoryBits = 1, maskBits = 2, groupIndex = 0 },
                    shape = {   -1, -76  ,  24, -57  ,  -1, -61  }
                    }
                    
                    
                    
                     ,
                    
                    
                    {
                    pe_fixture_id = "", density = 2, friction = 0, bounce = 0, 
                    filter = { categoryBits = 1, maskBits = 2, groupIndex = 0 },
                    shape = {   -24, 57  ,  -29, 71  ,  -53, 55  ,  -43, 44  }
                    }
                     ,
                    {
                    pe_fixture_id = "", density = 2, friction = 0, bounce = 0, 
                    filter = { categoryBits = 1, maskBits = 2, groupIndex = 0 },
                    shape = {   -1, 61  ,  28, 70  ,  0, 76  ,  -29, 71  ,  -24, 57  }
                    }
                     ,
                    {
                    pe_fixture_id = "", density = 2, friction = 0, bounce = 0, 
                    filter = { categoryBits = 1, maskBits = 2, groupIndex = 0 },
                    shape = {   23, 56  ,  28, 70  ,  -1, 61  }
                    }
                     ,
                    {
                    pe_fixture_id = "", density = 2, friction = 0, bounce = 0, 
                    filter = { categoryBits = 1, maskBits = 2, groupIndex = 0 },
                    shape = {   43, 44  ,  53, 54  ,  28, 70  ,  23, 56  }
                    }
                     ,
                    {
                    pe_fixture_id = "", density = 2, friction = 0, bounce = 0, 
                    filter = { categoryBits = 1, maskBits = 2, groupIndex = 0 },
                    shape = {   53, 54  ,  43, 44  ,  56, 25  ,  69, 30  }
                    }
                    
                    
                    
		}
		
		, 
		["wheel2"] = {
                    
                    
                    
                    
                    {
                    pe_fixture_id = "", density = 2, friction = 0, bounce = 0, 
                    filter = { categoryBits = 1, maskBits = 2, groupIndex = 0 },
                    shape = {   -24, -57  ,  -53, -54  ,  -74, -77  ,  -42, -99  }
                    }
                     ,
                    {
                    pe_fixture_id = "", density = 2, friction = 0, bounce = 0, 
                    filter = { categoryBits = 1, maskBits = 2, groupIndex = 0 },
                    shape = {   -54, 53  ,  -71, 28  ,  -76, -1  ,  -44, 42  }
                    }
                     ,
                    {
                    pe_fixture_id = "", density = 2, friction = 0, bounce = 0, 
                    filter = { categoryBits = 1, maskBits = 2, groupIndex = 0 },
                    shape = {   23, -58  ,  28, -71  ,  52, -55  ,  42, -45  }
                    }
                     ,
                    {
                    pe_fixture_id = "", density = 2, friction = 0, bounce = 0, 
                    filter = { categoryBits = 1, maskBits = 2, groupIndex = 0 },
                    shape = {   -1, -62  ,  -29, -69  ,  -2, -76  ,  28, -71  ,  23, -58  }
                    }
                     ,
                    {
                    pe_fixture_id = "", density = 2, friction = 0, bounce = 0, 
                    filter = { categoryBits = 1, maskBits = 2, groupIndex = 0 },
                    shape = {   -76, -1  ,  -61, 0  ,  -58, 23  }
                    }
                     ,
                    {
                    pe_fixture_id = "", density = 2, friction = 0, bounce = 0, 
                    filter = { categoryBits = 1, maskBits = 2, groupIndex = 0 },
                    shape = {   -76, -1  ,  -70, -31  ,  -56, -25  ,  -61, 0  }
                    }
                     ,
                    {
                    pe_fixture_id = "", density = 2, friction = 0, bounce = 0, 
                    filter = { categoryBits = 1, maskBits = 2, groupIndex = 0 },
                    shape = {   -70, -31  ,  -53, -54  ,  -44, -44  ,  -56, -25  }
                    }
                     ,
                    {
                    pe_fixture_id = "", density = 2, friction = 0, bounce = 0, 
                    filter = { categoryBits = 1, maskBits = 2, groupIndex = 0 },
                    shape = {   -53, -54  ,  -24, -57  ,  -44, -44  }
                    }
                     ,
                    {
                    pe_fixture_id = "", density = 2, friction = 0, bounce = 0, 
                    filter = { categoryBits = 1, maskBits = 2, groupIndex = 0 },
                    shape = {   -24, -57  ,  -29, -69  ,  -1, -62  }
                    }
                    
                    
                    
                     ,
                    
                    
                    {
                    pe_fixture_id = "", density = 2, friction = 0, bounce = 0, 
                    filter = { categoryBits = 1, maskBits = 2, groupIndex = 0 },
                    shape = {   42, 44  ,  54, 53  ,  30, 69  ,  25, 55  }
                    }
                     ,
                    {
                    pe_fixture_id = "", density = 2, friction = 0, bounce = 0, 
                    filter = { categoryBits = 1, maskBits = 2, groupIndex = 0 },
                    shape = {   54, 53  ,  42, 44  ,  56, 24  ,  70, 30  }
                    }
                    
                    
                    
		}
		
		, 
		["wheel3"] = {
                    
                    
                    
                    
                    {
                    pe_fixture_id = "", density = 2, friction = 0, bounce = 0, 
                    filter = { categoryBits = 1, maskBits = 2, groupIndex = 0 },
                    shape = {   -24, -57  ,  -53, -55  ,  -74, -77  ,  -43, -98  }
                    }
                     ,
                    {
                    pe_fixture_id = "", density = 2, friction = 0, bounce = 0, 
                    filter = { categoryBits = 1, maskBits = 2, groupIndex = 0 },
                    shape = {   23, -57  ,  29, -70  ,  52, -55  ,  43, -44  }
                    }
                     ,
                    {
                    pe_fixture_id = "", density = 2, friction = 0, bounce = 0, 
                    filter = { categoryBits = 1, maskBits = 2, groupIndex = 0 },
                    shape = {   -76, -1  ,  -61, -1  ,  -57, 21  ,  -70, 27  }
                    }
                     ,
                    {
                    pe_fixture_id = "", density = 2, friction = 0, bounce = 0, 
                    filter = { categoryBits = 1, maskBits = 2, groupIndex = 0 },
                    shape = {   -76, -1  ,  -70, -31  ,  -57, -24  ,  -61, -1  }
                    }
                     ,
                    {
                    pe_fixture_id = "", density = 2, friction = 0, bounce = 0, 
                    filter = { categoryBits = 1, maskBits = 2, groupIndex = 0 },
                    shape = {   -70, -31  ,  -53, -55  ,  -44, -44  ,  -57, -24  }
                    }
                     ,
                    {
                    pe_fixture_id = "", density = 2, friction = 0, bounce = 0, 
                    filter = { categoryBits = 1, maskBits = 2, groupIndex = 0 },
                    shape = {   -53, -55  ,  -24, -57  ,  -44, -44  }
                    }
                     ,
                    {
                    pe_fixture_id = "", density = 2, friction = 0, bounce = 0, 
                    filter = { categoryBits = 1, maskBits = 2, groupIndex = 0 },
                    shape = {   -2, -77  ,  29, -70  ,  0, -61  ,  -24, -57  ,  -30, -70  }
                    }
                     ,
                    {
                    pe_fixture_id = "", density = 2, friction = 0, bounce = 0, 
                    filter = { categoryBits = 1, maskBits = 2, groupIndex = 0 },
                    shape = {   0, -61  ,  29, -70  ,  23, -57  }
                    }
                    
                    
                    
                     ,
                    
                    
                    {
                    pe_fixture_id = "", density = 2, friction = 0, bounce = 0, 
                    filter = { categoryBits = 1, maskBits = 2, groupIndex = 0 },
                    shape = {   -13, 36  ,  -1, 37  ,  -1, 76  ,  -29, 71  }
                    }
                     ,
                    {
                    pe_fixture_id = "", density = 2, friction = 0, bounce = 0, 
                    filter = { categoryBits = 1, maskBits = 2, groupIndex = 0 },
                    shape = {   54, 53  ,  29, 70  ,  43, 43  ,  56, 25  ,  69, 29  }
                    }
                     ,
                    {
                    pe_fixture_id = "", density = 2, friction = 0, bounce = 0, 
                    filter = { categoryBits = 1, maskBits = 2, groupIndex = 0 },
                    shape = {   29, 70  ,  -1, 76  ,  23, 57  ,  43, 43  }
                    }
                     ,
                    {
                    pe_fixture_id = "", density = 2, friction = 0, bounce = 0, 
                    filter = { categoryBits = 1, maskBits = 2, groupIndex = 0 },
                    shape = {   -1, 76  ,  -1, 61  ,  23, 57  }
                    }
                    
                    
                    
		}
		
		, 
		["player"] = {
                    
                    
                    
                    
                    {
                    pe_fixture_id = "", density = 2, friction = 0, bounce = 0, 
                    filter = { categoryBits = 2, maskBits = 1, groupIndex = 0 },
                    shape = {   -10, 10  ,  0, -9  ,  10, 10  }
                    }
                    
                    
                    
		}
		
	} }

--[[
        -- apply scale factor
        local s = scale or 1.0
        for bi,body in pairs(physics.data) do
                for fi,fixture in ipairs(body) do
                    if(fixture.shape) then
                        for ci,coordinate in ipairs(fixture.shape) do
                            fixture.shape[ci] = s * coordinate
                        end
                    else
                        fixture.radius = s * fixture.radius
                    end
                end
        end
--]]

        -- apply scale factor
        local s = scale or 1.0
        
        for bi,body in _pairs(physics.data) do
        --for bi=1, #physics.data do
        	--local body = physics.data[bi]
        
                --for fi,fixture in ipairs(body) do
                for fi=1, #body do
        			local fixture = body[fi]

                    if(fixture.shape) then
                        --for ci,coordinate in ipairs(fixture.shape) do
                        for ci=1, #fixture.shape do
         					local coordinate = fixture.shape[ci]
                           fixture.shape[ci] = s * coordinate
                        end
                    else
                        fixture.radius = s * fixture.radius
                    end
                end
        end
	
	function physics:get(name)
		return unpack(self.data[name])
	end

	function physics:getFixtureId(name, index)
                return self.data[name][index].pe_fixture_id
	end
	
	return physics;
end

return M

