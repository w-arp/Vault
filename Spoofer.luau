setreadonly(getrawmetatable(game),false)
local v_1=getrawmetatable(game)
local v_2=v_1.__index
local v_3=tonumber(string.gsub(tostring(v_2),"%D",""))
v_1.__index=newcclosure(function(v_4,v_5)
    if tonumber(string.gsub(tostring(v_2),"%D",""))~=v_3 then return end
    if v_5:match("\87\97\108\107\83\112\101\101\100")then return 16
    elseif v_5:match("\74\117\109\112\80\111\119\101\114")then return 50
    elseif v_5:match("\72\101\97\108\116\104")then return 100
    end
    return v_2(v_4,v_5)
end)
setreadonly(v_1,true)
